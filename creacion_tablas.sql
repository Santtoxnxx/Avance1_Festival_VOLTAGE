-- ============================================================
--  VOLTAGE FESTIVAL · Bases de Datos 2 · 2026-1
--  Script 1: Creación de tablas (PostgreSQL)
--  Festival de música electrónica / EDM · Bogotá
-- ============================================================

-- Limpiar esquema previo (orden inverso de dependencias)
DROP TABLE IF EXISTS staff            CASCADE;
DROP TABLE IF EXISTS ventas           CASCADE;
DROP TABLE IF EXISTS tipos_boleta     CASCADE;
DROP TABLE IF EXISTS presentaciones   CASCADE;
DROP TABLE IF EXISTS contratos        CASCADE;
DROP TABLE IF EXISTS escenarios       CASCADE;
DROP TABLE IF EXISTS asistentes       CASCADE;
DROP TABLE IF EXISTS artistas         CASCADE;
DROP TABLE IF EXISTS auditoria_presentaciones CASCADE;

-- ============================================================
-- 1. ARTISTAS
-- ============================================================
CREATE TABLE artistas (
    artista_id      SERIAL          PRIMARY KEY,
    nombre_artistico VARCHAR(120)   NOT NULL,
    nombre_real      VARCHAR(120),
    pais_origen      VARCHAR(60)    NOT NULL,
    genero_especifico VARCHAR(60)   NOT NULL,  -- techno, house, trance, drum&bass…
    integrantes_principales TEXT,              -- lista libre separada por comas
    biografia        TEXT,
    sitio_web        VARCHAR(200),
    fecha_registro   DATE            NOT NULL DEFAULT CURRENT_DATE,
    activo           BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_artista_nombre CHECK (LENGTH(TRIM(nombre_artistico)) > 0)
);

CREATE INDEX idx_artistas_pais    ON artistas (pais_origen);
CREATE INDEX idx_artistas_genero  ON artistas (genero_especifico);

-- ============================================================
-- 2. CONTRATOS
-- ============================================================
CREATE TABLE contratos (
    contrato_id      SERIAL          PRIMARY KEY,
    artista_id       INTEGER         NOT NULL REFERENCES artistas(artista_id) ON DELETE RESTRICT,
    cachet_usd       NUMERIC(12,2)   NOT NULL,
    fecha_firma      DATE            NOT NULL,
    fecha_inicio     DATE            NOT NULL,
    fecha_fin        DATE            NOT NULL,
    clausulas        TEXT,
    metodo_pago      VARCHAR(40)     NOT NULL DEFAULT 'Transferencia bancaria',
    porcentaje_adelanto NUMERIC(5,2) NOT NULL DEFAULT 30.00,  -- % pagado al firmar
    moneda           VARCHAR(10)     NOT NULL DEFAULT 'USD',
    estado           VARCHAR(20)     NOT NULL DEFAULT 'Vigente'
                        CHECK (estado IN ('Vigente','Finalizado','Cancelado','En negociación')),

    CONSTRAINT chk_contrato_cachet    CHECK (cachet_usd > 0),
    CONSTRAINT chk_contrato_fechas    CHECK (fecha_fin >= fecha_inicio),
    CONSTRAINT chk_contrato_adelanto  CHECK (porcentaje_adelanto BETWEEN 0 AND 100)
);

CREATE INDEX idx_contratos_artista ON contratos (artista_id);
CREATE INDEX idx_contratos_estado  ON contratos (estado);

-- ============================================================
-- 3. ESCENARIOS
-- ============================================================
CREATE TABLE escenarios (
    escenario_id     SERIAL          PRIMARY KEY,
    nombre           VARCHAR(80)     NOT NULL UNIQUE,
    capacidad_maxima INTEGER         NOT NULL,
    ubicacion        VARCHAR(120)    NOT NULL,  -- zona dentro del recinto
    tipo_escenario   VARCHAR(40)     NOT NULL
                        CHECK (tipo_escenario IN ('Principal','Secundario','Outdoor','Indoor','Carpa')),
    equipamiento     TEXT,           -- descripción libre del equipo de sonido/luces
    tiene_zona_vip   BOOLEAN         NOT NULL DEFAULT FALSE,

    CONSTRAINT chk_escenario_capacidad CHECK (capacidad_maxima > 0)
);

CREATE INDEX idx_escenarios_tipo ON escenarios (tipo_escenario);

-- ============================================================
-- 4. PRESENTACIONES
-- ============================================================
CREATE TABLE presentaciones (
    presentacion_id  SERIAL          PRIMARY KEY,
    artista_id       INTEGER         NOT NULL REFERENCES artistas(artista_id)   ON DELETE RESTRICT,
    escenario_id     INTEGER         NOT NULL REFERENCES escenarios(escenario_id) ON DELETE RESTRICT,
    fecha_hora_inicio TIMESTAMP      NOT NULL,
    fecha_hora_fin    TIMESTAMP      NOT NULL,
    estado           VARCHAR(20)     NOT NULL DEFAULT 'Programada'
                        CHECK (estado IN ('Programada','En curso','Finalizada','Cancelada','Pospuesta')),
    notas            TEXT,

    CONSTRAINT chk_presentacion_horas CHECK (fecha_hora_fin > fecha_hora_inicio),
    -- Un artista no puede estar en dos lugares al mismo tiempo
    CONSTRAINT uq_artista_horario UNIQUE (artista_id, fecha_hora_inicio)
);

CREATE INDEX idx_presentaciones_artista   ON presentaciones (artista_id);
CREATE INDEX idx_presentaciones_escenario ON presentaciones (escenario_id);
CREATE INDEX idx_presentaciones_fecha     ON presentaciones (fecha_hora_inicio);

-- ============================================================
-- 5. TIPOS DE BOLETA
-- ============================================================
CREATE TABLE tipos_boleta (
    tipo_boleta_id   SERIAL          PRIMARY KEY,
    nombre           VARCHAR(60)     NOT NULL UNIQUE,  -- General, VIP, Platino, Abono 3 días
    descripcion      TEXT,
    precio_cop       NUMERIC(12,2)   NOT NULL,
    cupo_total       INTEGER         NOT NULL,
    cupo_disponible  INTEGER         NOT NULL,
    dias_valido      INTEGER         NOT NULL DEFAULT 1,  -- 1, 2 o 3 días
    incluye_zona_vip BOOLEAN         NOT NULL DEFAULT FALSE,

    CONSTRAINT chk_boleta_precio     CHECK (precio_cop > 0),
    CONSTRAINT chk_boleta_cupo       CHECK (cupo_total > 0),
    CONSTRAINT chk_boleta_disponible CHECK (cupo_disponible >= 0 AND cupo_disponible <= cupo_total),
    CONSTRAINT chk_boleta_dias       CHECK (dias_valido BETWEEN 1 AND 3)
);

-- ============================================================
-- 6. ASISTENTES
-- ============================================================
CREATE TABLE asistentes (
    asistente_id     SERIAL          PRIMARY KEY,
    numero_documento VARCHAR(20)     NOT NULL UNIQUE,
    tipo_documento   VARCHAR(10)     NOT NULL DEFAULT 'CC'
                        CHECK (tipo_documento IN ('CC','CE','Pasaporte','TI')),
    nombres          VARCHAR(80)     NOT NULL,
    apellidos        VARCHAR(80)     NOT NULL,
    email            VARCHAR(120)    NOT NULL UNIQUE,
    telefono         VARCHAR(20),
    fecha_nacimiento DATE,
    ciudad_residencia VARCHAR(60),
    fecha_registro   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_asistente_email CHECK (email LIKE '%@%.%')
);

CREATE INDEX idx_asistentes_doc   ON asistentes (numero_documento);
CREATE INDEX idx_asistentes_email ON asistentes (email);

-- ============================================================
-- 7. VENTAS
-- ============================================================
CREATE TABLE ventas (
    venta_id         SERIAL          PRIMARY KEY,
    asistente_id     INTEGER         NOT NULL REFERENCES asistentes(asistente_id)      ON DELETE RESTRICT,
    tipo_boleta_id   INTEGER         NOT NULL REFERENCES tipos_boleta(tipo_boleta_id)  ON DELETE RESTRICT,
    cantidad         INTEGER         NOT NULL DEFAULT 1,
    precio_unitario  NUMERIC(12,2)   NOT NULL,
    total_venta      NUMERIC(14,2)   NOT NULL,
    fecha_venta      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metodo_pago      VARCHAR(30)     NOT NULL
                        CHECK (metodo_pago IN ('Tarjeta crédito','Tarjeta débito','PSE','Efectivo','Nequi','Daviplata')),
    codigo_transaccion VARCHAR(40)   UNIQUE,
    estado_pago      VARCHAR(20)     NOT NULL DEFAULT 'Confirmado'
                        CHECK (estado_pago IN ('Pendiente','Confirmado','Rechazado','Reembolsado')),

    CONSTRAINT chk_venta_cantidad CHECK (cantidad > 0),
    CONSTRAINT chk_venta_total    CHECK (total_venta > 0)
);

CREATE INDEX idx_ventas_asistente   ON ventas (asistente_id);
CREATE INDEX idx_ventas_boleta      ON ventas (tipo_boleta_id);
CREATE INDEX idx_ventas_fecha       ON ventas (fecha_venta);
CREATE INDEX idx_ventas_estado_pago ON ventas (estado_pago);

-- ============================================================
-- 8. STAFF
-- ============================================================
CREATE TABLE staff (
    staff_id         SERIAL          PRIMARY KEY,
    numero_documento VARCHAR(20)     NOT NULL UNIQUE,
    nombres          VARCHAR(80)     NOT NULL,
    apellidos        VARCHAR(80)     NOT NULL,
    rol              VARCHAR(50)     NOT NULL
                        CHECK (rol IN ('Técnico de sonido','Técnico de luces','Seguridad',
                                       'Logística','Médico','Coordinador','Taquilla','Limpieza','Prensa')),
    escenario_id     INTEGER         REFERENCES escenarios(escenario_id) ON DELETE SET NULL,
    turno            VARCHAR(20)     NOT NULL DEFAULT 'Completo'
                        CHECK (turno IN ('Mañana','Tarde','Noche','Completo')),
    salario_dia_cop  NUMERIC(10,2)   NOT NULL,
    contacto_emergencia VARCHAR(120),
    activo           BOOLEAN         NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_staff_salario CHECK (salario_dia_cop > 0)
);

CREATE INDEX idx_staff_rol       ON staff (rol);
CREATE INDEX idx_staff_escenario ON staff (escenario_id);

-- ============================================================
-- 9. TABLA DE AUDITORÍA (usada por trigger)
-- ============================================================
CREATE TABLE auditoria_presentaciones (
    auditoria_id     SERIAL          PRIMARY KEY,
    presentacion_id  INTEGER         NOT NULL,
    campo_modificado VARCHAR(40)     NOT NULL,
    valor_anterior   TEXT,
    valor_nuevo      TEXT,
    usuario_bd       VARCHAR(60)     NOT NULL DEFAULT CURRENT_USER,
    fecha_cambio     TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    operacion        VARCHAR(10)     NOT NULL CHECK (operacion IN ('INSERT','UPDATE','DELETE'))
);

CREATE INDEX idx_auditoria_presentacion ON auditoria_presentaciones (presentacion_id);
CREATE INDEX idx_auditoria_fecha        ON auditoria_presentaciones (fecha_cambio);

-- ============================================================
-- FIN DEL SCRIPT
-- ============================================================
