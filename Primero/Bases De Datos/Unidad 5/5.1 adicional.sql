/*
Imagina que estás trabajando en una base de datos para gestionar eventos. La tabla EVENTOS tiene la siguiente estructura:

--------------------------------------------------------------
|codEvento	nombre	                fecha	        ciudad   |
--------------------------------------------------------------
    1	    Conferencia de SQL	    2024-12-05	    Madrid
    2	    Taller de Programación	2024-11-29	    Barcelona
    3	    Seminario de IA	        2025-01-15	    Valencia
--------------------------------------------------------------

*/

-- 1. Crea la tabla EVENTOS
DROP DATABASE IF EXISTS EJERCICIO5
GO
CREATE DATABASE EJERCICIO5
GO
USE EJERCICIO5
GO

CREATE TABLE EVENTOS (
	codEvento BIGINT IDENTITY,
	nombre VARCHAR(200),
	fecha DATE,
	ciudad VARCHAR(150),

	CONSTRAINT PK_EVENTOS PRIMARY KEY (codEvento)
)


-- 2. Inserta en modo gráfico los tres eventos anteriores
INSERT INTO EVENTOS(nombre, fecha, ciudad)
		VALUES
			('Conferencia de SQL', '2024-12-05', 'Madrid'),
			('Taller de Programación', '2024-11-29', 'Barcelona'),
    		('Seminario de IA', '2025-01-15', 'Valencia')

-- prueba
SELECT * FROM EVENTOS

-- A partir de aquí deberás diseñar consultas que realicen determinadas acciones.

-- 3. Realiza una consulta que devuelva el código del evento y nombre del evento
-- y la ciudad formateado como: "nombre (ciudad)"
SELECT codEvento, CONCAT(nombre, ' ', '(', ciudad, ')')
  FROM EVENTOS

-- 4. Usa LEFT, RIGHT y SUBSTRING para responder a las siguientes preguntas:
--	    4.1 Extrae los primeros 10 caracteres de cada evento.
SELECT LEFT(nombre, 10)
  FROM EVENTOS

--	    4.2 Extrae los últimos 5 caracteres del nombre de cada ciudad.
SELECT RIGHT(ciudad, 5)
  FROM EVENTOS

--	    4.3 Extrae los caracteres 3 a 8 de cada "nombre"
SELECT SUBSTRING(nombre, 3, 5)
  FROM EVENTOS


-- 5. Cambia la palabra "de" por "sobre" en el campo "nombre"
SELECT REPLACE(nombre, ' de ', ' sobre ')
  FROM EVENTOS

-- 6. Calcula cuántos días faltan o han transcurrido para cada evento
-- desde la fecha actual (para la fecha actual puedes utilizar GetDate()).
SELECT DATEDIFF(DAY, fecha, GetDate()) AS FECHA_DIFF
  FROM EVENTOS
-- Devuelve negativo, cambiando fecha y getdate en orden daría en positivo.
-- En este caso sería "Faltan X días", al contrario sería "Han pasado X días".

-- 7. Añade 30 días a la fecha de cada evento para obtener una fecha de seguimiento
SELECT DATEADD(DAY, 30, fecha)
  FROM EVENTOS


-- 8. Consulta que devuelva todos los campos de la tabla EVENTOS
-- y otro que generes tú mismo/a que represente la popularidad de cada uno de ellos
--      Deberás generar un número aleatorio entre 1 y 100.
--      Si ejecutas la consulta varias veces deberás observar popularidades diferentes en cada ejecución
 -- Popularidad = RANDOM !!!
SELECT *, ROUND(RAND() * 100, 2) AS popularidad FROM EVENTOS

-- Popularidad estática. Para cambiarlo:
ALTER TABLE EVENTOS
ADD popularidad VARCHAR(200)

UPDATE EVENTOS
SET popularidad = ROUND(RAND() * 100, 2)
WHERE codEvento = 1;

UPDATE EVENTOS
SET popularidad = ROUND(RAND() * 100, 2)
WHERE codEvento = 2;

UPDATE EVENTOS
SET popularidad = ROUND(RAND() * 100, 2)
WHERE codEvento = 3;

SELECT * FROM EVENTOS


-- 9. Crea una consulta final que combine todos los resultados anteriores, de modo que se devuelva:
--      Nombre del evento formateado, fecha original, fecha seguimiento, días restantes, últimos 5 caracteres de la ciudad y índice de popularidad generado.


SELECT codEvento, CONCAT(nombre, ' ', '(', ciudad, ')') AS FormattedName, 
	fecha, DATEADD(DAY, 30, fecha) AS Fecha_Seguimiento, 
	DATEDIFF(DAY, fecha, GetDate()) AS FECHA_DIFF, RIGHT(ciudad, 5) AS city,
	popularidad
  FROM EVENTOS

