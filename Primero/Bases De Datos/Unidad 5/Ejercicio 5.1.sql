---------------------------------------------------------------
-- Ejercicio 5.1. Obtén las siguientes consultas con funciones
---------------------------------------------------------------

/* Obtén el valor absoluto de un número entero (-17) -> resultado 17 */
SELECT ABS(-17);

/* Número parte entera de un número decimal (35.789) -> resultado 35 */
SELECT ROUND(FLOOR(35.789), 0)

/* Resto de una división entre dos números enteros (15 y 4) */
SELECT 15%4;

/* Potencia de un número y su exponente: 5 elevado a 3 -> resultado = 125 */
SELECT POWER(5, 3)

/* Raíz cuadrada de un número (81) */
SELECT SQRT(81)

/* Número aleatorio decimal entre 0 y 1 */
SELECT ROUND(RAND(), 0)

/* Número aleatorio decimal entre 0 y 9 (Hasta 10?)*/
SELECT ROUND(RAND(), 1)
SELECT FLOOR(RAND()*10) + ROUND(RAND(), 0)
SELECT FLOOR(RAND()*11)

/* Número aleatorio decimal entre 0 y 99  (Hasta 100?)*/
SELECT ROUND(RAND(), 2)
SELECT FLOOR(RAND()*100) + ROUND(RAND(), 0)

/* Redondea el número 45.267 a un decimal */
SELECT ROUND(45.257, 1)
-- Salen 3 decimales a 0... ¿Se puede cambiar?

/* Obtén el signo del número (-45.6) */
SELECT LEFT(-45.6, 1)

/* Concatena estas cadenas en una sola: José García López */
SELECT CONCAT('Jose', ' ', 'García', ' ', 'Lopez')

/* Convierte la cadena a mayúsculas: Estudio FP en el IES Mare Nostrum */
SELECT UPPER('Estudio FP en el IES Mare Nostrum')


/* Convierte la cadena a minúsculas: Estudio FP en el IES Mare Nostrum */
SELECT LOWER('Estudio FP en el IES Mare Nostrum')

/* Obtén el principio de una cadena (el nombre) de José García López -> José */
SELECT LEFT('José García López', 4)

/* Obtener una parte final de la cadena anterior (apellido2) -> García */
SELECT RIGHT('José García López', 5)

/* Obtener una parte central de la cadena anterior (apellido1) -> López */
SELECT SUBSTRING('José García López', 6, 7)

/* Obtener la longitud la cadena José García López -> 17 */
SELECT LEN('José García López')

/* Obtén la letra del siguiente DNI 12345678M -> M */
SELECT RIGHT('12345678M', 1)

/* Eliminar de la cadena '   Juan López García   ' los espacios al principio y al final*/
SELECT TRIM('   Juan López García   ')

/* Obtén la longitud de la cadena '   Juan López García   ' */
SELECT LEN('   Juan López García   ')

/* Obtén la longitud de la cadena '   Juan López García   ' sin los espacios (utiliza la función del ejercicio anterior para quitarlos) */
SELECT LEN(TRIM('   Juan López García   '))

/* Reemplaza en la cadena 'SQL Tutorial', SQL por HTML */
SELECT REPLACE('SQL Tutorial', 'SQL', 'HTML')

/* Muestra 'SQL Tutorial' de forma inversa */
SELECT REVERSE('SQL Tutorial')

/* Obtener la FECHA y HORA actual */
SELECT CURRENT_TIMESTAMP

/* Añadir 10 días a la FECHA ‘03/05/2023’ */
SELECT DATEADD(DAY, 10, '2023-05-03')

/* Añadir 2 años a la FECHA ‘29/10/2022’ */
SELECT DATEADD(YEAR, 2, '2022-10-29')

/* Diferencia de días entre las FECHAS: 10/02/2023 y 25/03/2023 */
SELECT DATEDIFF(DAY, '2023-02-10', '2023-03-25')

/* Obtener el valor del DÍA de la FECHA ACTUAL */
SELECT (DAY(CURRENT_TIMESTAMP))

/* Obtener el valor del MES de la FECHA ACTUAL */
SELECT (MONTH(CURRENT_TIMESTAMP))

/* Obtener el valor del AÑO de la FECHA ACTUAL */
SELECT (YEAR(CURRENT_TIMESTAMP))

 /*Obtener nombre del mes con letras de la fecha 19/03/2023 */
 SELECT DATENAME(MONTH, '2023-03-19')


/* Utilizando la función CHARINDEX() obtén la palabra 'news' de la frase 'No news is good news'
    Debes utilizar también la función LEFT y/o RIGHT
    Nota: Su equivalente en Oracle es la función INSTR()
*/

-- Solución utilizando CHARINDEX y LEFT o RIGHT
DECLARE @FullString VARCHAR(21) ='No news is good news'
DECLARE @News VARCHAR(4) = 'news'

--Usando Sub-String por comodidad
-- SELECT SUBSTRING('No news is good news', CHARINDEX('news', 'No news is good news'), LEN('news'))

SELECT RIGHT(LEFT(@FullString, CHARINDEX(@News, @FullString)+LEN(@News)-1), LEN(@News))
-- Otra forma sin CharIndex


-- Solución en la que NO se indican los 4 caracteres que queremos seleccionar con LEFT o RIGHT
-- Hay que obtenerlos de otro modo
SELECT LEFT(RIGHT(@FullString, LEN(@FullString) - LEN(@News) + 1), LEN(@News))


/* Supón que tenemos una tabla llamada PIE_FIRMA que consta de dos campos (no se hará con la tabla, sino con strings)
    - fechaFirma DATE
    - lugarFirma VARCHAR(100)

    A partir de la siguiente SELECT, genera el siguiente pie de firma a este:
    'En Alicante, a 8 de junio de 2022'
 */
 DECLARE @lugarFirma VARCHAR(30) = 'Alicante'
 DECLARE @fechaFirma DATE = '2022-06-08'
 SELECT CONCAT('En ', @lugarFirma, ', a ', DATENAME(DAY, @fechaFirma),
			' de ', DATENAME(MONTH, @fechaFirma), ' de ',
			DATENAME(YEAR, @fechaFirma))

-- CORRECCIÓN
 SELECT CONCAT('En ', @lugarFirma, ', a ', DAY(@fechaFirma),
			' de ', DATENAME(MONTH, @fechaFirma), ' de ',
			YEAR(@fechaFirma))
/* Utiliza la función ASCII() para obtener el valor ASCII de un carácter
    Para el carácter A debe devolver 65
*/

SELECT ASCII('A')

/* Investiga el uso de la función TRANSLATE() y haz un ejemplo de uso */
/*
	La función "Translate" sustituye los carácteres ya establecidos por otros.
	Recibe 3 argumentos: (Entrada sin editar, carácteres a editar(antes), caracteres deseados (despues))
*/

SELECT TRANSLATE('Hola Mundo', 'o', '0')


/* Investiga el uso de la función REPLICATE() y haz un ejemplo de uso */
SELECT REPLICATE('hola', 3)
-- Aparece 8 veces hola


/* Investiga el uso de la función SPACE() y haz un ejemplo de uso */
SELECT SPACE(8);
-- 8 espacios en blanco, en este ejemplo
