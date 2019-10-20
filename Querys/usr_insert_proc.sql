CREATE PROCEDURE agregar_usuario (@usuario varchar(25))
AS
IF EXISTS(SELECT 'True' FROM MyTable WHERE usuario = @usuario)
BEGIN
  SELECT 'Usuario existe'
END
ELSE
BEGIN
  SELECT 'Usuario no existe'
END