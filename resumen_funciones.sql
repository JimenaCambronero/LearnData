#Funcion LENGTH(X) para calcular la longitud de un campo/registro. Realizamos el MAX por encima para calcular la longitud maxima de ese campo para TODOS los registros. 
SELECT 
#length(nombre),
max(length(nombre))
FROM 
learndata_crudo.raw_productos_wocommerce;

#Funcion SUBSTR(X,Y,Z) la corta una cadena de caracteres X desde la posición Y y un número Z de caracteres. 
SELECT 
tipo,
substr(tipo,1,2) ejemplo,
instr(tipo,',') ejemplo2,
substr(tipo,1,instr(tipo,',')-1) as tipo1,
substr(tipo,instr(tipo,',')+1) as tipo2
FROM 
learndata_crudo.raw_productos_wocommerce;

/*Función COUNT(*) que nos sirve para contar registros, la cual combinada con un campo de la propia tabla nos agrupa este conteo por los diferentes valores de dicho campo. Ademas, añadimos la sentencia
having count(*) para que solo muestre aquellos registros que cumplen con la condición de >X). Basico para la detección de duplicados.*/
SELECT 
id,count(*)
FROM 
learndata_crudo.raw_productos_wocommerce
group by id
having count(*) >1;

#Función count(distinct X), la cual devuelve el numero de valores distintos del campo X. Tambien la usamos para detectar duplicados. 
SELECT 
count(distinct id),count(*)
FROM 
learndata_crudo.raw_productos_wocommerce;

#Función STR_TO_DATE(X, Y) para transformar una cadena de caracteres X que contiene una fecha en el formato Y. 
select STR_TO_DATE(date_created, "%d/%m/%Y %H:%i:%s") ,date_created
from learndata_crudo.raw_clientes_wocommerce;
#Podeis encontrar todos los formatos de mascara aqui: https://www.w3schools.com/sql/func_mysql_str_to_date.asp

/*Función CASE. La utilizamos cuando queremos crear un campo calculado que, en funcion de las condiciones que se asignen devolvéra un 
resultado u otro. En este caso queremos crear un nuevo campo que devuelva 1 si el campo visibilidad_catalogo 
es igual a visible y 0 si es diferente a visible.*/
select 
case 
	when visibilidad_catalogo ='visible' then 1
    when visibilidad_catalogo !='visible' then 0
end ind_visibilidad_catalogo
from raw_productos_wocommerce;

#Función para extraer el valor de un atributo de un campo en formato Json. 
SELECT 
json_value(billing,"$.first_name")
FROM LEARNDATA_CRUDO.raw_clientes_wocommerce;

/*Función que remplaza, dentro de una cadena de caracteres, un(os) caracteres por otros. En este caso estamos remplazando dentro del campo
nombre_del_articulo el literal 'dashborads' por 'dashboards'*/
select replace(nombre_del_articulo,'dashborads','dashboards') from learndata_crudo.raw_pedidos_wocommerce;

/* Función alter table, la cual nos permite modificar ciertos aspectos de la estructura de la tabla. Recordad los siguientes tips:
- Podemos añadir una columna siemmpre que queramos, aunque se creará vacia si no le indicamos ningun valor por defecto (DEFAULT XX)
- Podemos renombrar una columna siempre que queramos.
- Podemos modificar el tipo de campo de una columna SOLO si no hay datos en ella. Si lo que queremos es modificar la precisión a mas
siempre podremos aunque hayan datos, a menos no, tiene que estar vacia.
- Podemos eliminar una columna siempre que queramos.
*/

ALTER TABLE learndata.fac_pedidos
ADD COLUMN ID_CLIENTE INT;

ALTER TABLE learndata.fac_pedidos
RENAME COLUMN id_cliente TO id_clientes;

ALTER TABLE learndata.fac_pedidos
MODIFY COLUMN imp_subtotal decimal(12,2);

ALTER TABLE learndata.fac_pedidos
MODIFY COLUMN sku_producto varchar(100);



