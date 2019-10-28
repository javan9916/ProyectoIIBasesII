--drop table registro
use Nodo_Central

-- Tabla registro
create table registro
(
	id					int identity(1,1) primary key,
	tipo_vehiculo		char(1)  not null,
	nombre_usuario		char(30) not null,
	nombre_vehiculo		char(30) not null,
	fecha				datetime not null,
	idUsuario			int not null,
	idVehiculo			int not null,
	ruta				text,
	distancia			float
)

execute sp_helpindex 'registro'

select * from registro

--drop index registro.idx_fechaI_registro
-- índice de las fechas de la tabla registro
create nonclustered index idx_fecha_registro on registro(fecha)

-- índice de los tipos de la tabla registro
create nonclustered index idx_tipo_registro on registro(tipo_vehiculo)

--drop proc rutas_tipo
-- procedimiento para consultas las rutas según el tipo de vehiculo
create proc rutas_tipo 
@fechaI as datetime, @fechaF as datetime, @tipo as char(1)
as
	declare @registros_t table(
		vehiculo	char(30) not null,
		ruta		text,
		tipo		char(1) not null,
		fecha		datetime not null
	);

	insert into @registros_t
	select nombre_vehiculo, ruta, tipo_vehiculo, fecha
	from registro where tipo_vehiculo = @tipo

	select vehiculo, ruta, tipo
	from @registros_t
	where fecha between @fechaI and @fechaF;

exec rutas_tipo '10-20-2019 00:00:00', '10-25-2019 00:00:00', 'B'

--drop proc promedio_distancia
-- procedimiento para consultar el promedio de distancia recorrido de un vehiculo dado
create proc promedio_distancia 
@nombre_vehiculo as char(30)
as
	declare @registros_v table(
		vehiculo	char(30) not null,
		distancia	float
	);

	insert into @registros_v
	select nombre_vehiculo, distancia
	from registro where tipo_vehiculo = 'B'

<<<<<<< HEAD
create nonclustered index idx_fechaI_registro on registro(fecha_inicio)
go
=======
	select AVG(ALL distancia) as promedio from @registros_v;

exec promedio_distancia 'cq-limon'

--drop proc usuarios_mayor_rastreos
-- procedimiento para consultar los usuarios con mayor número de rastreos
>>>>>>> 19bbd33834844ad9cc355ed09315e02b395099e8
create proc usuarios_mayor_rastreos 
@fechaI as datetime, @fechaF as datetime
as
	declare @registros_f table(
		usuario char(30) not null,
		ruta	text,
		fecha datetime not null
	);

	insert into @registros_f
	select nombre_usuario, ruta, fecha
	from registro
	where fecha between @fechaI and @fechaF;

	select rf.usuario, Count(*) as cantidad	
	from @registros_f rf
	group by rf.usuario
	order by cantidad desc;

exec usuarios_mayor_rastreos '10-20-2019 00:00:00', '10-25-2019 00:00:00'

<<<<<<< HEAD
--create nonclustered index idx_tipo_registro on registro(tipo)
go
create proc rutas_tipo 
@fechaI as datetime, @fechaF as datetime, @tipo as char(1)
as
	declare @registros_t table(
		ruta	text,
		tipo	char(1) not null,
		fecha datetime not null
	);

	insert into @registros_t
	select ruta, tipo, fecha_inicio
	from registro where tipo = @tipo

	select ruta, tipo
	from @registros_t
	where fecha between @fechaI and @fechaF;

exec rutas_tipo '10-25-2019 00:00:00', '10-20-2019 00:00:00', 'B'
GO
create procedure actualizar
as
begin
	declare @tipo_vehiculo		char(1),
			@nombre_usuario		char(30),
			@nombre_vehiculo	char(30),
			@fechaI				datetime,
			@fechaF				datetime,
			@idUsuario			int,
			@idVehiculo			int,
			@distancia			float,
			@getfechaI_bus		varchar(100),
			@getfechaF_bus		varchar(100),
			@getdistancia_bus	varchar(100),
			@getfechaI_taxi		varchar(100),
			@getfechaF_taxi		varchar(100),
			@getdistancia_taxi	varchar(100),
			@getfechaI_tren		varchar(100),
			@getfechaF_tren		varchar(100),
			@getdistancia_tren	varchar(100)

	declare cur_bus_usuarios cursor for select * from OPENQUERY (BUS_SERVER,'select * from usuarios');
	declare cur_bus_vehiculo cursor for select * from OPENQUERY (BUS_SERVER,'select * from bus');
	set @getfechaI_bus = 'set @fechaI = (SELECT * FROM OPENQUERY (BUS_SERVER,''select fechaInicio('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getfechaF_bus = 'set @fechaF = (SELECT * FROM OPENQUERY (BUS_SERVER,''select fechaFinal('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getdistancia_bus = 'set @distancia = (SELECT * FROM OPENQUERY (BUS_SERVER,''select distancia('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'

	declare cur_taxi_usuarios cursor for select * from OPENQUERY (TAXI_SERVER,'select * from usuarios');
	declare cur_taxi_vehiculo cursor for select * from OPENQUERY (TAXI_SERVER,'select * from taxi');
	set @getfechaI_taxi = 'set @fechaI = (SELECT * FROM OPENQUERY (TAXI_SERVER,''select fechaInicio('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getfechaF_taxi = 'set @fechaF = (SELECT * FROM OPENQUERY (TAXI_SERVER,''select fechaFinal('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getdistancia_taxi = 'set @distancia = (SELECT * FROM OPENQUERY (TAXI_SERVER,''select distancia('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'

	declare cur_tren_usuarios cursor for select * from OPENQUERY (TREN_SERVER,'select * from usuarios');
	declare cur_tren_vehiculo cursor for select * from OPENQUERY (TREN_SERVER,'select * from tren');
	set @getfechaI_tren = 'set @fechaI = (SELECT * FROM OPENQUERY (TREN_SERVER,''select fechaInicio('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getfechaF_tren = 'set @fechaF = (SELECT * FROM OPENQUERY (TREN_SERVER,''select fechaFinal('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'
	set @getdistancia_tren = 'set @distancia = (SELECT * FROM OPENQUERY (TREN_SERVER,''select distancia('+CONVERT(varchar(10),@idUsuario)+','+CONVERT(varchar(10),@idVehiculo)+')''))'

	--recuperar datos de Buses----------------------------------------------------------
	open cur_bus_usuarios
	fetch next from cur_bus_usuarios into @idUsuario, @nombre_usuario
	while @@FETCH_STATUS = 0
	BEGIN
		open cur_bus_vehiculo
		fetch next from cur_bus_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		while @@FETCH_STATUS = 0
		BEGIN 
			
			EXEC (@getfechaI_bus)
			EXEC (@getfechaF_bus)
			EXEC (@getdistancia_bus)

			IF (NOT EXISTS(SELECT * FROM registro WHERE tipo_vehiculo = @tipo_vehiculo and nombre_usuario = @nombre_usuario and nombre_vehiculo = @nombre_vehiculo)
			    AND EXISTS(SELECT * FROM OPENQUERY (BUS_SERVER,'select * from rastreo_bus') where usuario = @idUsuario and vehiculo = @idVehiculo) )
			BEGIN
				insert into registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, distancia)
			values (@tipo_vehiculo, @nombre_usuario, @nombre_vehiculo, @fechaI, @fechaF, @idUsuario, @idVehiculo, @distancia)
			END
			fetch next from cur_bus_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		END
		CLOSE cur_bus_vehiculo
		fetch next from cur_bus_usuarios into @idUsuario, @nombre_usuario
	END
	CLOSE cur_bus_usuarios
	DEALLOCATE cur_bus_usuarios
	DEALLOCATE cur_bus_vehiculo

	--recuperar datos de Taxis----------------------------------------------------------
	open cur_taxi_usuarios
	fetch next from cur_taxi_usuarios into @idUsuario, @nombre_usuario
	while @@FETCH_STATUS = 0
	BEGIN
		open cur_taxi_vehiculo
		fetch next from cur_taxi_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		while @@FETCH_STATUS = 0
		BEGIN 
			EXEC (@getfechaI_taxi)
			EXEC (@getfechaF_taxi)
			EXEC (@getdistancia_taxi)

			IF (NOT EXISTS(SELECT * FROM registro WHERE tipo_vehiculo = @tipo_vehiculo and nombre_usuario = @nombre_usuario and nombre_vehiculo = @nombre_vehiculo)
			    AND EXISTS(SELECT * FROM OPENQUERY (TAXI_SERVER,'select * from rastreo_taxi') where usuario = @idUsuario and vehiculo = @idVehiculo) )
			BEGIN
				insert into registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, distancia)
			values (@tipo_vehiculo, @nombre_usuario, @nombre_vehiculo, @fechaI, @fechaF, @idUsuario, @idVehiculo, @distancia)
			END
			fetch next from cur_taxi_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		END
		CLOSE cur_taxi_vehiculo
		fetch next from cur_taxi_usuarios into @idUsuario, @nombre_usuario
	END
	CLOSE cur_taxi_usuarios
	DEALLOCATE cur_taxi_usuarios
	DEALLOCATE cur_taxi_vehiculo

	--recuperar datos de Tren----------------------------------------------------------
	open cur_tren_usuarios
	fetch next from cur_tren_usuarios into @idUsuario, @nombre_usuario
	while @@FETCH_STATUS = 0
	BEGIN
		open cur_tren_vehiculo
		fetch next from cur_tren_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		while @@FETCH_STATUS = 0
		BEGIN 
			EXEC (@getfechaI_tren)
			EXEC (@getfechaF_tren)
			EXEC (@getdistancia_tren)

			IF (NOT EXISTS(SELECT * FROM registro WHERE tipo_vehiculo = @tipo_vehiculo and nombre_usuario = @nombre_usuario and nombre_vehiculo = @nombre_vehiculo)
			    AND EXISTS(SELECT * FROM OPENQUERY (TREN_SERVER,'select * from rastreo_tren') where usuario = @idUsuario and vehiculo = @idVehiculo) )
			BEGIN
				insert into registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, distancia)
			values (@tipo_vehiculo, @nombre_usuario, @nombre_vehiculo, @fechaI, @fechaF, @idUsuario, @idVehiculo, @distancia)
			END
			fetch next from cur_tren_vehiculo into @idVehiculo, @tipo_vehiculo, @nombre_vehiculo
		END
		CLOSE cur_tren_vehiculo
		fetch next from cur_tren_usuarios into @idUsuario, @nombre_usuario
	END
	CLOSE cur_tren_usuarios
	DEALLOCATE cur_tren_usuarios
	DEALLOCATE cur_tren_vehiculo
end;

---------------------------AQUI pone el nombre de su linked server---
----pruebas--------------------------------------------------------------------------------
EXEC actualizar;
select * from registro

SELECT * FROM OPENQUERY (BUS_SERVER,'select distance(11,44,''2019-10-20 03:23:09'')') 

declare @fecha1 datetime
set @fecha1 = (SELECT * FROM OPENQUERY (BUS_SERVER,'select fecha(11,44)'))
select @fecha1

declare @distancia1 float
set @distancia1 = (SELECT * FROM OPENQUERY (BUS_SERVER,'select distancia(11,44)'))
select @distancia1


declare @ruta2 text
set @ruta2 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select ruta(11,44)'))
select @ruta2

declare @fecha2 datetime
set @fecha2 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select fecha(11,44)'))
select @fecha2

declare @distancia2 float
set @distancia2 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select distancia(11,44)'))
select @distancia2


declare @ruta3 text
set @ruta3 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select ruta(11,44)'))
select @ruta3

declare @fecha3 datetime
set @fecha3 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select fecha(11,44)'))
select @fecha3

declare @distancia3 float
set @distancia3 = (SELECT * FROM OPENQUERY (TAXI_SERVER,'select distancia(11,44)'))
select @distancia3
=======
-- algunos datos de prueba
INSERT INTO registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha, idUsuario, idVehiculo, ruta, distancia)
VALUES ('B','user1', 'cq-limon', '10-21-2019', 1, 1, 'ruta1xd', 5.14)
INSERT INTO registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha, idUsuario, idVehiculo, ruta, distancia)
VALUES ('B','user1', 'cq-la vieja', '10-23-2019', 1, 1, 'ruta2xd', 5.14)
INSERT INTO registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha, idUsuario, idVehiculo, ruta, distancia)
VALUES ('B','user2', 'cq-la vieja', '9-21-2019', 2, 2, 'ruta2xd', 5.14)
INSERT INTO registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha, idUsuario, idVehiculo, ruta, distancia)
VALUES ('B','user1', 'cq-limon', '8-21-2019', 1, 1, 'ruta2xd', 5.14)
INSERT INTO registro (tipo_vehiculo, nombre_usuario, nombre_vehiculo, fecha, idUsuario, idVehiculo, ruta, distancia)
VALUES ('T','user2', 'cq-la vieja', '10-23-2019', 2, 2, 'ruta2xd', 5.14)
>>>>>>> 19bbd33834844ad9cc355ed09315e02b395099e8
