/* Parte I - Creación de una nueva base de datos para almacenar las tablas + tablas
Crear una nueva base de datos en MYSQL llamada “learndata” + tablas
Crear la tabla de productos llamada dim_producto a partir de los datos en crudo.
Chequear como vienen los datos
Cambiar los nombres de los campos
Insertar los campos a la nueva tabla
Crear la tabla de clientes llamada dim_clientes a partir de los datos en crudo
Chequear como vienen los datos
Cambiar los nombres de los campos
Convertir el campo date_created que viene como timestamp a solo fecha
Extraer del campo billing, todos los descriptivos del cliente que necesitamos aprendiendo a parsear un JSON.
Insertar los campos a la nueva tabla
Crear la tabla de pedidos llamada fac_pedidos a partir de los datos en crudo
Chequear como vienen los datos
Cambiar los nombres de los campos
Sustituir el nombre del producto por el id.
Normalizar la columna método de pago.
Convertir a date la columna fecha_pedido
Redondear decimales de la columna coste_articulo a enteros
Insertamos los pedidos a la tabla
Crear la tabla de cobros de stripe llamada fac_pagos_stripe a partir de los datos en crudo
Chequear como vienen los datos
Cambiar los nombres de los campos
Obtener el número de pedido con la función RIGHT. Quitar el número de pedido de la descripción que es lo que nos va a permitir unir esta tabla con otras
Pasar a timestamp el campo “created”
Reemplazar las commas por puntos
Convertir el número a decimal con dos lugares después de la comma.
Insertar tabla en nueva
*/ 

CREATE SCHEMA learndata;

-- Como saber si el id del producto es clave unica (viendo si hay duplicados)
SELECT id, COUNT(*) FROM learndata_crudo.raw_productos_wocommerce
GROUP BY id
ORDER BY COUNT(*) desc;
-- Como saber si el id del producto es clave unica (contando los distintos id y la cantidad de registros)
SELECT COUNT(DISTINCT id), COUNT(*) FROM learndata_crudo.raw_productos_wocommerce
GROUP BY id;
-- Como saber si el id del producto es clave unica (mostrando el conteo mayor a uno)
SELECT id, COUNT(*) FROM learndata_crudo.raw_productos_wocommerce
GROUP BY id
HAVING COUNT(*)>1;
-- Averiguar la longitud de un campo
SELECT char_length(tipo)
FROM learndata_crudo.raw_productos_wocommerce
ORDER BY 1 DESC;
SELECT tipo, MAX(char_length(tipo))
FROM learndata_crudo.raw_productos_wocommerce
GROUP BY tipo;
-- Separar el campo Tipo (donde esta la coma)
SELECT tipo, INSTR(tipo,',') AS dondeEstaLaComa
FROM learndata_crudo.raw_productos_wocommerce;
SELECT tipo, 
substr(tipo,1,instr(tipo,',')-1) as tipo1,
substr(tipo,instr(tipo,',')+1) as tipo2
FROM learndata_crudo.raw_productos_wocommerce;

-- Creación de Tabla modelada dim_producto 
CREATE TABLE learndata.dim_producto(
		pk_idproducto INT,
        tipo_producto VARCHAR (50),
        nombre_producto VARCHAR (100),
        ind_publicado INT, 
        ind_visibilidad_catalogo INT,
        ind_impuesto INT,
        tipo_impuesto VARCHAR (10),
        ind_inventario INT,
        ind_vendido_indv INT,
        imp_venta DECIMAL(10,2),
        PRIMARY KEY (pk_idproducto)
);

ALTER TABLE learndata.dim_producto ADD categorias VARCHAR(50);

-- Insertamos los datos en la tabla
INSERT INTO learndata.dim_producto
SELECT 
id, 
tipo,
nombre,
publicado,
case
	when visibilidad_catalogo = 'visible' then 1
    else 0
end ind_visibilidad_catalogo,
case
	when estado_impuesto = 'none' then 0
    else 1
end ind_vend_indv,
clase_impuesto,
en_inventario,
vendido_individualmente,
precio_normal,
categorias
FROM 
learndata_crudo.raw_productos_wocommerce
WHERE id is not null;

