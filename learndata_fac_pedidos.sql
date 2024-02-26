#Creamos la tabla de pedidos, añadiendo los tipos de campos y sus longitudes según los datos origen y aplicando sentido comun a lo que albergará cada campo.

CREATE TABLE learndata.fac_pedidos (
  pk_pedido INT,
  sku_producto varchar(50),
  estado_pedido VARCHAR(50),
  fecha_pedido DATE ,
  id_cliente INT  ,
  tipo_pago_pedido VARCHAR(50) ,
  costo_pedido decimal(10,2) ,
  importe_de_descuento_pedido decimal(10,0) ,
  importe_total_pedido decimal(10,2) ,
  id_producto int,
  cantidad_pedido INT  ,
  codigo_cupon_pedido VARCHAR(100),
  PRIMARY KEY (pk_pedido));
  
/*Generamos sentencia select con los datos de la tabla origen tal y como nos gustaria insertarlos en la reciente tabla creada.
Usamos las funciones str_to_date para castear el string de origen a fecha, la función case para crearnos un campo calculado y añadimos
la función left join para informar el campo id_producto que no se encuentra en la tabla de pedidos sino en la tabla que creamos
el primer dia (mas info sobre la join debajo de la select). Adicionalmente homogenizamos el campo metodo de pago para agrupar los diferentes
valores que nos llegan de origen en solo dos, stripe o tarjeta.*/
SELECT
numero_de_pedido as pk_pedido,
sku,
estado_de_pedido as estado_pedido,
DATE(fecha_de_pedido) as fecha_pedido,
`id cliente`  as id_cliente,
case 
	when titulo_metodo_de_pago like '%Stripe%' then 'Stripe' 
    else 'Tarjeta' 
end as tipo_pago, 
importe_total_pedido as imp_pedido,
coste_articulo as imp_producto,
importe_de_descuento_del_carrito as imp_descuento_total,
dim.pk_idproducto,
cantidad as num_articulos,
cupon_articulo as cod_cupon
FROM learndata_crudo.raw_pedidos_wocommerce p
left join learndata.dim_producto dim 
on replace(p.nombre_del_articulo,'dashborads','dashboards') = dim.nombre_producto;


/*Como NO queremos perder ningun registro de la tabla de pedidos, realizamos una left join, la cual nos devolverá todos los registros
 que de dicha tabla y nos informará aquellos campos de la tabla de productos que cumplan con la condición definidina en el "on" (linea 163)
 Como resultado vemos que hay un producto (Power BI...) que no nos devulve el id_producto), esto es porque el campo nombre_del_articulo de 
 la tabla de pedidos no es igual al de la tabla de productos*/
 select distinct ped.nombre_del_articulo,prod.pk_idproducto 
 from learndata_crudo.raw_pedidos_wocommerce ped
 left join learndata.dim_producto prod
 on ped.nombre_del_articulo = prod.nombre_producto;
 
  /*Probamos la diferencia con una join y vemos que perdemos, en el distinct, el producto de "Power BI..". Si no hicieramos el distinct
  perderiamos TODOS los registros de la tabla de pedidos que no cruzan con la tabla de productos*/
 select distinct ped.nombre_del_articulo,prod.pk_idproducto 
 from learndata_crudo.raw_pedidos_wocommerce ped
 left join learndata.dim_producto prod
 on ped.nombre_del_articulo = prod.nombre_producto;
 
/* 
El problema de porque no cruza es porque el valor del nombre producto está escrito mal en la tabla de pedidos (dashborads vs dashboards)
Power BI: Como crear dashborads inteligentes -- pedidos
Power BI: Como crear dashboards inteligentes -- productos
 */
 
/*Para mejorar el cruce, debemos corregir esa cadena de texto. IMPORTANTE: Nunca lo hagais sobre los datos origen, sino en el proceo de carga
de la tabla destino (en este caso, la tabla de pedido de learndata). De este forma siempre tendremos el valor original por si nos equivocamos
en algun momento. Para realizar la modificación lo podemos hacer o bien con un case o bien con un replace. (Ver mas info sobre estas dos funciones
en el fichero adjunto "Resumen funciones")*/

 select 
 distinct CASE
	when nombre_del_articulo='Power BI: Como crear dashborads inteligentes' then 'Power BI: Como crear dashboards inteligentes'
    else nombre_del_articulo
end,

replace(nombre_del_articulo,'dashborads','dashboards')
 from learndata_crudo.raw_pedidos_wocommerce;
 
/*Añadimos el campo calculado en la join para que el campo que cruce no sea el campo orignal sino el nuevo campo con el literal corregido. Ahora
vemos que todo cruza.*/
 select distinct ped.nombre_del_articulo,prod.pk_idproducto 
 from learndata_crudo.raw_pedidos_wocommerce ped
 left join learndata.dim_producto prod
 on replace(nombre_del_articulo,'dashborads','dashboards') = prod.nombre_producto;
 
INSERT INTO learndata.fac_pedidos
SELECT
numero_de_pedido as pk_pedido,
sku,
estado_de_pedido as estado_pedido,
DATE(fecha_de_pedido) as fecha_pedido,
`id cliente`  as id_cliente,
case 
	when titulo_metodo_de_pago like '%Stripe%' then 'Stripe'
    else 'Tarjeta' 
end as tipo_pago,
importe_total_pedido as imp_pedido,
coste_articulo as imp_producto,
importe_de_descuento_del_carrito as imp_descuento_total,
dim.pk_idproducto,
cantidad as num_articulos,
cupon_articulo as cod_cupon
FROM learndata_crudo.raw_pedidos_wocommerce p
left join learndata.dim_producto dim 
on replace(p.nombre_del_articulo,'dashborads','da