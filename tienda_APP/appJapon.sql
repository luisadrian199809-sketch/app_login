
CREATE DATABASE IF NOT EXISTS tienda_app;
USE tienda_app;

DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
    idRol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    idRol INT,
    FOREIGN KEY (idRol) REFERENCES roles(idRol)
);

DROP TABLE IF EXISTS categorias;
CREATE TABLE categorias (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    idProductos INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    idCategoria INT,
    FOREIGN KEY (idCategoria) REFERENCES categorias(idCategoria)
);

-- Roles
INSERT INTO roles (nombre) VALUES ('admin'), ('cliente');

-- Users (plain text passwords for testing)
INSERT INTO usuarios (nombre, email, password, idRol) VALUES
('Administrador', 'admin@tienda.com', 'admin123', 1),
('Cliente', 'cliente@tienda.com', 'cliente123', 2);

-- Categories
INSERT INTO categorias (nombre, descripcion) VALUES
('Celulares', 'Teléfonos móviles y smartphones'),
('Laptops', 'Computadoras portátiles'),
('Televisores', 'Pantallas y televisores');

-- Products
INSERT INTO productos (nombre, descripcion, precio, idCategoria) VALUES
('iPhone 14', 'Último modelo de Apple', 1200.00, 1),
('Samsung Galaxy S23', 'Gama alta de Samsung', 1100.00, 1),
('MacBook Pro', 'Laptop de Apple', 2500.00, 2),
('Lenovo ThinkPad', 'Laptop empresarial', 1500.00, 2),
('LG OLED 55', 'Televisor OLED 55 pulgadas', 1800.00, 3),
('Samsung QLED 65', 'Televisor QLED 65 pulgadas', 2000.00, 3);
