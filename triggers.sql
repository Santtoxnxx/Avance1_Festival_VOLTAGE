-- ============================================================
--  VOLTAGE FESTIVAL · Bases de Datos 2 · 2026-1
--  Script 3: Triggers
-- ============================================================

-- ============================================================
-- TRIGGER 1: Validación de cupo y descuento de disponibilidad
--            al insertar una venta (BEFORE INSERT ON ventas)
--
--  Propósito: Garantizar que no se vendan más boletas de las
--  disponibles para cada tipo. Si el cupo es insuficiente,
--  se lanza una excepción que aborta la inserción.
--  Si la venta pasa, se descuenta el cupo_disponible.
-- ============================================================

CREATE OR REPLACE FUNCTION fn_validar_cupo_venta()
RETURNS TRIGGER AS $$
DECLARE
    v_cupo_disponible INTEGER;
    v_nombre_boleta   VARCHAR(60);
BEGIN
    -- Bloqueo a nivel de fila para evitar race conditions en ventas concurrentes
    SELECT cupo_disponible, nombre
      INTO v_cupo_disponible, v_nombre_boleta
      FROM tipos_boleta
     WHERE tipo_boleta_id = NEW.tipo_boleta_id
       FOR UPDATE;

    -- Verificar si hay suficiente cupo
    IF v_cupo_disponible < NEW.cantidad THEN
        RAISE EXCEPTION
            'No hay cupo suficiente para el tipo de boleta "%" (disponible: %, solicitado: %)',
            v_nombre_boleta, v_cupo_disponible, NEW.cantidad;
    END IF;

    -- Descontar el cupo disponible
    UPDATE tipos_boleta
       SET cupo_disponible = cupo_disponible - NEW.cantidad
     WHERE tipo_boleta_id = NEW.tipo_boleta_id;

    -- Asegurar consistencia del total de la venta
    NEW.total_venta := NEW.precio_unitario * NEW.cantidad;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Eliminar trigger si ya existía
DROP TRIGGER IF EXISTS trg_validar_cupo_venta ON ventas;

CREATE TRIGGER trg_validar_cupo_venta
    BEFORE INSERT ON ventas
    FOR EACH ROW
    EXECUTE FUNCTION fn_validar_cupo_venta();

COMMENT ON FUNCTION fn_validar_cupo_venta() IS
'Trigger BEFORE INSERT: valida disponibilidad de cupo antes de registrar una venta
 y descuenta automáticamente del cupo_disponible del tipo de boleta correspondiente.';


-- ============================================================
-- TRIGGER 2: Auditoría de cambios en presentaciones
--            (AFTER UPDATE ON presentaciones)
--
--  Propósito: Registrar en la tabla auditoria_presentaciones
--  cualquier cambio en los campos críticos de la programación:
--  fecha/hora de inicio, fecha/hora de fin, escenario asignado
--  y estado. Esto garantiza trazabilidad total de modificaciones
--  en la agenda del festival.
-- ============================================================

CREATE OR REPLACE FUNCTION fn_auditar_presentaciones()
RETURNS TRIGGER AS $$
BEGIN
    -- Auditar cambio en fecha/hora de inicio
    IF OLD.fecha_hora_inicio <> NEW.fecha_hora_inicio THEN
        INSERT INTO auditoria_presentaciones
            (presentacion_id, campo_modificado, valor_anterior, valor_nuevo, operacion)
        VALUES
            (OLD.presentacion_id, 'fecha_hora_inicio',
             OLD.fecha_hora_inicio::TEXT, NEW.fecha_hora_inicio::TEXT, 'UPDATE');
    END IF;

    -- Auditar cambio en fecha/hora de fin
    IF OLD.fecha_hora_fin <> NEW.fecha_hora_fin THEN
        INSERT INTO auditoria_presentaciones
            (presentacion_id, campo_modificado, valor_anterior, valor_nuevo, operacion)
        VALUES
            (OLD.presentacion_id, 'fecha_hora_fin',
             OLD.fecha_hora_fin::TEXT, NEW.fecha_hora_fin::TEXT, 'UPDATE');
    END IF;

    -- Auditar cambio de escenario
    IF OLD.escenario_id <> NEW.escenario_id THEN
        INSERT INTO auditoria_presentaciones
            (presentacion_id, campo_modificado, valor_anterior, valor_nuevo, operacion)
        VALUES
            (OLD.presentacion_id, 'escenario_id',
             OLD.escenario_id::TEXT, NEW.escenario_id::TEXT, 'UPDATE');
    END IF;

    -- Auditar cambio de estado
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO auditoria_presentaciones
            (presentacion_id, campo_modificado, valor_anterior, valor_nuevo, operacion)
        VALUES
            (OLD.presentacion_id, 'estado',
             OLD.estado, NEW.estado, 'UPDATE');
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_auditar_presentaciones ON presentaciones;

CREATE TRIGGER trg_auditar_presentaciones
    AFTER UPDATE ON presentaciones
    FOR EACH ROW
    EXECUTE FUNCTION fn_auditar_presentaciones();

COMMENT ON FUNCTION fn_auditar_presentaciones() IS
'Trigger AFTER UPDATE: registra en auditoria_presentaciones cada cambio en los campos
 críticos (fecha_hora_inicio, fecha_hora_fin, escenario_id, estado) de la programación.';


-- ============================================================
-- PRUEBAS DE FUNCIONAMIENTO
-- ============================================================

-- PRUEBA TRIGGER 1: Intentar vender más boletas Platino de las disponibles
-- (Debe fallar con error de cupo)
/*
DO $$
BEGIN
    INSERT INTO ventas (asistente_id, tipo_boleta_id, cantidad, precio_unitario,
                        total_venta, metodo_pago, codigo_transaccion)
    VALUES (1, 5, 300, 2200000, 660000000, 'PSE', 'TEST-OVERFLOW-001');
    RAISE NOTICE 'Inserción exitosa (no debería llegar aquí)';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR esperado: %', SQLERRM;
END;
$$;
*/

-- PRUEBA TRIGGER 2: Modificar el estado de una presentación y verificar auditoría
/*
UPDATE presentaciones
   SET estado = 'Cancelada', notas = 'Cancelado por fuerza mayor'
 WHERE presentacion_id = 1;

SELECT * FROM auditoria_presentaciones WHERE presentacion_id = 1;
*/

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
