Ejercicio 1:

Ingresar en el terminal:

psql < unidad2.sql 


Ejercicio 2:

Primero vamos a revisar si esta el registro del usuario01

SELECT id FROM cliente WHERE nombre = 'usuario01';

-
BEGIN TRANSACTION;

INSERT INTO compra(cliente_id, fecha) VALUES(1, now()) RETURNING id;
INSERT INTO detalle_compra(producto_id, compra_id) VALUES(9, ID_ANTERIOR);
UPDATE producto SET stock = stock - 5 WHERE id = 9;

END TRANSACTION;

SELECT stock FROM producto WHERE id = 9;

El stock es -1, se quedo sin stock.

Ejercicio 3:


BEGIN TRANSACTION;

INSERT INTO compra(cliente_id, fecha) VALUES(2, now()) RETURNING id;
INSERT INTO detalle_compra(producto_id, compra_id) VALUES(1, ID_ANTERIOR);
INSERT INTO compra(cliente_id, fecha) VALUES(2, now()) RETURNING id;
INSERT INTO detalle_compra(producto_id, compra_id) VALUES(2, ID_ANTERIOR);
INSERT INTO compra(cliente_id, fecha) VALUES(2, now()) RETURNING id;
INSERT INTO detalle_compra(producto_id, compra_id) VALUES(8, ID_ANTERIOR);
UPDATE producto SET stock = stock - 3 WHERE id = 1;
UPDATE producto SET stock = stock - 3 WHERE id = 2;
UPDATE producto SET stock = stock - 3 WHERE id = 8;

END TRANSACTION;

SELECT stock FROM producto WHERE id = 1;
SELECT stock FROM producto WHERE id = 2;
SELECT stock FROM producto WHERE id = 8;

El stock final de los productos fue:

producto 1 se quedo con 3 de stock
producto 2 se quedo con 2 de stock
producto 8 no tenia stock, y ahora tiene de stock -3

Ejercicio 4:
Para desactivar AUTOCOMMIT

\set AUTOCOMMIT off

Para insertar un nuevo cliente utilizaremos:

INSERT INTO cliente (nombre, email) VALUES ('amelia', 'gatitos@123.cl');

Comprobación del nuevo cliente: 

SELECT * FROM cliente WHERE nombre='amelia';
 id | nombre |     email      
----+--------+----------------
 13 | amelia | gatitos@123.cl
(1 row)

ROLLBACK; 
(Para hacer un ROLLBACK la mejor opción es ir dejando puntos de guardado (savepoint) para regresar donde se desea)

Verificación de la restauración:

SELECT * FROM cliente WHERE nombre='amelia';
 id | nombre | email 
----+--------+-------
(0 rows)

Activación AUTOCMMIT:

\set AUTOCOMMIT on