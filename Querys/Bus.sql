CREATE DATABASE Bus;

--SECUENCIAS NUMERICAS--
--Para el codigo de buses 
create sequence sec_buses
	minvalue 0
	increment by 1;
--SECUENCIAS NUMERICAS--

------- TABLAS -------
--drop table bus
create table Bus(
	codigo	serial,
	tipo	char(1)	     not null default 'B',
	ruta 	varchar(200) not null,
	
	constraint pk_codigo_bus
		primary key	(codigo)
);

create table usuarios
(
	codigo serial,
	nombre varchar(200) not null,
	
	constraint pk_codigo_usuario
		primary key	(codigo)
);

create extension postgis;

--drop table rastreo_Bus
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
					   insert into rastreo_'||TablaVehiculo||'(usuario,vehiculo,geom) 
					   values('||codigoUsuario||',
							  '||codigoVehiculo||',
				   			  st_setsrid(ST_MakePoint('||x||','||y||'),4326))');
							  
							  
	--exception
  		--when others then 
  		--raise notice 'Error: %',SQLERRM;
  	end;
$$
language plpgsql;
--Procedimiento almacenado para guardar una ruta--