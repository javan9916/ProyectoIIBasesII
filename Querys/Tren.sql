CREATE DATABASE Tren;

--SECUENCIAS NUMERICAS--
--Para el codigo de tren
create sequence sec_tren
	minvalue 0
	increment by 1;
--SECUENCIAS NUMERICAS--

------- TABLAS -------
--drop table tren
create table tren(
	codigo	serial,
	tipo	char(1)	     not null default 'S',
	ruta 	varchar(200) not null,
	
	constraint pk_codigo_tren
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

--drop table rastreo_Tren
create table rastreo_Tren 
(
	codigo 		serial,
	usuario 	int 	  not null,
	vehiculo 	int  	  not null,
	fecha 		timestamp default now()::timestamp(0),
	estado 		smallint  not null default(1),
	
	constraint pk_codigo_rastreo_trenes
		primary key	(codigo),
	constraint fk_usuario_rastreo_trenes
		foreign key	(usuario) references usuarios on update cascade,
	constraint fk_bus_rastreo_trenes
		foreign key	(vehiculo) references tren on update cascade
);

SELECT AddGeometryColumn ('public','rastreo_tren','geom',4326,'POINT',2,false);
------- TABLAS -------

----PROCEDIMIENTOS ALMACENADOS PARA CREACIÓN----
create or replace function agregar_tren(v_ruta varchar(200)) returns void
as
$$ 
	begin
	insert into tren (codigo, ruta)
		values (nextval('sec_trenes'),v_ruta);
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
							  
							  
	exception
  		when others then 
  		raise notice 'Error: %',SQLERRM;
  	end;
$$
language plpgsql;
--Procedimiento almacenado para guardar una ruta--