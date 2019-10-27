--drop table registro
use Nodo_Central

create table registro
(
	id					int identity(1,1) primary key,
	nombre_usuario		char(30) not null,
	nombre_vehiculo		char(30) not null,
	fecha_inicio		datetime not null,
	fecha_final			datetime not null,
	idUsuario			int not null,
	idVehiculo			int not null,
	ruta				text,
	distancia			float
)

select * from registro

SELECT * FROM OPENQUERY (PostgreSQLBus,'select distance(1,1,''2019-10-20 03:23:09'')') 

INSERT INTO registro (nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, ruta, distancia)
VALUES ('user1', 'cq-limón', '10-21-2019', '10-22-2019', 1, 1, 'ruta1xd', 5.14)
INSERT INTO registro (nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, ruta, distancia)
VALUES ('user1', 'cq-la vieja', '10-23-2019', '10-24-2019', 1, 1, 'ruta2xd', 5.14)
INSERT INTO registro (nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, ruta, distancia)
VALUES ('user2', 'cq-la vieja', '9-21-2019', '9-22-2019', 2, 2, 'ruta2xd', 5.14)
INSERT INTO registro (nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, ruta, distancia)
VALUES ('user1', 'cq-limón', '8-21-2019', '8-22-2019', 1, 1, 'ruta2xd', 5.14)
INSERT INTO registro (nombre_usuario, nombre_vehiculo, fecha_inicio, fecha_final, idUsuario, idVehiculo, ruta, distancia)
VALUES ('user2', 'cq-la vieja', '10-23-2019', '10-24-2019', 2, 2, 'ruta2xd', 5.14)

create nonclustered index idx_fechaI_registro on registro(fecha_inicio)

create proc usuarios_mayor_rastreos 
@fechaI as datetime, @fechaF as datetime
as
	declare @registros_f table(
		usuario char(30) not null,
		ruta	text,
		fecha datetime not null
	);

	insert into @registros_f
	select nombre_usuario, ruta, fecha_inicio
	from registro
	where fecha_inicio between @fechaI and @fechaF;

	select rf.usuario, Count(*) as cantidad	
	from @registros_f rf
	group by rf.usuario;

exec usuarios_mayor_rastreos '10-20-2019 00:00:00', '10-25-2019 00:00:00'
