--drop table registro
use Nodo_Central

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

select * from registro

SELECT * FROM OPENQUERY (PostgreSQLBus,'select distance(1,1,''2019-10-20 03:23:09'')') 

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

create nonclustered index idx_fechaI_registro on registro(fecha)

--drop proc usuarios_mayor_rastreos
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
	order by cantidad;

exec usuarios_mayor_rastreos '10-20-2019 00:00:00', '10-25-2019 00:00:00'

create nonclustered index idx_tipo_registro on registro(tipo_vehiculo)

--drop proc rutas_tipo
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

	select AVG(ALL distancia) as promedio from @registros_v;

exec promedio_distancia 'cq-limon'