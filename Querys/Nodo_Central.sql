create database Nodo_Central

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

select * from pruebas
select * from registro

---------------------------AQUI pone el nombre de su linked server---
SELECT * FROM OPENQUERY (BUS_SERVER,'select distance(11,44,''2019-10-20 03:23:09'')') 