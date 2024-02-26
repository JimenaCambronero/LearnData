### Análisis financiero

#1. ¿Cuales son las ventas por año?

#Con esta sentencia sacamos las ventas por DIA.
SELECT FECHA_CREACION as FECHA_PEDIDO,SUM(PRECIO) as VENTAS FROM PEDIDOS GROUP BY FECHA_CREACION;

#Para agrupar por año, extraemos el año de la fecha de creacion (fecha de pedido).
SELECT YEAR(FECHA_CREACION) AS ANYO ,SUM(PRECIO) AS VENTAS 
FROM PEDIDOS GROUP BY YEAR(FECHA_CREACION) ORDER BY 1 DESC;

#Si queremos pasarlos a miles de euros, podemos dividir por 1000 y redondear a 2 decimales.
SELECT YEAR(FECHA_CREACION) AS ANYO ,ROUND(SUM(PRECIO)/1000,2) AS VENTAS_X_MIL_EUR
FROM PEDIDOS GROUP BY YEAR(FECHA_CREACION) ORDER BY 1 DESC;

#Diferencia entre redondear (round) y cortar (trunc) en decimales.
SELECT YEAR(FECHA_CREACION) AS ANYO ,ROUND(SUM(PRECIO)/1000,2) AS VENTAS_X_MIL_EUR,TRUNCATE(SUM(PRECIO)/1000,2) AS VENTAS_X_MIL_EUR_TRUNC
FROM PEDIDOS GROUP BY YEAR(FECHA_CREACION) ORDER BY 1 DESC;
 
#2. ¿Cuales son las ventas medias de cada mes y año?

SELECT YEAR(FECHA_CREACION) AS ANYO, MONTH(FECHA_CREACION) AS MES, ROUND(AVG(PRECIO),2) AS AVG_VENTAS FROM PEDIDOS
GROUP BY ANYO, MES
ORDER BY 1 DESC, 2 DESC
;

#El motivo por el cual la media es tan baja, es debido a que hay pocos productos en el catalogo, con precios muy similiares y en los pedidos la media es de 1.X articulos.
SELECT YEAR(FECHA_CREACION) AS ANYO, MONTH(FECHA_CREACION) AS MES, ROUND(AVG(PRECIO),2) AS AVG_VENTAS,AVG(ARTICULOS_COMPRADO) AS MEDIA_ART_PEDIDO FROM PEDIDOS
GROUP BY ANYO, MES
ORDER BY 1 DESC, 2 DESC;

#Para comprobar que la media es correcta, realizamos nosotros el calculo (sumatorio de ventas entre el num de pedidos)
SELECT YEAR(FECHA_CREACION) AS ANYO, MONTH(FECHA_CREACION) AS MES, ROUND(AVG(PRECIO),2) AS AVG_VENTAS,SUM(PRECIO)/ COUNT(*) AS MEDIA FROM PEDIDOS
GROUP BY ANYO, MES
ORDER BY 1 DESC, 2 DESC;

#3. ¿Cuál es el producto que mas vende en términos monetarios?

#Comprobamos de donde tenemos que sacar dicha informacion. En la tabla de pedidos NO tenemos el desglose de articulo / precio unitario.
SELECT * FROM PEDIDOS WHERE ID_PEDIDO = 7300;
SELECT * FROM PEDIDO_ARTICULO WHERE ID_PEDIDO = 7300;

#Ordenando por el importe total recaudado por producto, nos aparece el producto 1. 
SELECT ID_PRODUCTO,SUM(PRECIO) AS IMP_TOTAL_PROD FROM PEDIDO_ARTICULO GROUP BY ID_PRODUCTO ORDER BY 2 DESC;

#Si solo quisieramos que la consulta nos devolviese 1 registro, añadimos LIMIT X al final.
SELECT ID_PRODUCTO,SUM(PRECIO) AS IMP_TOTAL_PROD FROM PEDIDO_ARTICULO GROUP BY ID_PRODUCTO ORDER BY 2 DESC LIMIT 1;


#4. ¿Cuál es el margen bruto que deja cada producto?

/*Marge es igual al precio de venta menos el coste del articulo. Como el margen por articulo en este caso es siempre el mismo,
con la función distinct nos devuelve el precio - coste de cada artículo */
SELECT DISTINCT ID_PRODUCTO,PRECIO-COSTO AS MARGEN_BRUTO FROM PEDIDO_ARTICULO;

#Lo podemos hacer agrupando (aunque el valor es el mismo para todo). Query mas liosa y con mas probabilidad de error.
SELECT ID_PRODUCTO,SUM(PRECIO)/COUNT(*)-SUM(COSTO)/COUNT(*) AS MARGEN_BRUTO FROM PEDIDO_ARTICULO GROUP BY ID_PRODUCTO;

#5. ¿Podemos saber cúal es la fecha de lanzamiento de cada producto?

#Entendamos como fecha de lanzamiento la fecha en la que se da de alta el producto en la tabla de productos.

SELECT ID_PRODUCTO,FECHA_CREACION FROM PRODUCTOS;

#5.1 PRIMERA FECHA DE COMPRA DE CADA PRODUCTO. En este caso añadimos el nombre del producto en vez del id. 

SELECT PA.ID_PRODUCTO,PROD.NOMBRE_PRODUCTO,MIN(PA.FECHA_CREACION) AS PRIMERO_PEDIDO FROM PEDIDO_ARTICULO PA
LEFT JOIN PRODUCTOS PROD
ON PROD.ID_PRODUCTO = PA.ID_PRODUCTO
GROUP BY PROD.NOMBRE_PRODUCTO,PA.ID_PRODUCTO;

#5.2 cuanto tiempos ha pasado desde la fecha de lanzamiento hasta su primera compra

SELECT PA.ID_PRODUCTO,PROD.NOMBRE_PRODUCTO,MIN(PA.FECHA_CREACION)  AS PRIMERO_PEDIDO , PROD.FECHA_CREACION AS FECHA_LANZAMIENTO,(MIN(PA.FECHA_CREACION) - PROD.FECHA_CREACION) AS TIEMPO_DSD_LANZ_VENT FROM PEDIDO_ARTICULO PA
LEFT JOIN PRODUCTOS PROD
ON PROD.ID_PRODUCTO = PA.ID_PRODUCTO
GROUP BY PROD.NOMBRE_PRODUCTO,PA.ID_PRODUCTO;
 

#6. Calcula las ventas por año, asi como el margen numérico. Tambien queremos saber que % representa cada producto sobre las ventas totales.

#Obtenemos primero las ventas y el margen por anyo y mes.
SELECT YEAR(FECHA_CREACION) AS ANYO, SUM(PRECIO) AS VENTAS, SUM(PRECIO-COSTO) AS MARGEN FROM PEDIDO_ARTICULO 
GROUP BY ANYO;

#Adicionalmente, calculamos el % que supone cada producto sobre el total. 
SELECT ID_PRODUCTO,(SUM(PRECIO)/(SELECT SUM(PRECIO) FROM PEDIDO_ARTICULO))*100 AS PCT FROM PEDIDO_ARTICULO GROUP BY ID_PRODUCTO;

#Validamos el resultado.
SELECT ID_PRODUCTO,SUM(PRECIO)/1938509.75*100 FROM PEDIDO_ARTICULO GROUP BY ID_PRODUCTO;

#7. ¿Cuáles son los TOP 3 meses con mayor venta?

#8. ¿Cuál es el margen bruto por producto y que porcentaje ocupa del margen total?

#9. ¿Cuál es el margen de beneficio bruto promedio por línea de producto en el último trimestre de los datos de la empresa?

#10. ¿Cúal es el porcentaje de devolución de artículos?
    
### Análisis de trafico web
    
#11. ¿Cúal es la cantidad de sesiones por tipo de dispositivo?
#12. Es lo mismo sesiones que usuarios?¿Cuál es la cantidad de usuarios únicos? ¿Y cúal es la cantidad de sesiones?
#13. ¿Cúales son los 5 meses que ha habido más trafico en la web?
#14. ¿Cuál es la principal fuente de tráfico?
#15. ¿Cúales son las fuentes de tráfico que han dado más ventas?
#16. ¿Podrías mostrar las ventas y cantidad de sesiones por fuentes de tráfico  asi como el porcentaje del total de cada métrica?
#17.  ¿Cúal es el porcentaje de conversión de tráfico a ventas?
#18. ¿Que porcentaje de usuarios repiten?
#19.  Podrias calcular la cantidad de pedidos diferencias por días entre que entra a la web y realiza el pedido?
#20. ¿Cúales son las ventas generadas por campaña?