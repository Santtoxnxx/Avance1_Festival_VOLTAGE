-- ============================================================
--  VOLTAGE FESTIVAL · Bases de Datos 2 · 2026-1
--  Script 4: Procedimientos almacenados
-- ============================================================

-- ============================================================
-- PROCEDIMIENTO 1: Reporte de ventas por día y por tipo de boleta
--
--  Parámetros:
--    p_fecha_inicio DATE  - Fecha inicial del rango (ej: '2026-05-01')
--    p_fecha_fin    DATE  - Fecha final del rango   (ej: '2026-05-31')
--
--  Retorna un conjunto de filas con:
--    - Fecha de venta
--    - Nombre del tipo de boleta
--    - Cantidad total de boletas vendidas
--    - Ingresos totales del día para ese tipo
--    - Acumulado por tipo en el rango
-- ============================================================

CREATE OR REPLACE FUNCTION sp_reporte_ventas_por_dia(
    p_fecha_inicio DATE,
    p_fecha_fin    DATE
)
RETURNS TABLE (
    fecha_venta         DATE,
    tipo_boleta         VARCHAR(60),
    boletas_vendidas    BIGINT,
    ingresos_dia_cop    NUMERIC,
    ingresos_acum_cop   NUMERIC
) AS $$
BEGIN
    -- Validación de parámetros
    IF p_fecha_inicio > p_fecha_fin THEN
        RAISE EXCEPTION 'La fecha de inicio (%) no puede ser mayor que la fecha de fin (%)',
            p_fecha_inicio, p_fecha_fin;
    END IF;

    RETURN QUERY
    SELECT
        v.fecha_venta::DATE                         AS fecha_venta,
        tb.nombre                                   AS tipo_boleta,
        SUM(v.cantidad)                             AS boletas_vendidas,
        SUM(v.total_venta)                          AS ingresos_dia_cop,
        SUM(SUM(v.total_venta)) OVER (
            PARTITION BY tb.nombre
            ORDER BY v.fecha_venta::DATE
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )                                           AS ingresos_acum_cop
    FROM ventas v
    JOIN tipos_boleta tb ON tb.tipo_boleta_id = v.tipo_boleta_id
    WHERE v.fecha_venta::DATE BETWEEN p_fecha_inicio AND p_fecha_fin
      AND v.estado_pago = 'Confirmado'
    GROUP BY v.fecha_venta::DATE, tb.nombre
    ORDER BY v.fecha_venta::DATE, tb.nombre;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sp_reporte_ventas_por_dia(DATE, DATE) IS
'Retorna un reporte diario de ventas por tipo de boleta en el rango de fechas indicado,
 incluyendo acumulados por tipo. Solo considera ventas con estado_pago = Confirmado.
 Uso: SELECT * FROM sp_reporte_ventas_por_dia(''2026-05-01'', ''2026-05-31'');';


-- ============================================================
-- PROCEDIMIENTO 2: Cálculo de pagos a artistas según contrato
--
--  Parámetros:
--    p_artista_id INTEGER (NULL = todos los artistas)
--
--  Retorna:
--    - Datos del artista y contrato
--    - Monto adelanto ya pagado al firmar
--    - Monto pendiente por pagar (antes del festival)
--    - Estado del contrato
-- ============================================================

CREATE OR REPLACE FUNCTION sp_calcular_pagos_artistas(
    p_artista_id INTEGER DEFAULT NULL
)
RETURNS TABLE (
    artista_id          INTEGER,
    nombre_artistico    VARCHAR(120),
    pais_origen         VARCHAR(60),
    cachet_usd          NUMERIC,
    porcentaje_adelanto NUMERIC,
    monto_adelanto_usd  NUMERIC,
    monto_pendiente_usd NUMERIC,
    estado_contrato     VARCHAR(20),
    fecha_firma         DATE
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.artista_id,
        a.nombre_artistico,
        a.pais_origen,
        c.cachet_usd,
        c.porcentaje_adelanto,
        ROUND(c.cachet_usd * c.porcentaje_adelanto / 100.0, 2) AS monto_adelanto_usd,
        ROUND(c.cachet_usd * (100 - c.porcentaje_adelanto) / 100.0, 2) AS monto_pendiente_usd,
        c.estado AS estado_contrato,
        c.fecha_firma
    FROM artistas a
    JOIN contratos c ON c.artista_id = a.artista_id
    WHERE (p_artista_id IS NULL OR a.artista_id = p_artista_id)
      AND c.estado = 'Vigente'
    ORDER BY c.cachet_usd DESC;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION sp_calcular_pagos_artistas(INTEGER) IS
'Calcula el adelanto pagado al firmar y el monto pendiente por pagar a cada artista.
 Acepta un artista_id específico o NULL para todos.
 Uso: SELECT * FROM sp_calcular_pagos_artistas();
      SELECT * FROM sp_calcular_pagos_artistas(7);';


-- ============================================================
-- EJEMPLOS DE USO
-- ============================================================

-- Ver reporte de ventas del mes de mayo 2026
-- SELECT * FROM sp_reporte_ventas_por_dia('2026-05-01', '2026-05-31');

-- Ver presupuesto de pagos a todos los artistas
-- SELECT * FROM sp_calcular_pagos_artistas();

-- Ver pago de un artista específico (ej: Cosmic Drift, id=7)
-- SELECT * FROM sp_calcular_pagos_artistas(7);

-- Sumar el total de compromisos financieros pendientes
-- SELECT SUM(monto_pendiente_usd) AS total_por_pagar_usd FROM sp_calcular_pagos_artistas();

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
