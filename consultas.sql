-- ============================================================
--  VOLTAGE FESTIVAL · Bases de Datos 2 · 2026-1
--  Script 5: Consultas SQL significativas
-- ============================================================

-- ============================================================
-- CONSULTA 1: Ranking de artistas por ingresos de boletas
--             vendidas en cada escenario donde se presentan
--
--  Objetivo: Identificar qué artistas generan más ingresos
--  de taquilla, correlacionando ventas de tipos de boleta
--  con las presentaciones programadas por escenario.
--
--  Técnicas utilizadas:
--    - JOIN múltiple (4 tablas)
--    - Agregaciones (SUM, COUNT)
--    - RANK() window function
--    - GROUP BY
-- ============================================================

SELECT
    e.nombre                                              AS escenario,
    a.nombre_artistico                                    AS artista,
    a.genero_especifico                                   AS genero,
    TO_CHAR(p.fecha_hora_inicio, 'DD/MM/YYYY HH24:MI')   AS fecha_presentacion,
    COUNT(DISTINCT v.venta_id)                            AS total_transacciones,
    SUM(v.cantidad)                                       AS boletas_vendidas,
    SUM(v.total_venta)                                    AS ingresos_cop,
    RANK() OVER (
        PARTITION BY e.escenario_id
        ORDER BY SUM(v.total_venta) DESC
    )                                                     AS ranking_escenario
FROM presentaciones p
JOIN artistas   a  ON a.artista_id   = p.artista_id
JOIN escenarios e  ON e.escenario_id = p.escenario_id
JOIN ventas     v  ON v.tipo_boleta_id IN (
    -- Relacionamos las ventas de tipos de boleta que aplican según el escenario
    -- (para este festival, todos los tipos dan acceso a todos los escenarios)
    SELECT tipo_boleta_id FROM tipos_boleta
)
WHERE v.estado_pago = 'Confirmado'
  AND p.estado      = 'Programada'
GROUP BY e.escenario_id, e.nombre, a.artista_id,
         a.nombre_artistico, a.genero_especifico, p.fecha_hora_inicio
ORDER BY e.nombre, ranking_escenario;

-- ============================================================
-- EXPLICACIÓN CONSULTA 1:
--  Se unen presentaciones, artistas, escenarios y ventas para
--  calcular, por escenario, cuántas boletas y qué ingresos se
--  asocian a cada artista. La función RANK() asigna una posición
--  dentro de cada escenario. Útil para tomar decisiones sobre
--  cachés, repetición de artistas y asignación de escenarios
--  en futuras ediciones.
-- ============================================================


-- ============================================================
-- CONSULTA 2: Resumen financiero del festival con totales
--             por tipo de boleta y porcentaje de ocupación
--
--  Objetivo: Vista ejecutiva de ventas: cuánto se ha recaudado
--  por categoría, qué porcentaje del cupo ya se vendió, y
--  cuántos ingresos representa cada categoría del total.
--
--  Técnicas utilizadas:
--    - Subconsulta en FROM (tabla derivada)
--    - Agregaciones (SUM, COUNT, AVG)
--    - Cálculos de porcentaje con ROUND
--    - CROSS JOIN con subconsulta escalar para % del total
-- ============================================================

SELECT
    tb.nombre                                         AS tipo_boleta,
    tb.precio_cop                                     AS precio_cop,
    tb.cupo_total                                     AS cupo_total,
    tb.cupo_disponible                                AS cupo_disponible,
    (tb.cupo_total - tb.cupo_disponible)              AS cupo_vendido,
    ROUND(
        (tb.cupo_total - tb.cupo_disponible) * 100.0
        / tb.cupo_total, 1
    )                                                 AS pct_ocupacion,
    COALESCE(resumen.total_recaudado, 0)              AS recaudado_cop,
    COALESCE(resumen.num_transacciones, 0)            AS num_transacciones,
    ROUND(
        COALESCE(resumen.total_recaudado, 0) * 100.0
        / totales.gran_total, 1
    )                                                 AS pct_del_total
FROM tipos_boleta tb

-- Subconsulta: agrupación de ventas confirmadas por tipo
LEFT JOIN (
    SELECT
        tipo_boleta_id,
        SUM(total_venta)  AS total_recaudado,
        COUNT(venta_id)   AS num_transacciones
    FROM ventas
    WHERE estado_pago = 'Confirmado'
    GROUP BY tipo_boleta_id
) resumen ON resumen.tipo_boleta_id = tb.tipo_boleta_id

-- Subconsulta escalar: gran total para calcular porcentajes
CROSS JOIN (
    SELECT SUM(total_venta) AS gran_total
    FROM   ventas
    WHERE  estado_pago = 'Confirmado'
) totales

ORDER BY recaudado_cop DESC;

-- ============================================================
-- EXPLICACIÓN CONSULTA 2:
--  La subconsulta en FROM agrega las ventas por tipo de boleta.
--  El CROSS JOIN con la subconsulta escalar permite calcular
--  qué porcentaje del total recaudado corresponde a cada
--  categoría. El COALESCE maneja tipos sin ventas registradas.
--  Resultado clave para la dirección financiera del festival.
-- ============================================================


-- ============================================================
-- CONSULTA 3: Top 5 asistentes más frecuentes con su gasto
--             total y el artista "favorito" (más presentaciones
--             en la misma fecha de compra)
--
--  Objetivo: Identificar los mejores clientes del festival,
--  cuánto han gastado y qué tipo de boleta prefieren.
--
--  Técnicas utilizadas:
--    - JOIN múltiple
--    - GROUP BY con múltiples agregaciones
--    - Subconsulta correlacionada
--    - HAVING para filtrar grupos
--    - ORDER BY y LIMIT
-- ============================================================

SELECT
    a.nombres || ' ' || a.apellidos                   AS asistente,
    a.ciudad_residencia                               AS ciudad,
    COUNT(v.venta_id)                                 AS num_compras,
    SUM(v.cantidad)                                   AS total_boletas,
    SUM(v.total_venta)                                AS gasto_total_cop,
    ROUND(AVG(v.total_venta), 0)                      AS gasto_promedio_cop,
    -- Tipo de boleta que más ha comprado (subconsulta correlacionada)
    (
        SELECT tb2.nombre
        FROM   ventas v2
        JOIN   tipos_boleta tb2 ON tb2.tipo_boleta_id = v2.tipo_boleta_id
        WHERE  v2.asistente_id = a.asistente_id
          AND  v2.estado_pago  = 'Confirmado'
        GROUP  BY tb2.nombre
        ORDER  BY SUM(v2.cantidad) DESC
        LIMIT  1
    )                                                 AS boleta_preferida,
    -- Método de pago más usado (subconsulta correlacionada)
    (
        SELECT v3.metodo_pago
        FROM   ventas v3
        WHERE  v3.asistente_id = a.asistente_id
          AND  v3.estado_pago  = 'Confirmado'
        GROUP  BY v3.metodo_pago
        ORDER  BY COUNT(*) DESC
        LIMIT  1
    )                                                 AS metodo_pago_preferido
FROM asistentes a
JOIN ventas v ON v.asistente_id = a.asistente_id
WHERE v.estado_pago = 'Confirmado'
GROUP BY a.asistente_id, a.nombres, a.apellidos, a.ciudad_residencia
HAVING SUM(v.total_venta) > 0
ORDER BY gasto_total_cop DESC
LIMIT 10;

-- ============================================================
-- EXPLICACIÓN CONSULTA 3:
--  Combina la tabla de asistentes con ventas para obtener el
--  gasto total por persona. Dos subconsultas correlacionadas
--  determinan, para cada asistente, el tipo de boleta y el
--  método de pago más utilizados. HAVING filtra asistentes
--  con gasto real. ORDER BY + LIMIT entregan el top 10.
--  Resultado útil para estrategias de fidelización y marketing
--  del festival.
-- ============================================================

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
