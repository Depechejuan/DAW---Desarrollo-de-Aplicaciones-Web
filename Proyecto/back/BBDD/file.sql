CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL, -- Será autogenerada si es personal veterinario
    telefono VARCHAR(15),
    fechaNacimiento DATE,
    tipoVia VARCHAR(50), -- Calle, avenida, paseo, etc.
    nombreVia VARCHAR(255),
    numero VARCHAR(255),
    escalera VARCHAR(10),
    piso VARCHAR(10),
    portal VARCHAR(10),
    codigoPostal VARCHAR(10),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    isVet BOOLEAN DEFAULT FALSE, -- Por defecto es 'false'
    CONSTRAINT email_formato CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') -- Validación de formato de email
);

CREATE TABLE mascota (
    id SERIAL PRIMARY KEY,
    pasaporte VARCHAR(20) UNIQUE, -- Clave alternativa, puede ser NULL
    nombre VARCHAR(100) NOT NULL,
    tipoAnimal VARCHAR(50) NOT NULL, -- Ejemplo: Gato, Perro, etc.
    raza VARCHAR(50),
    fechaNacimiento DATE,
    peso DECIMAL(5,2), -- Peso en kg, por ejemplo
    color VARCHAR(30)
);


CREATE TABLE cliente_mascota (
    idCliente INT REFERENCES cliente(id),
    idMascota INT REFERENCES mascota(id),
    PRIMARY KEY (idCliente, idMascota)
);

CREATE TABLE tratamiento (
    id SERIAL PRIMARY KEY,
    tipoTratamiento VARCHAR(100) NOT NULL, -- Ejemplo: Vacuna, Operación
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL, -- Precio en la moneda local
    duracion INT -- Duración del tratamiento en minutos
);


CREATE TABLE mascota_tratamiento (
    idMascota INT REFERENCES mascota(id),
    idTratamiento INT REFERENCES tratamiento(id),
    fechaTratamiento DATE NOT NULL,
    observaciones TEXT,
    PRIMARY KEY (idMascota, idTratamiento, fechaTratamiento)
);

CREATE TABLE cita (
    id SERIAL PRIMARY KEY,
    idCliente INT REFERENCES cliente(id),
    idMascota INT REFERENCES mascota(id),
    fechaCita TIMESTAMP NOT NULL,
    motivo TEXT -- Motivo o razón de la cita
);
