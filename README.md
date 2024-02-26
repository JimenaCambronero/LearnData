# LearnData
Proyecto 4 para Unicorn Project: 🧹 Limpieza de datos - LearnData

# 📋Descripción del Proyecto
El proyecto de limpieza de datos con SQL tiene como objetivo principal mejorar la calidad y confiabilidad de los conjuntos de datos utilizados en las organizaciones. Los datos desempeñan un papel fundamental en la toma de decisiones y la generación de informes, por lo que es esencial garantizar que estén libres de errores, inconsistencias y duplicados. Por lo cual vamos a necesitar de tus conocimientos en SQL para realizar algunas tareas de impieza de datos para nuestro cliente LearnData.


# 🎯El objetivo de este proyecto
Creación de una base de datos.
Identificar y Corregir Inconsistencias.
Detección y Eliminación de Duplicados.
Normalización de Datos.

# 📝Contexto
LearnData es una empresa de e-learning dedicada a la venta de cursos online de análisis de datos. Su principal objetivo es:
Comenzar a construir una infraestructura tecnológica para analizar sus datos.
Limpiar los datos para que los puedan consumir las áreas de negocio.

Utiliza las siguientes herramientas para gestionar su negocio:

Stripe: Es una plataforma de procesamiento de pagos por internet, al igual que paypal.
Wocommerce: Es un plugin de wordpress que te permite convertir tu web a un sitio de ecommerce y vender productos
Wordpress: Es un sistema de gestión de contenidos(CMS), un software utilizado para construir, modificar y mantener sitios web

# 🆘 El problema
LearnData ha ido creciendo en la venta de sus cursos online y no tiene información de cuales son sus indicadores de ventas, por lo cual requiere comenzar a analizar sus principales métricas financieras, para determinar que productos tienen mayor venta, que tipo de clientes compran sus productos o cuales son los pagos que reciben por producto.
En este momento LearnData no tiene ningun sistema creado para poder capturar, analizar y tomar mejores decisiones y necesita tener una base de datos donde puedan ver y analizar esta información y a futuro crear un dashboard con los KPI para ver el rendimiento de su negocio de cursos online.

# 🕵️ Habilidades Adquiridas
Creemos que tienes las habilidades necesarias para llevar a cabo este proyecto ya que consideramos que estas preparado para realizar las siguientes actividades:
✅  Creación de base de datos en MYSQL
✅  Creación de tablas en MYSQL
✅  Creación de Primary Keys
✅  Insertar datos en un tabla en MYSQL
✅  Seleccionar datos de un tabla en MYSQL
✅  Seleccionar datos de un tabla en MYSQL
✅  Transformación de datos en MYSQL
✅  Funciones varias: CAST, REPLACE, DATE,RIGHT,CASE
✅  Parseo de JSON con MYSQL

# 🛠️Herramientas a utilizar
En este proyecto utilizaremos lenguaje de SQL y el gestor de base de datos MYSQL

📶Conjunto de datos del proyecto

Descripción de los dataset con los cuales vas a trabajar en este proyecto para que tengas la infomación de sus tablas y campos, esto es conocido como un diccionario de datos.

👩‍💻Tabla raw_cliente_wocommerce:
Contiene información sobre los clientes

📦Tabla raw_pedidos_wocommerce
Contiene información de los pedidos

📚Tabla raw_productos_wocommerce
Contiene información sobre los productos

💰Tabla raw_pagos_stripe
Contiene información sobre los pagos

# Los datos
🗃️ Base de datos .sql


# 💡Desarrollo | Ejecución
Análisis previo del problema
¿Que fuentes de datos tiene la empresa?
La empresa utiliza wordpress con un plugin de wocommerce como plataforma de venta de sus cursos online y luego cuenta con stripe como pasarela de pagos a de más de los pagos de tarjeta de crédito.
¿En que formato se descargan los datos?
Los datos crudos los tendremos en csv directamente descargados de las fuentes.
¿Que datos tenemos?
Tenemos datos de los productos osea cursos que se venden, los clientes, de los pedidos y de los pagos recibidos por stripe.
Modelo de datos
Tenemos la tabla de pedidos que se relaciona con la de clientes y productos mediante SKU_producto e id_cliente y por otro lado tenemos la tabla la de pagos de stripe que la relacionaremos con la de pedidos por el numero de pedido.
Análisis exploratorio de las tablas.
# ✍️Ejecución
Parte I - Creación de una nueva base de datos para almacenar las tablas + tablas
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

Parte || - Limpieza de datos en tablas
Verificar que no existan campos nulos, de existir reemplazar por un valor comodín (según el tipo de dato).
Realizar una consulta que devuelva las fechas en diferentes formatos.
Verificar que los tipos de datos de los campos PK son de tipo entero (int) en las tablas.
Validar que se puedan realizar joins entre las tablas y analizar los resultados.
Generar duplicados ficticios en las tablas en crudo e intentar una carga en las tablas nuevas. Crear tabla de rechazos para conseguir una carga satisfactoria.