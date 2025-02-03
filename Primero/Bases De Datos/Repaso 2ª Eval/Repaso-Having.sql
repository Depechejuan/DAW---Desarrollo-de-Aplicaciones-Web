-- Obtener los clientes que han realizado más de 5 pedidos.

SELECT codCliente
  FROM PEDIDOS
 GROUP BY codCliente
HAVING COUNT(codPedido) > 3

-- Mostrar los productos que han sido comprados en más de 3 pedidos.
SELECT codProducto, unidades
  FROM LINEAS_PEDIDOS 
 GROUP BY codProducto, unidades
HAVING SUM(unidades) > 2

-- CORRECCIÓN

SELECT codProducto, COUNT(DISTINCT codPedido) AS totalPedidos
FROM LINEAS_PEDIDOS
GROUP BY codProducto
HAVING COUNT(DISTINCT codPedido) > 2;



-- Listar las tiendas que tienen un stock total de productos superior a 1000 unidades.
SELECT T.nombre
  FROM TIENDAS T LEFT JOIN STOCK_PRODUCTOS SP
		ON t.codTienda = SP.codTienda LEFT JOIN PRODUCTOS P
		ON sp.codProducto = p.codProducto
GROUP BY T.nombre
HAVING COUNT(sp.stock) > 1000

-- CORRECCIÓN
SELECT T.nombre
  FROM TIENDAS T LEFT JOIN STOCK_PRODUCTOS SP 
	ON T.codTienda = SP.codTienda
GROUP BY T.nombre
HAVING SUM(SP.stock) > 1000;
 

--Obtener las campañas en las que el descuento promedio es superior al 15%.
SELECT C.nombre
  FROM CAMPANYAS C LEFT JOIN CAMPANYAS_PRODUCTOS CP
	ON c.codCampanya = CP.codCampanya
 WHERE descuento > 41
GROUP BY c.nombre
-- No es necesario HAVING? -- HAVING descuento > 15
-- CORRECCIÓN
SELECT C.nombre
FROM CAMPANYAS C 
LEFT JOIN CAMPANYAS_PRODUCTOS CP ON C.codCampanya = CP.codCampanya
GROUP BY C.nombre
HAVING AVG(CP.descuento) > 24;


-- Mostrar los vendedores que han gestionado más de 10 pedidos.
SELECT v.nombre
  FROM VENDEDORES V LEFT JOIN PEDIDOS P
	ON v.codVendedor = p.codVendedor
GROUP BY v.nombre
HAVING COUNT(p.codVendedor) > 10

-- CORRECCIÓN
SELECT V.nombre
FROM VENDEDORES V LEFT JOIN PEDIDOS P 
	ON V.codVendedor = P.codVendedor
GROUP BY V.nombre
HAVING COUNT(p.codPedido) > 10;
