-- 1. Cree un procedimiento llamado `ps_registrar_cliente_unico`  que inserta un nuevo cliente si su correo no está registrado .

DELIMITER $$
CREATE PROCEDURE ps_registrar_cliente_unico (
    IN nombre VARCHAR(100),
    IN telefono VARCHAR(15),
    IN email VARCHAR(50),
    IN fecha_registro DATE
)
BEGIN
    SELECT COUNT(*)
    FROM cliente

    IF clientes.email < 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya está registrado con ese gmail';
    ELSE
       
        INSERT INTO clientes (nombre, telefono, email, fecha_registro)
        VALUES (nombre, telefono, email, fecha_registro);


    END IF;
END $$

DELIMITER ;
