-- Active: 1751457725521@@127.0.0.1@3309@mysql
-- Table structure for table `clientes`
--
CREATE DATABASE examen; 

USE examen; 

DROP TABLE IF EXISTS `pais`;
CREATE TABLE `pais` (
    `id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(80) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `pais_unique` (`nombre`)
);


DROP TABLE IF EXISTS departamento;
CREATE TABLE departamento (
    `id` int AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    `paisid` int,
    FOREIGN KEY (paisid) references pais(id)
);


DROP TABLE IF EXISTS `municipio`;

CREATE TABLE IF NOT EXISTS `municipio` (
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `depid` int DEFAULT NULL,
    foreign key (`depid`) references `departamento`(`id`)
);

DROP TABLE IF EXISTS `empresa`;
CREATE TABLE IF NOT EXISTS `empresa` (
    `id` varchar(20) NOT NULL,
    `nombre` varchar(80) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `empresa_unique` (`nombre`)
);


DROP TABLE IF EXISTS `sucursal`;
CREATE TABLE `sucursal` (
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    `direccion` varchar(80) DEFAULT NULL,
    `empresaid` varchar(20) DEFAULT NULL,
    `municipioid` int DEFAULT NULL,
    foreign key (`empresaid`) references `empresa`(`id`),
    foreign key (`municipioid`) references `municipio`(`id`)
);


DROP TABLE IF EXISTS clientes;
create table if not exists clientes (
    `cliente_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) NOT NULL,
    `email` varchar(50) NOT NULL,
    `telefono` varchar(15) NOT NULL,
    `direccion` varchar(50) NOT NULL,
    `fecha_registro` date NOT NULL,
    `municipioid` int NOT NULL,
    foreign key (municipioid) references municipio(id)
);



DROP TABLE IF EXISTS `empleados`;

CREATE TABLE IF NOT EXISTS `empleados` (
    `empleado_id` int NOT NULL AUTO_INCREMENT,
    `nombre` varchar(80) DEFAULT NULL,
    `puesto` varchar(50) DEFAULT NULL,
    `fecha_contratacion` date DEFAULT NULL,
    `salario` decimal(10,2) DEFAULT NULL,
    `sucursalid` int DEFAULT NULL,
    PRIMARY KEY (`empleado_id`),
    KEY `empleados_sucursal_FK` (`sucursalid`),
    CONSTRAINT `empleados_sucursal_FK` FOREIGN KEY (`sucursalid`) REFERENCES `sucursal` (`id`)
);


DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
    `producto_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nombre` varchar(80) DEFAULT NULL,
    `categoria` varchar(80) DEFAULT NULL,
    `precio` decimal(10,2) DEFAULT NULL,
    `stock` int DEFAULT NULL
);


DROP TABLE IF EXISTS `producto_suc`;

CREATE TABLE IF NOT EXISTS `producto_suc` (
    `productoid` int NOT NULL,
    `sucursalid` int NOT NULL,
    PRIMARY KEY (`productoid`,`sucursalid`),
    foreign key (`productoid`) references `productos`(`producto_id`),
    foreign key (`sucursalid`) references `sucursal`(`id`)
);


DROP TABLE IF EXISTS `pedidos`;
CREATE TABLE IF NOT EXISTS `pedidos` (
    `pedido_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `cliente_id` int DEFAULT NULL,
    `empleado_id` int DEFAULT NULL,
    `fecha_pedido` date DEFAULT NULL,
    `estado` varchar(20) DEFAULT NULL,
    foreign key (`cliente_id`) references `clientes`(`cliente_id`),
    foreign key (`empleado_id`) references `empleados`(`empleado_id`)
);



DROP TABLE IF EXISTS detalles_pedidos;

CREATE TABLE IF NOT EXISTS `detalles_pedidos` (
    `detalle_id` int AUTO_INCREMENT PRIMARY KEY,
    `pedido_id` int NOT NULL,
    `producto_id` int NOT NULL,
    `cantidad` int NOT NULL,
    `precio_unitario` decimal(10,2) NOT NULL,
    `sucid` int NOT NULL,
    foreign key (`pedido_id`) references `pedidos`(`pedido_id`),
    foreign key (`producto_id`) references `productos`(`producto_id`)
) ;
