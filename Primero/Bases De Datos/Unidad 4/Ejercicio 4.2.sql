USE master
GO
DROP DATABASE IF EXISTS AGENCIA_TRIBUTARIA
GO
USE master
GO
DROP DATABASE IF EXISTS GALERIA_ARTE
GO
USE master
GO
DROP DATABASE IF EXISTS BOOKING

----------------------
--	EJERCICIO 4.2.1 --
----------------------

CREATE DATABASE GALERIA_ARTE
GO
USE GALERIA_ARTE
GO
CREATE TABLE GALERIAS(
	codGaleria BIGINT IDENTITY,
	nombre VARCHAR(255) NOT NULL,
	ciudad VARCHAR(255) NOT NULL,
	direccion VARCHAR(300),
	metrosCuadrados DECIMAL(9,2),

	CONSTRAINT PK_GALERIAS PRIMARY KEY (codGaleria)
)


-- CORRECCION
ALTER TABLE GALERIAS
	ALTER COLUMN metrosCuadrados VARCHAR(20)


CREATE TABLE ESCUELAS(
	codEscuela BIGINT IDENTITY,
	nombre VARCHAR(300) NOT NULL,
	pais VARCHAR(150),
	fechaAlta SMALLDATETIME NOT NULL,

	CONSTRAINT PK_ESCUELAS PRIMARY KEY (codEscuela)
)

CREATE TABLE PATROCINADORES(
	codPatrocinador BIGINT IDENTITY,
	nombre VARCHAR(255) NOT NULL,
	pais VARCHAR(150),

	CONSTRAINT PK_PATROCINADORES PRIMARY KEY (codPatrocinador)
)

CREATE TABLE PINTORES(
	codPintor BIGINT IDENTITY,
	nombre VARCHAR(300) NOT NULL,
	pais VARCHAR(150),
	codPintorMaestro BIGINT,
	codEscuela BIGINT,

	CONSTRAINT PK_PINTORES
		PRIMARY KEY (codPintor),
	CONSTRAINT FK_PINTORES_MAESTROS
		FOREIGN KEY (codPintorMaestro)
		REFERENCES PINTORES (codPintor),
	CONSTRAINT FK_PINTORES_ESCUELA
		FOREIGN KEY (codEscuela)
		REFERENCES ESCUELAS (codEscuela)
)

CREATE TABLE CUADROS(
	codCuadro BIGINT IDENTITY,
	dimensiones VARCHAR(20),
	fecha SMALLDATETIME NOT NULL,
	tecnica VARCHAR(100),
	codGaleria BIGINT,
	codPintor BIGINT NOT NULL,

	CONSTRAINT PK_CUADROS PRIMARY KEY (codCuadro),
	CONSTRAINT FK_CUADROS_GALERIA
		FOREIGN KEY (codGaleria)
		REFERENCES GALERIAS(codGaleria),
	CONSTRAINT FK_CUADORS_PINTOR
		FOREIGN KEY (codPintor)
		REFERENCES PINTORES(codPintor)
)

CREATE TABLE PATROCINADORES_PINTORES(
	codPintor BIGINT,
	codPatrocinador BIGINT,

	CONSTRAINT PK_PATROCINADORES_PINTORES
		PRIMARY KEY (codPintor, codPatrocinador),
	CONSTRAINT FK_PINTOR
		FOREIGN KEY (codPintor)
		REFERENCES PINTORES(codPintor),
	CONSTRAINT FK_PATROCINADOR
		FOREIGN KEY (codPatrocinador)
		REFERENCES PATROCINADORES(codPatrocinador)
)



----------------------
--	EJERCICIO 4.2.2 --
----------------------


CREATE DATABASE BOOKING
GO
USE BOOKING
GO
CREATE TABLE CATEGORIAS(
	codCategoria BIGINT IDENTITY,
	nombre VARCHAR(300) NOT NULL,
	IVA DECIMAL(4,2),

	CONSTRAINT PK_CATEGORIAS PRIMARY KEY (codCategoria)
)

CREATE TABLE CLIENTES(
	codCliente BIGINT IDENTITY,
	nombre VARCHAR(300),
	direccion VARCHAR(300),
	telefono DECIMAL(11,0),

	CONSTRAINT PK_CLIENTES PRIMARY KEY (codCliente)
)

CREATE TABLE HOTELES(
	codHotel BIGINT IDENTITY,
	nombre VARCHAR(300) NOT NULL,
	direccion VARCHAR(300) NOT NULL,
	telefono DECIMAL(11,0),
	codCategoria BIGINT NOT NULL,

	CONSTRAINT PK_HOTELES PRIMARY KEY (codHotel),
	CONSTRAINT FK_HOTEL_CATEGORIA
		FOREIGN KEY (codCategoria)
		REFERENCES CATEGORIAS(codCategoria),
)


CREATE TABLE HABITACIONES(
	codHotel BIGINT,
	codHabitacion BIGINT,
	tipoHabitacion VARCHAR(100) NOT NULL,
	precio DECIMAL(9,2) NOT NULL

	CONSTRAINT PK_HABITACIONES PRIMARY KEY (codHotel, codHabitacion),
	CONSTRAINT FK_HABITACIONES_HOTEL
		FOREIGN KEY (codHotel)
		REFERENCES HOTELES(codHotel)
)

CREATE TABLE PARTICULARES(
	codCliente BIGINT,
	DNI CHAR(12) NOT NULL,

	CONSTRAINT PK_PARTICULARES PRIMARY KEY (codCliente),
	CONSTRAINT FK_PARTICULAES_CLIENTES
		FOREIGN KEY (codCliente)
		REFERENCES CLIENTES(codCliente)
)

CREATE TABLE AGENCIAS(
	codCliente BIGINT,
	nombreAgencia VARCHAR(300) NOT NULL,

	CONSTRAINT PK_AGENCIAS PRIMARY KEY (codCliente),
	CONSTRAINT FK_AGENCIAS_CLIENTES
		FOREIGN KEY (codCliente)
		REFERENCES CLIENTES(codCliente)
)

CREATE TABLE RESERVAS(
	codReserva BIGINT IDENTITY,
	codHotel BIGINT NOT NULL,
	codHabitacion BIGINT NOT NULL,
	codCliente BIGINT NOT NULL,
	fechaInicio SMALLDATETIME NOT NULL,
	fechaFin SMALLDATETIME NOT NULL,
	precioTotal DECIMAL(9,2)

	CONSTRAINT PK_RESERVAS PRIMARY KEY (codReserva),

	CONSTRAINT FK_RESERVA_HABITACION_HOTEL
		FOREIGN KEY (codHotel, codHabitacion)
		REFERENCES HABITACIONES(codHotel, codHabitacion),
	CONSTRAINT FK_RESERVA_CLIENTE
		FOREIGN KEY (codCliente)
		REFERENCES CLIENTES(codCliente)
)




----------------------
--	EJERCICIO 4.2.3 --
----------------------

CREATE DATABASE AGENCIA_TRIBUTARIA
GO
USE AGENCIA_TRIBUTARIA
GO
CREATE TABLE CONTRIBUYENTE(
	NIF CHAR(12),
	nombre VARCHAR(200) NOT NULL,
	apellido1 VARCHAR(200) NOT NULL,
	apellido2 VARCHAR(200) NOT NULL,
	direccion VARCHAR(300) NOT NULL,
	codPostal DECIMAL(5,0) NOT NULL,

	CONSTRAINT PK_CONTRIBUYENTE PRIMARY KEY (NIF)
)

CREATE TABLE OFICINA(
	codOficina BIGINT IDENTITY,
	nombre VARCHAR(300) NOT NULL,
	direccion VARCHAR(300) NOT NULL,

	CONSTRAINT PK_OFICINA PRIMARY KEY (codOficina)
)

CREATE TABLE IMPUESTOS(
	codImpuesto BIGINT IDENTITY,
	importe DECIMAL(9,2) NOT NULL,
	fechaMaxPago SMALLDATETIME NOT NULL,
	anyo DECIMAL(4,0),

	CONSTRAINT PK_IMPUESTO PRIMARY KEY (codImpuesto)
)

CREATE TABLE IMPUESTO_IBI(
	codImpuesto BIGINT,
	valCatastral DECIMAL(9,2) NOT NULL,
	timpoImpositivo DECIMAL(3,1) NOT NULL,

	CONSTRAINT PK_IMPUESTO_IBI PRIMARY KEY (codImpuesto),
	CONSTRAINT FK_IMPUESTO_IBI
		FOREIGN KEY (codImpuesto)
		REFERENCES IMPUESTOS(codImpuesto)
)

CREATE TABLE IMPUESTO_IVTM(
	codImpuesto BIGINT,
	tipoVehiculo VARCHAR(200),
	caballosFiscales VARCHAR(10),

	CONSTRAINT PK_IMPUESTO_IVTM PRIMARY KEY (codImpuesto),
	CONSTRAINT FK_IMPUESTO_IVTM
		FOREIGN KEY (codImpuesto)
		REFERENCES IMPUESTOS(codImpuesto)
)

CREATE TABLE IMPUESTO_CONTRIBUYENTE_OFICINA(
	codPago BIGINT IDENTITY,
	NIF CHAR(12),
	codOficina BIGINT NOT NULL,
	codImpuesto BIGINT,

	CONSTRAINT PK_PAGO_CONTRIBUYENTE_OFICINA
		PRIMARY KEY (codPago),
	CONSTRAINT FK_CONTRIBUYENTE_PAGO
		FOREIGN KEY (NIF)
		REFERENCES CONTRIBUYENTE(NIF),
	CONSTRAINT FK_PAGO_OFICINA
		FOREIGN KEY (codOficina)
		REFERENCES OFICINA(codOficina),
	CONSTRAINT FK_PAGO_IMPUESTO
		FOREIGN KEY (codImpuesto)
		REFERENCES IMPUESTOS(codImpuesto)
)

CREATE TABLE IMPUESTO_IAE(
	codImpuesto BIGINT,
	factMediaAnual DECIMAL(9,2) NOT NULL,

	CONSTRAINT PK_IMPUESTO_IAE PRIMARY KEY (codImpuesto),
	CONSTRAINT FK_IMPUESTO_IAE
		FOREIGN KEY (codImpuesto)
		REFERENCES IMPUESTOS(codImpuesto)
)

CREATE TABLE PROVINCIA(
	codProv BIGINT IDENTITY,
	nombre VARCHAR(255) NOT NULL,

	CONSTRAINT PK_PROVINCIA PRIMARY KEY (codProv)
)

CREATE TABLE MUNICIPIO(
	codMuni BIGINT IDENTITY,
	codProv BIGINT,
	nombre VARCHAR(200) NOT NULL,

	CONSTRAINT PK_MUNICIPIO PRIMARY KEY (codMuni, codProv),
	CONSTRAINT FK_MUNICIPIO_PROVINCIA
		FOREIGN KEY (codProv)
		REFERENCES PROVINCIA(codProv)
)