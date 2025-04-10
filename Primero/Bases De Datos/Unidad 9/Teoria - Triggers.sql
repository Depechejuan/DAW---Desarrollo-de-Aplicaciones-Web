--	--	--	--	--	--	--
-- TRIGGERS	--
--	--	--	--	--	--	--

-- Existen 2:
-- After
-- Instead Of

GO
CREATE OR ALTER TRIGGER TRG_CLIENTES_UPD_DEL ON CLIENTES
AFTER UPDATE, DELETE
AS
BEGIN
	INSERT INTO CLIENTES_HISTORICO
	SELECT *, GETDATE()
	  FROM DELETED



-- Crea el historico SIN FK NI PK!! queremos que esta tabla esté aislada, sólo como backup
	--SELECT *
	 --INTO CLIENTES_HISTORICO
	 -- FROM CLIENTES
	 --WHERE 1 = 0 

	 --ALTER TABLE  CLIENTES_HISTORICO
	 --ADD fechaAlta DATETIME -- SIEMPRE PON EL MAS EXACTO POSIBLE, evitas que en el mismo rango de tiempo te entren 2 modificaciones y pete
	
	 --ALTER TABLE CLIENTES_HISTORICO
	 --ADD fechaAlta DATETIME default GETDATE()
	 
END


SELECT * FROM CLIENTES_HISTORICO
SELECT * FROM CLIENTES
UPDATE CLIENTES
	SET linea_direccion2 = 'Trigger'
	WHERE codcliente IN (1, 5)

ALTER TABLE CLIENTES_HISTORICO
ADD CONSTRAINT PK_CLIENTES_HISTORICO PRIMARY KEY (codCliente, fechaAlta)
ALTER TABLE CLIENTES_HISTORICO
ALTER COLUMN codCliente INT NOT NULL
ALTER TABLE CLIENTES_HISTORICO
ALTER COLUMN fechaAlta DATETIME NOT NULL


--
-- SET XACT_ABORT 
-- Hace un rollback automático en los triggers -> BUSCALO BIEN!