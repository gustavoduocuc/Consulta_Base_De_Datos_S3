-- CASO 1: INFORME DE CLIENTES CLASIFICADOS SEGÚN LA RENTA
SELECT
    SUBSTR(TO_CHAR(numrut_cli), 1, 2) || '.' ||
    SUBSTR(TO_CHAR(numrut_cli), 3, 3) || '.' ||
    SUBSTR(TO_CHAR(numrut_cli), 6, 3) || '-' ||
    dvrut_cli AS "RUT Cliente",
    
    INITCAP(nombre_cli || ' ' || appaterno_cli || ' ' || apmaterno_cli) AS "Nombre Completo Cliente",
    
    INITCAP(direccion_cli) AS "Dirección Cliente",
    
    TO_CHAR(renta_cli, '$999G999G999') AS "Renta Cliente",
    
    SUBSTR('0' || celular_cli, 1, 2) || '-' ||
    SUBSTR('0' || celular_cli, 3, 3) || '-' ||
    SUBSTR('0' || celular_cli, 6, 4) AS "Celular Cliente",

    CASE
        WHEN renta_cli > 500000 THEN 'TRAMO 1'
        WHEN renta_cli BETWEEN 400000 AND 500000 THEN 'TRAMO 2'
        WHEN renta_cli BETWEEN 200000 AND 399999 THEN 'TRAMO 3'
        ELSE 'TRAMO 4'
    END AS "Tramo Renta Cliente"
FROM cliente
WHERE 
  renta_cli BETWEEN &RENTA_MINIMA AND &RENTA_MAXIMA
  AND celular_cli IS NOT NULL
ORDER BY 
  "Nombre Completo Cliente" ASC;
  

-- CASO 2: SUELDO PROMEDIO POR CATEGORIA DE EMPLEADO
SELECT 
    e.id_categoria_emp AS "CODIGO_CATEGORIA",

    (SELECT desc_categoria_emp
    FROM categoria_empleado
    WHERE id_categoria_emp = e.id_categoria_emp) AS "DESCRIPCION_CATEGORIA",

    COUNT(*) AS "CANTIDAD_EMPLEADOS",

    INITCAP((
        SELECT desc_sucursal 
        FROM sucursal 
        WHERE id_sucursal = e.id_sucursal
    )) AS "SUCURSAL",

    TO_CHAR(AVG(e.sueldo_emp), '$9G999G999') AS "SUELDO_PROMEDIO"
FROM 
  empleado e
GROUP BY 
  e.id_categoria_emp, 
  e.id_sucursal
HAVING 
  AVG(e.sueldo_emp) > &SUELDO_PROMEDIO_MINIMO
ORDER BY 
  AVG(e.sueldo_emp) DESC;
  

-- CASO 3: ARRIENDO PROMEDIO POR TIPO DE PROPIEDAD
SELECT 
    p.id_tipo_propiedad AS CODIGO_TIPO,
    UPPER(tp.desc_tipo_propiedad) AS DESCRIPCION_TIPO,
    COUNT(*) AS TOTAL_PROPIEDADES,
    TO_CHAR(ROUND(AVG(p.valor_arriendo)), '$999G999G999') AS PROMEDIO_ARRIENDO,
    TO_CHAR(ROUND(AVG(p.superficie), 2), '999G999D99')     AS PROMEDIO_SUPERFICIE,
    TO_CHAR(ROUND(AVG(p.valor_arriendo / NULLIF(p.superficie, 0))), '$999G999') AS VALOR_ARRIENDO_M2,
    CASE
        WHEN ROUND(AVG(p.valor_arriendo / NULLIF(p.superficie, 0))) < 5000 THEN 'Económico'
        WHEN ROUND(AVG(p.valor_arriendo / NULLIF(p.superficie, 0))) BETWEEN 5000 AND 10000 THEN 'Medio'
        ELSE 'Alto'
    END AS CLASIFICACION
FROM 
  propiedad p
JOIN 
  tipo_propiedad tp ON p.id_tipo_propiedad = tp.id_tipo_propiedad
GROUP BY 
  p.id_tipo_propiedad, tp.desc_tipo_propiedad
HAVING 
  AVG(p.valor_arriendo / NULLIF(p.superficie, 0)) > 1000
ORDER BY 
  AVG(p.valor_arriendo / NULLIF(p.superficie, 0)) DESC;