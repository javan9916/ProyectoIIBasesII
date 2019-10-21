CREATE DATABASE Taxi;

--SECUENCIAS NUMERICAS--
--Para el codigo de taxis
create sequence sec_taxis
	minvalue 0
	increment by 1;
--SECUENCIAS NUMERICAS--

------- TABLAS -------
--drop table taxi
create table taxi(
	codigo	serial,
	tipo	char(1)	     not null default 'T',
	ruta 	varchar(200) not null,
	
	constraint pk_codigo_taxi
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

--drop table rastreo_Taxi
create table rastreo_Taxi 
(
	codigo 		serial,
	usuario 	int 	  not null,
	vehiculo 	int  	  not null,
	fecha 		timestamp default now()::timestamp(0),
	estado 		smallint  not null default(1),
	
	constraint pk_codigo_rastreo_taxis
		primary key	(codigo),
	constraint fk_usuario_rastreo_taxis
		foreign key	(usuario) references usuarios on update cascade,
	constraint fk_bus_rastreo_taxis
		foreign key	(vehiculo) references taxi on update cascade
);

SELECT AddGeometryColumn ('public','rastreo_taxi','geom',4326,'POINT',2,false);
------- TABLAS -------

----PROCEDIMIENTOS ALMACENADOS PARA CREACIÓN----
create or replace function agregar_taxi(v_ruta varchar(200)) returns void
as
$$ 
	begin
	insert into taxi (codigo, ruta)
		values (nextval('sec_taxis'),v_ruta);
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
					   values(nextval(''sec_taxis''),'''||vehiculo||''') ');
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