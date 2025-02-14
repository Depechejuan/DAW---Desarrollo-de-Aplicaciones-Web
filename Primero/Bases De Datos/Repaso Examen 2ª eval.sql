--  CORRECIÓN EXAMEN

-- 3.5
SELECT *
  FROM CLIENTES
 WHERE codCliente IN (SELECT codCliente
											FROM PEDIDOS
										WHERE YEAR(fecha_pedido) = 2023)
		AND codCliente IN (SELECT codCliente
											FROM PAGOS
										WHERE importe_pago >= 1050
										GROUP BY codCliente
										HAVING COUNT(codCliente) = 2)
--SELECT c.codCliente
--  FROM CLIENTES C LEFT JOIN PEDIDOS P
--  ON C.codCliente = p.codCliente LEFT JOIN PAGOS PA
--  ON P.codCliente = pa.codCliente
-- WHERE YEAR(fecha_pedido) = 2023
--      AND importe_pago >= 1050
--	GROUP BY c.codCliente
--	HAVING COUNT(pa.codCliente) = 2


SELECT * FROM PAGOS



-- 3.3
SELECT *
  FROM PRODUCTOS
 WHERE precio_venta >= (SELECT AVG(precio_venta)
											FROM PRODUCTOS
										WHERE codCategoria IN (SELECT codCategoria
																						FROM CATEGORIA_PRODUCTOS
																					WHERE nombre = 'Frutales'))