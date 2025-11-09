# Instructivo de Ejecución - PRY2205 Semana 3

Pasos necesarios para ejecutar correctamente el proyecto de la semana 3 del curso PRY2205 en Oracle SQL Developer. Relacionado al caso de Estudio ASOCIADOS Corredora de Propiedades

[Exp1 S3 Anexo C.pdf](https://github.com/user-attachments/files/23441602/Exp1.S3.Anexo.C.pdf)


## Paso 1: Crear el Usuario `PRY2205_S3`

```sql
CREATE USER PRY2205_S3 
IDENTIFIED BY "PRY2205.semana_3"
DEFAULT TABLESPACE DATA
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON DATA;

GRANT CREATE SESSION TO PRY2205_S3;
GRANT RESOURCE TO PRY2205_S3;
ALTER USER PRY2205_S3 DEFAULT ROLE RESOURCE;
```

## Paso 2: Conectarse como PRY2205_S3

- Abrir una nueva conexión en Oracle SQL Developer.
- Usuario: `PRY2205_S3`
- Contraseña: `PRY2205.semana_3`
- Probar conexión y conectar.

## Paso 3: Ejecutar el script de carga inicial
https://ava.duoc.cl/bbcswebdav/xid-9332510_1

- El script contiene:
  - Creación de tablas.
  - Inserción de datos.
  - Creación de llaves foráneas y secuencias.
- Antes de ejecutar, configurar el formato de fechas:

```sql
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';
```

## Paso 4: Ejecutar los tres informes solicitados
[Encargo_Semanal.sql](https://github.com/gustavoduocuc/Consulta_Base_De_Datos_S3/blob/main/Encargo_Semanal.sql)

