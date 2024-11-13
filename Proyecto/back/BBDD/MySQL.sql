CREATE DATABASE VetCare;
USE VetCare;


CREATE TABLE IF NOT EXISTS CLIENTES(
	idCliente BIGINT AUTO_INCREMENT PRIMARY KEY,
    DNI CHAR(12),
    nombre VARCHAR(255) NOT NULL,
    apellido1 VARCHAR(255) NOT NULL,
    apellido2 VARCHAR(255),
    tipoVia ENUM('Calle', 'Avda', 'Paseo', 'Via', 'Carretera') DEFAULT 'Calle',
    calle VARCHAR(300),
    numero VARCHAR(3),
    piso VARCHAR(3),
    portal VARCHAR(3),
    escalera VARCHAR(3),
    telefono DECIMAL(12,0) NOT NULL,
    tfnoAux DECIMAL(12,9),
    fechaNacimiento TIMESTAMP NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS CLIENTES_ONLINE(
	idClienteOnline BIGINT AUTO_INCREMENT PRIMARY KEY,
    idCliente BIGINT,
    email VARCHAR(255) NOT NULL,
    pass VARCHAR(300) NOT NULL,
    acceptedTOS BOOL,
    validated BOOL DEFAULT false,
    
    FOREIGN KEY (idCliente) REFERENCES CLIENTES (idCliente)
);

CREATE TABLE IF NOT EXISTS MASCOTAS(
	idMascota BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    animal ENUM('Gato', 'Perro', 'Loro', 'Iguana', 'Capibara') DEFAULT 'Gato',
    raza VARCHAR(255),
    fechaNacimiento TIMESTAMP,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS CLIENTE_MASCOTA(
	idClienteMascota BIGINT AUTO_INCREMENT PRIMARY KEY,
    idCliente BIGINT,
    idMascota BIGINT,
    FOREIGN KEY (idCliente) REFERENCES CLIENTES (idCliente),
    FOREIGN KEY (idMascota) REFERENCES MASCOTAS (idMascota)
);
-- IF cliente no tiene DNI, no se puede asociar a mascota

CREATE TABLE IF NOT EXISTS VACUNAS(
	idVacuna BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255),
    composicion VARCHAR(500),
    stock DECIMAL(3,0) DEFAULT 0,
    precio DECIMAL(6,0),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
)
