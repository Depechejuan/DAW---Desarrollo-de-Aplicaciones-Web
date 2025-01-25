/*
CREACIÓN / MODIFICACIÓN DE TABLAS
NOTA: ANTES DE CREAR LAS TABLAS, MIRA MÁS ABAJO PARA VER QUÉ TIPOS DE DATOS DEBEN TENER

Crea las siguientes tablas:
STREAMERS (codStreamer, nombre, apellidos, pais, edad)
PK: codStreamer

TEMATICAS (codTematica, nombre)
PK: codTematica (se incrementa automáticamente)

STREAMERS_TEMATICAS (codStreamer, codTematica, idioma, medio, milesSeguidores)
PK: codStreamer, codTematica
FK: codStreamer -> STREAMERS
FK: codTematica -> TEMATICAS
*/


CREATE DATABASE STREAMERS
GO
USE STREAMERS
GO
CREATE TABLE STREAMERS (
	codStreamer CHAR(3) UNIQUE,
	nombre VARCHAR(100) NOT NULL,
	apellidos VARCHAR(255),
	pais VARCHAR(100),
	edad SMALLDATETIME

	CONSTRAINT PK_STREAMERS
		PRIMARY KEY (codStreamer),
)
CREATE TABLE TEMATICAS(
	codTematica BIGINT IDENTITY,
	nombre VARCHAR(100) NOT NULL

	CONSTRAINT PK_TEMATICAS
		PRIMARY KEY (codTematica)
)

CREATE TABLE STREAMERS_TEMATICAS(
	codStreamer CHAR(3),
	codTematica BIGINT,
	idioma VARCHAR(100) NOT NULL,
	medio VARCHAR(100) NOT NULL,
	milesSeguidores DECIMAL(9,0)

	CONSTRAINT PK_STREAMERS_TEMATICAS
		PRIMARY KEY (codStreamer, codTematica)
	CONSTRAINT FK_STREAMERS_TEMATICAS_S
		FOREIGN KEY (codStreamer)
		REFERENCES STREAMERS(codStreamer),
	CONSTRAINT FK_STREAMERS_TEMATICAS_T
		FOREIGN KEY (codTematica)
		REFERENCES TEMATICAS(codTematica)
)


/*
GESTIÓN DE TABLAS
Inserta los siguientes STREAMERS:
    -	Ibai Llanos de España (código 'ill')
    -	AuronPlay de España (código 'ap')
    -	Nate Gentile de España (código 'ng')
    -	Linus Tech Tips de Canadá (código 'ltt')
    -	DYI Perks sin ningún país (código 'dyi')
    -	Alexandre Chappel de Noruega (código 'ach')
    -	Tekendo de España (código 'tek')
    -	Caddac Tech de ningún país (código 'ct')



Inserta los siguientes TEMAS:
    -	Informática
    -	Tecnología en general
    -	Gaming
    -	Variado
    -	Bricolaje
    -	Viajes
    -	Humor

Inserta las siguientes TEMATICAS de STREAMERS:
    NOMBRESTREAMER	    TEMATICA	    idioma	    medio	    milesSeguidores
    AuronPlay								Gaming	        Español	    YouTube	    29200          
    Ibai Llanos	        Variado	        Español	    Twitch	    12800          
    AuronPlay	        Variado	        Español	    Twitch	    14900          
    Nate Gentile	    Informática	    Español	    YouTube	    2450           
    Linus Tech Tips	    Informática	    Inglés	    YouTube	    15200          
    DYI Perks	        Bricolaje	    Inglés	    YouTube	    4140           
    Alexandre Chappel	Bricolaje	    Inglés	    YouTube	    370            
    Caddac Tech	        Informática	    Inglés	    YouTube	    3       
*/
INSERT INTO STREAMERS
	VALUES	('ILL', 'Ibai', 'Llanos', 'España', null ),
					('AP', 'Auron', 'Play', 'España', null ),
					('NG', 'Nate', 'Gentile', 'España', null ),
					('LTT', 'Linus', 'Tech Tips', 'Canadá', null ),
					('DYI', 'DYI', 'Perks', null, null ),
					('ACH', 'Alexandre', 'Chappel', 'Noruega', null ),
					('TEK', 'Tekendo', null, 'España', null ),
					('CT', 'Caddac', 'Tech',null , null )


			
INSERT INTO TEMATICAS
		VALUES	('Informática'),
						('Tecnología En General'),
						('Gaming'),
						('Variado'),
						('Bricolaje'),
						('Viajes'),
						('Humor')
select * from STREAMERS
SELECT * FROM STREAMERS_TEMATICAS
SELECT * FROM TEMATICAS
INSERT INTO STREAMERS_TEMATICAS
			VALUES	('AP', 3, 'Español', 'YouTube', 29200),
							('ILL', 4, 'Español', 'Twitch', 12800),
							('AP', 4, 'Español', 'Twitch', 14900),
							('NG', 1, 'Español', 'YouTube', 2450),
							('LTT', 1, 'Inglés', 'YouTube', 15200),
							('DYI', 5, 'Inglés', 'YouTube', 4140),
							('ACH', 5, 'Inglés', 'YouTube', 370),
							('CT', 1, 'Inglés', 'YouTube', 3)

-----------------
--  CONSULTAS  --
-----------------
-- 01. Nombre de las temáticas que tenemos almacenadas, ordenadas alfabéticamente.
SELECT nombre
  FROM TEMATICAS
ORDER BY nombre ASC

-- 02. Cantidad de streamers cuyo país es "España".
SELECT *
  FROM STREAMERS
 WHERE pais = 'España'

-- 03, 04, 05. Nombres de streamers cuya segunda letra no sea una "B" (quizá en minúsculas), de 3 formas distintas.
-- Hacer 3 formas (una para cada uno)
SELECT nombre
  FROM STREAMERS
 WHERE LOWER(nombre) NOT LIKE '_b%'

-- NOT LIKE '_B%'

SELECT nombre
  FROM STREAMERS
 WHERE LOWER(SUBSTRING(nombre, 2, 1)) <> 'b'
-- SUBSTRING(nombre, 2,1) <> 'B'

SELECT nombre
  FROM STREAMERS
 WHERE LOWER(RIGHT(LEFT(nombre,2),1)) <> 'b'
--RIGHT(LEFT(nombre,2),1) <> 'B'

-- 06. Media de suscriptores para los canales cuyo idioma es "Español".
SELECT AVG(milesSeguidores), idioma
  FROM STREAMERS_TEMATICAS
 WHERE idioma = 'Español'
 GROUP BY idioma

-- 07. Media de seguidores para los canales cuyo streamer es del país "España".
SELECT AVG(ST.milesSeguidores), S.pais
  FROM STREAMERS S, STREAMERS_TEMATICAS ST
 WHERE S.codStreamer =ST.codStreamer
		AND S.pais = 'España'
 GROUP BY S.pais

-- 08. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, usando BETWEEN.
SELECT S.nombre, S.apellidos, ST.medio, ST.milesSeguidores
  FROM STREAMERS S LEFT JOIN  STREAMERS_TEMATICAS ST 
		ON S.codStreamer = ST.codStreamer
WHERE milesSeguidores BETWEEN 5000 AND 15000

-- 09. Nombre de cada streamer y medio en el que habla, para aquellos que tienen entre 5.000 y 15.000 miles de seguidores, sin usar BETWEEN.
SELECT S.nombre, S.apellidos, ST.medio, ST.milesSeguidores
  FROM STREAMERS S LEFT JOIN  STREAMERS_TEMATICAS ST
		ON S.codStreamer = ST.codStreamer
 WHERE ST.milesSeguidores >= 5000 AND ST.milesSeguidores <= 15000

-- 10. Nombre de cada temática y nombre de los idiomas en que tenemos canales de esa temática (quizá ninguno), sin duplicados.
SELECT T.nombre, ST.idioma
  FROM TEMATICAS T JOIN STREAMERS_TEMATICAS ST
		ON T.codTematica = ST.codTematica
 GROUP BY T.nombre, ST.idioma

-- 11. Nombre de cada streamer, nombre de la temática de la que habla y del medio en el que habla de esa temática, usando INNER JOIN.
SELECT CONCAT(s.nombre, ' ', s.apellidos) AS NombreStreamer, T.nombre, ST.idioma, ST.medio
  FROM STREAMERS S INNER JOIN STREAMERS_TEMATICAS ST
		ON S.codStreamer = ST.codStreamer
		INNER JOIN TEMATICAS T
		ON T.codTematica = ST.codTematica

-- 12. Nombre de cada streamer, nombre de la temática de la que habla y del medio en el que habla de esa temática, usando WHERE.
SELECT CONCAT(s.nombre, ' ', s.apellidos) AS NombreStreamer, T.nombre, ST.medio
  FROM STREAMERS S, STREAMERS_TEMATICAS ST, TEMATICAS T
 WHERE S.codStreamer = ST.codStreamer
		AND ST.codTematica = T.codTematica

-- 13. Nombre de cada streamer, del medio en el que habla y de la temática de la que habla en ese medio, 
-- incluso si de algún streamer no tenemos dato del medio o de la temática.
SELECT S.nombre, ST.medio
  FROM STREAMERS S  LEFT JOIN STREAMERS_TEMATICAS ST
	ON S.codStreamer = ST.codStreamer

-- 14. Nombre de cada medio y cantidad de canales que tenemos anotados en él, ordenado alfabéticamente por el nombre del medio.
SELECT medio, COUNT(s.codStreamer) AS TotalStreamers
  FROM STREAMERS_TEMATICAS ST JOIN STREAMERS S
		ON st.codStreamer = s.codStreamer
 GROUP BY medio
  ORDER BY medio ASC

-- 15, 16, 17, 18. Medio en el que se emite el canal de más seguidores, de 4 formas distintas.
-- HAY SOLO 3 FORMAS HUMANAS
SELECT TOP(1) milesSeguidores, medio
  FROM STREAMERS_TEMATICAS
ORDER BY milesSeguidores DESC

SELECT medio, milesSeguidores
  FROM STREAMERS_TEMATICAS
 WHERE milesSeguidores >= (SELECT MAX(milesSeguidores) FROM STREAMERS_TEMATICAS)

 SELECT medio, milesSeguidores
  FROM STREAMERS_TEMATICAS
 WHERE milesSeguidores >= ALL (SELECT milesSeguidores FROM STREAMERS_TEMATICAS)
 
-- ¿4ª forma?


-- 19. Categorías de las que tenemos 2 o más canales.
SELECT COUNT(ST.codTematica) AS TotalCanales, T.nombre
  FROM STREAMERS_TEMATICAS ST LEFT JOIN TEMATICAS T
		ON ST.codTematica = T.codTematica
 GROUP BY T.nombre
 HAVING COUNT(ST.codTematica) >= 2

-- 20. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando COUNT.
SELECT COUNT(S.codStreamer) AS NumCanales, T.nombre
  FROM STREAMERS S LEFT JOIN STREAMERS_TEMATICAS ST
	ON S.codStreamer = ST.codStreamer
	RIGHT JOIN TEMATICAS T
	ON T.codTematica = ST.codTematica
GROUP BY T.nombre
HAVING COUNT(S.codStreamer) = 0
ORDER BY T.nombre ASC


-- 21. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando IN / NOT IN.
SELECT *
  FROM TEMATICAS T
 WHERE T.codTematica NOT IN (SELECT codTematica FROM STREAMERS_TEMATICAS)
 ORDER BY nombre ASC

-- 22. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando ALL / ANY.


-- 23. Categorías de las que no tenemos anotado ningún canal, ordenadas alfabéticamente, empleando EXISTS / NOT EXISTS.
SELECT *
  FROM TEMATICAS T
 WHERE NOT EXISTS (SELECT 1 FROM STREAMERS_TEMATICAS ST WHERE ST.codTematica = T.codTematica)
 ORDER BY nombre ASC


 -- NO RELACIONADO
SELECT *
  FROM STREAMERS_TEMATICAS ST RIGHT JOIN TEMATICAS T
	ON ST.codTematica = T.codTematica
 WHERE ST.codStreamer IS NULL


-- 24. Tres primeras letras de cada país y tres primeras letras de cada idioma, en una misma lista.
SELECT LEFT(pais, 3)
  FROM STREAMERS 
 WHERE pais IS NOT NULL
UNION
SELECT  LEFT(idioma,3)
  FROM STREAMERS_TEMATICAS
 WHERE idioma IS NOT NULL

-- 25, 26, 27, 28. Tres primeras letras de países que coincidan con las tres primeras letras de un idioma, sin duplicados, de cuatro formas distintas.
SELECT LEFT(pais, 3)
  FROM STREAMERS 
 WHERE pais IS NOT NULL
INTERSECT
SELECT  LEFT(idioma,3)
  FROM STREAMERS_TEMATICAS
 WHERE idioma IS NOT NULL

 ------------------

 SELECT DISTINCT LEFT(pais,3) AS PaisIdioma
   FROM STREAMERS S, STREAMERS_TEMATICAS
 WHERE LEFT(pais,3) = LEFT(idioma,3)

SELECT DISTINCT LEFT(pais,3)
  FROM STREAMERS
 WHERE LEFT(pais,3) IN (SELECT LEFT(idioma,3) FROM STREAMERS_TEMATICAS)




-- 29. Nombre de streamer, nombre de medio y nombre de temática, para los canales que están por encima de la media de suscriptores.
SELECT S.nombre, st.medio, T.nombre
  FROM STREAMERS S LEFT JOIN STREAMERS_TEMATICAS ST
     ON S.codStreamer = ST.codStreamer
	 RIGHT JOIN TEMATICAS T
	 ON t.codTematica = st.codTematica
 WHERE ST.milesSeguidores > (SELECT AVG(milesSeguidores) FROM STREAMERS_TEMATICAS)

-- 30. Nombre de streamer y medio, para los canales que hablan de la temática "Bricolaje".
SELECT s.nombre, st.medio
  FROM STREAMERS S LEFT JOIN STREAMERS_TEMATICAS ST
     ON s.codStreamer = st.codStreamer
	 JOIN TEMATICAS T
	 ON st.codTematica = t.codTematica
 WHERE t.nombre = 'Bricolaje'
 
-- 31. Crea una tabla de "juegos". Para cada juego querremos un código (clave primaria), un nombre (hasta 20 letras, no nulo) 
-- y una referencia al streamer que más habla de él (clave ajena a la tabla "streamers").
CREATE TABLE JUEGOS(
	codJuego BIGINT IDENTITY,
	nombre VARCHAR(20) NOT NULL,
	codStreamer CHAR(3)

	CONSTRAINT PK_JUEGOS
		PRIMARY KEY (codJuego)
	CONSTRAINT FK_STREAMER_JUEGO
		FOREIGN KEY (codStreamer)
		REFERENCES STREAMERS(codStreamer)
)

-- 32. Añade a la tabla de juegos la restricción de que el código debe ser 1000 o superior.
ALTER TABLE JUEGOS
DROP CONSTRAINT PK_JUEGOS

ALTER TABLE JUEGOS
DROP COLUMN codJuego

ALTER TABLE JUEGOS
ADD codJuego BIGINT IDENTITY(1000,1)

ALTER TABLE JUEGOS
ADD CONSTRAINT PK_JUEGOS PRIMARY KEY (codJuego)



-- 33. Añade 3 datos de ejemplo en la tabla de juegos. Para uno indicarás todos los campos, para otro no indicarás el streamer, ayudándote de NULL, y para el tercero no indicarás el streamer porque no detallarás todos los nombres de los campos.
INSERT INTO JUEGOS (nombre, codStreamer, codJuego)
			VALUES	('Final Fantasy VII', 1, 1001)
							('Starcraft')
							('Counter Strike')


-- 34. Borra el segundo dato de ejemplo que has añadido en la tabla de juegos, a partir de su código.

-- 35. Muestra el nombre de cada juego junto al nombre del streamer que más habla de él, si existe. Los datos aparecerán ordenados por nombre de juego y, en caso de coincidir éste, por nombre de streamer.

-- 36. Modifica el último dato de ejemplo que has añadido en la tabla de juegos, para que sí tenga asociado un streamer que hable de él.

-- 37. Crea una tabla "juegosStreamers", volcando en ella el nombre de cada juego (con el alias "juego") y el nombre del streamer que habla de él (con el alias "streamer").

-- 38. Añade a la tabla "juegosStreamers" un campo "fechaPrueba".

-- 39. Pon la fecha de hoy (prefijada, sin usar GetDate) en el campo "fechaPrueba" de todos los registros de la tabla "juegosStreamers".

-- 40. Muestra juego, streamer y fecha de ayer (día anterior al valor del campo "fechaPrueba") para todos los registros de la tabla "juegosStreamers".

-- 41. Muestra todos los datos de los registros de la tabla "juegosStreamers" que sean del año actual de 2 formas distintas (por ejemplo, usando comodines o funciones de cadenas).

-- 42. Elimina la columna "streamer" de la tabla "juegosStreamers".

-- 43. Vacía la tabla de "juegosStreamers", conservando su estructura.

-- 44. Elimina por completo la tabla de "juegosStreamers".

-- 45. Borra los canales del streamer "Caddac Tech".

-- 46. Muestra la diferencia entre el canal con más seguidores y la media, mostrada en millones de seguidores. Usa el alias "diferenciaMillones".

-- 47. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", sin duplicados, usando IN (pero no en una subconsulta).

-- 48. Medios en los que tienen canales los creadores de código "ill", "ng" y "ltt", sin duplicados, sin usar IN.

-- 49. Nombre de streamer y nombre del medio en el que habla, para aquellos de los que no conocemos el país.

-- 50. Nombre del streamer y medio de los canales que sean del mismo medio que el canal de Ibai Llanos que tiene 12800 miles de seguidores (puede aparecer el propio Ibai Llanos).

-- 51. Nombre del streamer y medio de los canales que sean del mismo medio que el canal de Ibai Llanos que tiene 12800 miles de seguidores (sin incluir a Ibai Llanos).

-- 52. Nombre de cada streamer, medio y temática, incluso si para algún streamer no aparece ningún canal o para alguna temática no aparece ningún canal.

-- 53. Nombre de medio y nombre de cada temática, como parte de una única lista (quizá desordenada).

-- 54. Nombre de medio y nombre de cada temática, como parte de una única lista ordenada alfabéticamente.

-- 55. Nombre de medio y cantidad media de suscriptores en ese medio, para los que están por encima de la media de suscriptores de los canales.

-- 56. Nombre de los streamers que emiten en YouTube y que o bien hablan en español o bien sus miles de seguidores están por encima de 12.000.

-- 57. Añade información ficticia sobre ti: datos como streamer, temática sobre la que supuestamente y medio en el que hablas sobre ella, sin indicar cantidad de seguidores. Crea una consulta que muestre todos esos datos a partir de tu código.

-- 58. Muestra el nombre de cada streamer, medio en el que emite y cantidad de seguidores, en millones, redondeados a 1 decimal.

-- 59. Muestra el nombre de cada streamer y el país de origen. Si no se sabe este dato, deberá aparecer "(País desconocido)".

-- 60. Muestra, para cada streamer, su nombre, el medio en el que emite (precedido por "Emite en: ") y el idioma de su canal (precedido por "Idioma: ")

-- 61. Actualiza la edad del streamer Ibai Llanos a 24 y actualiza la de AuronPlay a 30.

-- 62. Devuelve el número de canales que tiene cada streamer, siempre y cuando, el número de seguidores sea superior a la media de seguidores.

-- 63. Amplía el campo "medio" de la tabla TEMATICAS de STREAMERS en 5 caracteres (a lo que ya tuvieras).

-- 64. Quita la restricción FK sobre el campo codStreamer de la tabla TEMATICAS de STREAMERS.

-- 65. Vuelve a dejar la restricción como estaba, es decir, activa.

-- 66. Crea una restricción check que impida introducir valores negativos en el campo "milesSeguidores".

-- 67. Crea una vista que devuelva todos los canales de cada streamer, incluyendo su nombre y el nombre de las temáticas

-- 68. Crea una copia de la tabla streamers llamada STREAMERS_BACKUP

-- 69. Inserta dos nuevos streamers en una única sentencia.

-- 70. Realiza el borrado de todos los registros de todas las tablas en su orden correcto.

-- 71. Elimina todas las tablas.
