-- Active: 1751457725521@@127.0.0.1@3309@examen

-- 1. Mostrar los empleados junto al país donde laboran.
SELECT clientes.nombre, pais.nombre 
FROM clientes
JOIN pais ON clientes.cliente_id = pais.id;

-- 2. Listar el nombre de cada cliente con su municipio, departamento y país.
SELECT c.nombre AS cliente, municipio.nombre AS municipio, departamento.nombre AS departamento, pais.nombre AS pais
FROM clientes c
JOIN municipio 
ON c.cliente_id = municipio.id
JOIN departamento
ON c.cliente_id = departamento.id
JOIN pais
ON c.cliente_id = pais.id

-- 3. Obtener los nombres de los empleados cuyo puesto existe en más de una sucursal.
SELECT emp.nombre
FROM empleados emp
JOIN sucursal
ON emp.empleado_id = sucursal.id
WHERE emp.empleado_id > 1;

--4. Mostrar el total de empleados por municipio y el nombre del departamento al que pertenecen.
