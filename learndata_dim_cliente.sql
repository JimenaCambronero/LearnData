-- Casteo, transformacion de un tipo de dato a otro
-- Máscara, formato en el que entemos que determinado orden es una fecha 

SELECT * 
FROM learndata_crudo.raw_clientes_wocommerce;

SELECT date_created,
DAYOFWEEK(str_to_date(date_created,"%d/%m/%Y %H:%i:%s")) as 'Num dia de la semana',
billing FROM learndata_crudo.raw_clientes_wocommerce;

-- Generamos sentencia select con los datos de la tabla origen tal y como nos gustaria insertarlos en la reciente tabla creada.
-- Usamos las funciones json_value para extraer el valor de los campos y str_to_date para castear el string de origen a fecha.
SELECT id, REPLACE(JSON_EXTRACT(billing,"$.first_name"),'"','' )AS nombre, #long max 11
JSON_VALUE(billing,"$.last_name")AS apellido, #long max 11
JSON_VALUE(billing,"$.email")AS email, #long max 40
JSON_VALUE(billing,"$.phone")AS phone, #long max 14
JSON_VALUE(billing,"$.address_1")AS direccion,
JSON_VALUE(billing,"$.postcode")AS codigo_postal,
str_to_date(date_created,"%d/%m/%Y %H:%i:%s") AS fecha_alta_cliente
FROM learndata_crudo.raw_clientes_wocommerce;

SELECT JSON_VALUE(billing,"$.first_name") AS nombre FROM learndata_crudo.raw_clientes_wocommerce;

-- dar formato FECHA a partir de un TEXTO
SELECT date_created,
str_to_date(date_created,"%d/%m/%Y %H:%i:%s") AS fecha_alta_cliente,
billing FROM learndata_crudo.raw_clientes_wocommerce;

-- Extension campo NOMBRE length o Max
SELECT LENGTH(REPLACE(JSON_EXTRACT(billing,"$.first_name"),'"','' ))AS nombre
FROM learndata_crudo.raw_clientes_wocommerce
order by nombre DESC; 

SELECT MAX(LENGTH(REPLACE(JSON_EXTRACT(billing,"$.last_name"),'"','' )))AS apellido
FROM learndata_crudo.raw_clientes_wocommerce;

-- Creamos la Tabla
CREATE TABLE learndata.dim_clientes(
	pk_id_cliente INT,
	nombre_cliente VARCHAR(50),
    apellido_cliente VARCHAR(50),
    email VARCHAR(50),
    telefono VARCHAR(20),
    direccion_cliente VARCHAR(150),
    cod_postal VARCHAR(20),
    fecha_alta_cliente DATE,
    PRIMARY KEY(pk_id_cliente)
);

#Insertamos los datos en la tabla de clientes directamente de la select generada en el paso anterior.
INSERT INTO learndata.dim_clientes 
SELECT id, REPLACE(JSON_EXTRACT(billing,"$.first_name"),'"','' )AS nombre, #long max 11
JSON_VALUE(billing,"$.last_name")AS apellido, #long max 11
JSON_VALUE(billing,"$.email")AS email, #long max 40
JSON_VALUE(billing,"$.phone")AS phone, #long max 14
JSON_VALUE(billing,"$.address_1")AS direccion,
JSON_VALUE(billing,"$.postcode")AS codigo_postal,
str_to_date(date_created,"%d/%m/%Y %H:%i:%s") AS fecha_alta_cliente
FROM learndata_crudo.raw_clientes_wocommerce;

SELECT * FROM dim_clientes;

-- Probamos a generar una tabla a traves de una consulta directamente. 
-- PROs: Rapidez en materializar un dato en la BBDD.
-- Contra: Los tipos de dato los infiere / define la BBDD segun el resultado de la consulta.
CREATE TABLE TEST_1 AS
SELECT 
id,
replace(json_extract(BILLING,"$.first_name"),'"','') as Nombre,
last_name,
json_value(BILLING,"$.email") as email, #long max 40
json_value(BILLING,"$.phone") as phone, #long max 14
json_value(BILLING,"$.address_1") as direccion, #38
json_value(BILLING,"$.postcode") as postcode,#11
str_to_date(date_created,'%d/%m/%Y %H:%i:%s') as fecha_alta_cliente
FROM learndata_crudo.RAW_CLIENTES_WOCOMMERCE;

