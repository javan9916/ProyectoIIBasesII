CREATE DATABASE Tren;

--SECUENCIAS NUMERICAS--
--Para el codigo de tren
create sequence sec_tren
	minvalue 0
	increment by 1;
--SECUENCIAS NUMERICAS--

------- TABLAS -------
--drop table tren
-- Tabla tren --
create table tren(
	codigo			serial,
	tipo_vehiculo	char(1)	     not null default 'S',
	ruta 			varchar(200) not null,
	
	constraint pk_codigo_tren
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

--drop table rastreo_Tren
-- Tabla de rastreos del tren --
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

-- Procedimiento para agregar tren en su tabla --
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

--PROCEDIMIENTOS ALMACENADOS PARA GUARDAR UNA RUTA--
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

--Procedimiento almacenado para transferir la ruta--
create or replace function distance(_usuario int, _vehiculo int, _fecha timestamp)
	returns table(tipo char(1), dist float, geom geometry) 
as
$$
	declare
		lines geometry;
		el_tipo char(1);
	begin
		select ST_MakeLine(
			array(
				select ST_Centroid(ST_Transform(posicion,5367))
				from rastreo_Tren
				where(usuario=_usuario and vehiculo=_vehiculo and fecha between _fecha and now() )
				order by fecha asc)
		)into lines;
		select tipo_vehiculo from Tren where codigo=_vehiculo into el_tipo;
		return QUERY select el_tipo, ST_Length(lines)/1000, ST_Transform(lines, 4326);
end; $$
language plpgsql;
--Procedimiento almacenado para transferir la ruta y la distancia--

--Procedimiento almacenado para transferir fecha Inicio--
create or replace function fechaInicio(_usuario int, _vehiculo int)
	returns table(momento timestamp)
as
$$
	declare
		momento timestamp;
	begin
		select fecha 
		from rastreo_Tren where(usuario=_usuario and vehiculo=_vehiculo) 
		into momento
		order by fecha
		LIMIT 1;
		return QUERY select momento;
end; $$
language plpgsql;
--Procedimiento almacenado para transferir fecha Inicio--

--Procedimiento almacenado para transferir fecha Final--
create or replace function fechaFinal(_usuario int, _vehiculo int)
	returns table(momento timestamp)
as
$$
	declare
		momento timestamp;
	begin
		select fecha 
		from rastreo_Tren where(usuario=_usuario and vehiculo=_vehiculo) 
		into momento
		order by fecha desc
		LIMIT 1;
		return QUERY select momento;
end; $$
language plpgsql;
--Procedimiento almacenado para transferir fecha Final--


--Procedimiento almacenado para transferir distancia--
create or replace function distancia(_usuario int, _vehiculo int)
	returns table(dist float)
as
$$
	declare
		lines geometry;
	begin
		select ST_MakeLine(
			array(
				select ST_Centroid(ST_Transform(posicion,5367))
				from rastreo_Tren
				where(usuario=_usuario and vehiculo=_vehiculo)
				order by fecha asc)
		)into lines;
		return QUERY select ST_Length(lines)/1000;
end; $$
language plpgsql;
--Procedimiento almacenado para transferir distancia--

--Procedimiento almacenado para transferir ruta--
create or replace function ruta(_usuario int, _vehiculo int)
	returns table(ruta text)
as
$$
	declare
		lines geometry;
	begin
		select ST_MakeLine(
			array(
				select ST_Centroid(ST_Transform(posicion,5367))
				from rastreo_Tren
				where(usuario=_usuario and vehiculo=_vehiculo)
				order by fecha asc)
		)into lines;
		return QUERY select ST_AsText(ST_Transform(lines, 4326));
end; $$
language plpgsql;
--Procedimiento almacenado para transferir ruta--

--ejemplos---------------------------------------
select distance(11,44,'2019-10-20 03:23:09')
select fechaInicio(11,44) 
select fechaFinal(11,44)  
select distancia(11,44) 
select ruta(11,44)