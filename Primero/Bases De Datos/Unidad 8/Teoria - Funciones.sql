-- --	--	--	--	--	--	--
-- FUNCIONES	--
--	--	--	--	--	--	--	--
GO
CREATE OR ALTER FUNCTION suma (@numero1 INT, @numero2 INT)
RETURNS INT -- OJO!! ES RETURNSSSSSSSS, devuelve un TIPO DE DATOS concreto
AS
BEGIN
	RETURN @numero1+@numero2
END

SELECT dbo.suma(2,3) AS suma


----------------------------

CREATE OR ALTER FUNCTION costePedido (@codPedido INT)
RETURNS DECIMAL(11,2)
AS
BEGIN
	DECLARE @salida DECIMAL(11,2)
	RETURN (SELECT ISNULL(SUM(precio_unidad*cantidad), 0)
	  FROM DETALLE_PEDIDOS
	 WHERE codPedido = @codPedido)
END

SELECT dbo.costePedido(1) AS sumPedido

-- Otra opción
DECLARE @resultado DECIMAL(11,2)
SET @resultado = dbo.costePedido(1)
PRINT @resultado

-- Otra opción
SELECT codPedido, dbo.costePedido(codPedido) AS coste
  FROM PEDIDOS
  -- Se puede llamar como parámetro de una select,las posibilidades son infinitas.



-----
GO

CREATE OR ALTER FUNCTION productosPedido (@codPedido INT)
RETURNS INT
AS
BEGIN
	--IF ISNULL(@codPedido, 0) <= 0
	--	OR NOT EXISTS (SELECT 1
	--									FROM PEDIDOS
	--								  WHERE codPedido = @codPedido)

	RETURN (SELECT COUNT(codPedido)
						FROM DETALLE_PEDIDOS
					 WHERE codPedido = @codPedido)
END

SELECT codPedido, dbo.productosPedido(codPedido) AS cantidadProductos
  FROM PEDIDOS P



  ---------------------
-- Funcion que devuelva una "s" si el cliente ha realizado algún pedido, y una "n" no ha realizado ninguno
-- USA CAMELCASE
CREATE OR ALTER FUNCTION HaRealizadoPedido_SN (@codCliente INT)
RETURNS CHAR(1)
AS
BEGIN
	
	IF EXISTS (SELECT codPedido
							FROM PEDIDOS
						 WHERE codCliente = @codCliente)
		RETURN 'S'
	RETURN 'N'
END

SELECT codCliente, dbo.HaRealizadoPedido_SN(codCliente)
  FROM CLIENTES




-- Funciones que devuelve una tabla
-- Que devuelva los clientes con minimo
CREATE OR ALTER FUNCTION clientesLimiteCredito(@limite_credito DECIMAL(9,2))
RETURNS TABLE
AS
	RETURN (SELECT *
						FROM CLIENTES
					 WHERE limite_credito >= @limite_credito)


SELECT *
  FROM dbo.clientesLimiteCredito(50000.00)


