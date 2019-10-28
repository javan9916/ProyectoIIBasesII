CREATE DATABASE Bus;

--SECUENCIAS NUMERICAS--
--Para el codigo de buses 
create sequence sec_buses
	minvalue 0
	increment by 1;
--SECUENCIAS NUMERICAS--

------- TABLAS -------
--drop table bus
-- Tabla bus --
create table Bus(
	codigo			serial,
	tipo_vehiculo	char(1)	     not null default 'B',
	ruta 			varchar(200) not null,
	
	constraint pk_codigo_bus
		primary key	(codigo)
);

-- Tabla de usuarios --
create table usuarios
(
	codigo serial,
	nombre varchar(200) not null,
	
	constraint pk_codigo_usuario
		primary key	(codigo)
);

create extension postgis;

--drop table rastreo_Bus
-- Tabla de rastreos del bus --
create table rastreo_Bus 
(
	codigo 		serial,
	usuario 	int 	  not null,
	vehiculo 	int  	  not null,
	fecha 		timestamp default now()::timestamp(0),
	estado 		smallint  not null default(1),
	
	constraint pk_codigo_rastreo_buses
		primary key	(codigo),
	constraint fk_usuario_rastreo_buses
		foreign key	(usuario) references usuarios on update cascade,
	constraint fk_bus_rastreo_buses
		foreign key	(vehiculo) references bus on update cascade
);

SELECT AddGeometryColumn ('public','rastreo_bus','geom',4326,'POINT',2,false);
------- TABLAS -------

----PROCEDIMIENTOS ALMACENADOS PARA CREACIÓN----
-- Procedimiento para agregar tren en su tabla --
create or replace function agregar_bus(v_ruta varchar(200)) returns void
as
$$ 
	begin
	insert into Bus (codigo, ruta)
		values (nextval('sec_buses'),v_ruta);
	exception
  		when others then 
  		raise notice 'Error: %',SQLERRM;
  	end;
$$
language plpgsql;
----PROCEDIMIENTOS ALMACENADOS PARA CREACIÓN----

--PROCEDIMIENTOS ALMACENADOS PARA GRUARDAR UNA RUTA--
create or replace function agregar_ruta(
	tipo varchar,
	usuario varchar,
	vehiculo varchar,
	x numeric, 
	y numeric
) returns void
as
$$ 
	declare 
		TablaVehiculo varchar = lower(''||tipo||'');
		codigoVehiculo integer;
		codigoUsuario integer;
		cantidadVehiculo numeric;
		cantidadUsuario numeric;
	begin
	
		EXECUTE format('
					   select count(*) from '||TablaVehiculo||'
					   where ruta = '''||vehiculo||''' ')
		INTO cantidadVehiculo;
		IF cantidadVehiculo<1 THEN
  			EXECUTE format('
					   insert into '||TablaVehiculo||'(codigo, ruta) 
					   values(nextval(''sec_buses''),'''||vehiculo||''') ');
		END IF;
		
		EXECUTE format('
					   select count(*) from usuarios
					   where nombre = '''||usuario||''' ')
		INTO cantidadUsuario;
		IF cantidadUsuario<1 THEN
  			EXECUTE format('
					   insert into usuarios (nombre) 
					   values('''||usuario||''')');
		END IF;

		EXECUTE format('select codigo from '||TablaVehiculo||' where ruta='''||vehiculo||'''')
		INTO    codigoVehiculo;
		
		codigoUsuario = codigo from usuarios where nombre=usuario;
		
		EXECUTE format('
					   insert into rastreo_'||TablaVehiculo||'(usuario,vehiculo,posicion) 
					   values('||codigoUsuario||',
							  '||codigoVehiculo||',
				   			  st_setsrid(ST_MakePoint('||x||','||y||'),4326))');
							  
							  
	exception
  		when others then 
  		raise notice 'Error: %',SQLERRM;
  	end;
$$
language plpgsql;
--Procedimiento almacenado para guardar una ruta--

--Procedimiento almacenado para transferir la ruta--
create or replace function distance(_usuario int, _vehiculo int, _fecha timestamp)
	returns table(dist float, geom geometry) 
as
$$
	declare
		lines geometry;
	begin
		select ST_MakeLine(
			array(
				select ST_Centroid(ST_Transform(posicion,5367))
				from rastreo_Bus
				where(usuario=_usuario and vehiculo=_vehiculo and fecha between _fecha and now() )
				order by fecha asc)
		)into lines;
		select tipo_vehiculo from Bus where codigo=_vehiculo into el_tipo;
		return QUERY select el_tipo, ST_Length(lines)/1000, ST_Transform(lines, 4326);
end; $$
language plpgsql;
--Procedimiento almacenado para transferir la ruta y la distancia--

