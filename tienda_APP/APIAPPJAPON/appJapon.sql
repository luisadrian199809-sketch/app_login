-- SQL para crear tablas mínimas y usuario de prueba
CREATE DATABASE IF NOT EXISTS tienda_app;
USE tienda_app;

-- Tabla roles
CREATE TABLE IF NOT EXISTS roles (
  idRol INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL
);

INSERT INTO roles (idRol, nombre) VALUES (1, 'admin')
  ON DUPLICATE KEY UPDATE nombre = VALUES(nombre);

-- Tabla usuarios compatible con la app
CREATE TABLE IF NOT EXISTS usuarios (
  idUsuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) DEFAULT '',
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  idRol INT DEFAULT 1,
  FOREIGN KEY (idRol) REFERENCES roles(idRol)
);

-- Insertar usuario de prueba (contraseña SHA2-256 de 'Migue')
INSERT INTO usuarios (nombre, email, password, idRol)
VALUES ('Migue', 'Migue@gmail.com', SHA2('Migue',256), 1)
ON DUPLICATE KEY UPDATE password = VALUES(password), nombre = VALUES(nombre), idRol = VALUES(idRol);

-- Puedes añadir más datos según sea necesario.
