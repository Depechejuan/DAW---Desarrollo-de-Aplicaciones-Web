CREATE DATABASE VetCare
GO
USE VetCare
GO


CREATE TABLE TIPOS_VIA(
	idTipoVia INT IDENTITY,
	tipoVia VARCHAR(20) NOT NULL,
	abreviatura VARCHAR(10) NOT NULL

	CONSTRAINT PK_TIPOS_VIA
		PRIMARY KEY (idTipoVia)
)


CREATE TABLE CLIENTES(
	idCliente BIGINT IDENTITY,
    DNI CHAR(12),
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
	email VARCHAR(200),
	pass VARCHAR(255),
    calle VARCHAR(300),
    numero VARCHAR(3),
    piso VARCHAR(3),
    portal VARCHAR(3),
    escalera VARCHAR(3),
    telefono DECIMAL(12,0),
    tfnoAux DECIMAL(12,9),
    idTipoVia INT,
    fechaNacimiento TIMESTAMP NOT NULL,
	acceptedTOS BIT,
    validated BIT DEFAULT 0,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP

	CONSTRAINT PK_CLIENTES 
		PRIMARY KEY (idCliente),
	CONSTRAINT AK_CLIENTES 
		UNIQUE (DNI),
	CONSTRAINT FK_TIPOS_VIA
		FOREIGN KEY (idTipoVia)
		REFERENCES TIPOS_VIA(idTipoVia)
);


CREATE TABLE TIPO_ANIMAL(
	idTipo INT IDENTITY,
	animal VARCHAR(100) NOT NULL

	CONSTRAINT PK_TIPO_ANIMAL
		PRIMARY KEY (idTipo)
)

CREATE TABLE RAZA_ANIMAL(
	idRaza BIGINT IDENTITY,
	nombreRaza VARCHAR(200)

	CONSTRAINT PK_RAZA_ANIMAL
		PRIMARY KEY (idRaza)
)

CREATE TABLE MASCOTAS(
	idMascota BIGINT IDENTITY,
    nombre VARCHAR(255),
    idTipoAnimal INT,
    idRaza BIGINT,
    fechaNacimiento TIMESTAMP,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP

	CONSTRAINT PK_MASCOTAS
		PRIMARY KEY (idMascota),
	CONSTRAINT FK_TIPO_ANIMAL
		FOREIGN KEY (idTipoAnimal)
		REFERENCES TIPO_ANIMAL(idTipo),
	CONSTRAINT FK_RAZA_ANIMAL
		FOREIGN KEY (idRaza)
		REFERENCES RAZA_ANIMAL(idRaza)
);

CREATE TABLE CLIENTE_MASCOTA(
    idCliente BIGINT NOT NULL,
    idMascota BIGINT NOT NULL,

	CONSTRAINT PK_CLIENTE_MASCOTA
		PRIMARY KEY (idCliente, idMascota),
	CONSTRAINT FK_CLIENTE_MASCOTA
		FOREIGN KEY (idCliente)
		REFERENCES CLIENTES (idCliente),
	CONSTRAINT FK_MASCOTA_CLIENTE
		FOREIGN KEY (idMascota) 
		REFERENCES MASCOTAS (idMascota)
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
