---------------------
-- 4.1 EJERCICIO 1 --
---------------------

--CREATE DATABASE CONCESIONARIOv2
--USE CONCESIONARIOv2
CREATE TABLE PROPIETARIOS (
	DNI CHAR(10),
	nombre VARCHAR(100) NOT NULL,
	apellido VARCHAR(150) NOT NULL,
	apellido2 VARCHAR(150),
	direccion VARCHAR(250)

	CONSTRAINT PK_PROPIETARIOS PRIMARY KEY (DNI)
)

SELECT * FROM PROPIETARIOS

CREATE TABLE COCHES(
	numBastidor CHAR(17),
	matricula CHAR(7),
	marca CHAR(50),
	modelo CHAR(50),
	DNI_propietario CHAR(10)

	CONSTRAINT PK_COCHES PRIMARY KEY (numBastidor),
	CONSTRAINT AK_COCHES UNIQUE (matricula),
	CONSTRAINT FK_COCHES_PROPIETARIOS FOREIGN KEY (DNI_propietario)
		REFERENCES PROPIETARIOS(DNI)
)

--------------------
-- Correcciones	  --
--------------------

-- Cambiar tabla para añadir, cambiar o quitra atributos
ALTER TABLE PROPIETARIOS
	ALTER COLUMN nombre VARCHAR(170) NOT NULL

-- Cambio de Matrícula para retrocompatibilidad
-- Usar "Alter Table" para generar las constraint a posteriori
ALTER TABLE COCHES
	DROP CONSTRAINT AK_COCHES
	
ALTER TABLE COCHES
	ALTER COLUMN matricula CHAR(10)

ALTER TABLE COCHES
	ADD CONSTRAINT AK_COCHES_matricula UNIQUE (matricula)


ALTER TABLE COCHES
	ALTER COLUMN marca VARCHAR(100) NOT NULL

ALTER TABLE COCHES
	ALTER COLUMN modelo VARCHAR(100) NOT NULL 

---------------------
-- 4.1 EJERCICIO 2 --
---------------------

CREATE DATABASE TIENDAv2

CREATE TABLE PROVEEDORES(
	codProv INT IDENTITY,
	nombre VARCHAR(150) NOT NULL,
	apellido1 VARCHAR(150) NOT NULL,
	apellido2 VARCHAR(150),
	direccion VARCHAR(300),

	CONSTRAINT PK_PROVEEDORES PRIMARY KEY (codProv)
)

CREATE TABLE ARTICULOS(
	codArt INT IDENTITY,
	descripcion VARCHAR(300) NOT NULL,
	precio DECIMAL(9,2),
	existencias DECIMAL(9,0) DEFAULT 0 -- El profesor prefiere SMALLINT para este caso

	CONSTRAINT PK_ARTICULOS PRIMARY KEY (codArt)
)

CREATE TABLE SUMINISTROS(
	codProv INT,
	codArt INT NOT NULL,
	unidades SMALLINT,
	fechaRecepcion SMALLDATETIME,

	CONSTRAINT PK_SUMINISTROS PRIMARY KEY (codProv, codArt),
	CONSTRAINT FK_SUMINISTROS_PROVEEDORES
		FOREIGN KEY (codProv)
		REFERENCES PROVEEDORES(codProv),
	CONSTRAINT FK_SUMINISTROS_ARTICULOS
		FOREIGN KEY (codArt)
		REFERENCES ARTICULOS (codArt)
)

--------------------
-- Correcciones	  --
--------------------
-- Añadir campos a proveedor - Opcional
ALTER TABLE PROVEEDORES
ADD telefono CHAR(15) NOT NULL

ALTER TABLE PROVEEDORES
ADD email VARCHAR(100)

ALTER TABLE ARTICULOS
ADD nombre VARCHAR(100) NOT NULL

ALTER TABLE ARTICULOS
ALTER COLUMN descripcion VARCHAR(1000)

ALTER TABLE ARTICULOS
ALTER COLUMN precio DECIMAL(9,2) NOT NULL

-- Añadir restricciones sobre el campo UNIDADES de SUMINISTROS para uqe no puedan ser ni 0 ni -
ALTER TABLE SUMINISTROS
ADD CONSTRAINT CK_SUMINISTROS_unidades CHECK (unidades > 0)
-- Hay registros que podrían no cumplirse. Primero editar esos registros y luego, cambiarlo

---------------------
-- 4.1 EJERCICIO 3 --
---------------------

CREATE DATABASE LIBRERIA
CREATE TABLE TEMAS (
	codTema INT IDENTITY,
	nombre VARCHAR(200),

	CONSTRAINT PK_TEMAS PRIMARY KEY (codTema)
)

CREATE TABLE LIBROS(
	ISBN CHAR(13),
	titulo VARCHAR(150),
	autor VARCHAR(300),
	numEjemplares DECIMAL(5,0)
)