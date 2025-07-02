-- 1. Cree un procedimiento llamado `ps_registrar_cliente_unico`  que inserta un nuevo cliente si su correo no está registrado .
DROP PROCEDURE IF EXISTS ps_registrar_cliente_unico;
DELIMITER $$
CREATE PROCEDURE ps_registrar_cliente_unico (
    IN nombre VARCHAR(100),
    IN telefono VARCHAR(15),
    IN email VARCHAR(50),
    IN direccion VARCHAR(20),
    IN fecha_registro DATE
)
BEGIN
    DECLARE existe INT;

    SELECT COUNT(*) INTO existe
    FROM clientes
    WHERE clientes.email = email;

    IF existe > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El cliente ya está registrado con ese gmail';
    ELSE
        INSERT INTO clientes (nombre, telefono, email, direccion, fecha_registro)
        VALUES (nombre, telefono, email, direccion, fecha_registro);

    END IF;
END $$

DELIMITER ;

CALL ps_registrar_cliente_unico(
    'Adrian Ruiz', 
    '3123456789', 
    'Calle 123 #45-67', 
    'adrian.ruiz@gmail.com', 
    '2025-02-01'
);

-- 2. Cree un procedimiento por nombre `ps_obtener_clientes_por_municipio` donde liste todos los clientes de un municipio .
DROP PROCEDURE IF EXISTS ps_obtener_clientes_por_municipio;
USE examen;
DELIMITER $$

CREATE PROCEDURE ps_obtener_clientes_por_municipio(
    IN clientes_municipio VARCHAR(100)
)
BEGIN
    SELECT mp.nombre, c.nombre
    FROM municipio mp
    JOIN clientes c
    ON mp.id = c.cliente_id
    WHERE c.cliente_id = mp.id;
END $$


DELIMITER ;
CALL ps_obtener_clientes_por_municipio('Cali');

--3. Cree un procedimiento por nombre  `ps_listar_empleados_por_sucursal` donde muestre todos los empleados de una sucursal .
DROP PROCEDURE IF EXISTS ps_listar_empleados_por_sucursal;
USE examen;
DELIMITER $$

CREATE PROCEDURE ps_listar_empleados_por_sucursal(
    IN empleados_sucursal VARCHAR(100)
)
BEGIN
    SELECT s.nombre, emp.nombre
    FROM sucursal s
    JOIN empleados emp
    ON s.id = emp.empleado_id
    WHERE emp.empleado_id = s.id;
END $$


DELIMITER ;

CALL ps_listar_empleados_por_sucursal('Sucursal Zona 3');