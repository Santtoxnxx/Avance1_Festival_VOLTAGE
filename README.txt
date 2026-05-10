================================================================
 VOLTAGE FESTIVAL - README
 Proyecto Integrador · Bases de Datos 2 · 2026-1
 Universidad El Bosque · Ingeniería de Sistemas
================================================================

DESCRIPCIÓN DEL FESTIVAL
--------------------------
Nombre:          VOLTAGE Festival
Género:          Música Electrónica / EDM
Ciudad:          Bogotá, Colombia (Parque Simón Bolívar)
Duración:        3 días (18, 19 y 20 de julio de 2026)
Capacidad total: ~31,000 asistentes (suma de los 4 escenarios)
Escenarios:      4  (Main Stage Voltage, Underground Arena,
                      Solar Terrace, Quantum Dome)
Artistas:        35 (nacionales e internacionales)
Particularidades:
  - Zonas VIP en Main Stage y Solar Terrace
  - 5 tipos de boleta: General/VIP por día + Abonos 3 días + Platino All-Access
  - Artistas de Alemania, Países Bajos, Suecia, Reino Unido,
    Francia, Italia, Japón, Australia, Brasil, Ghana, Rusia,
    Canadá, China, entre otros.

================================================================
 ESTRUCTURA DE ARCHIVOS
================================================================

scripts/
├── creacion_tablas.sql    → DDL: crea las 8 tablas + auditoría
├── datos_prueba.sql       → DML: inserta registros de prueba
├── triggers.sql           → 2 triggers con funciones PL/pgSQL
├── procedimientos.sql     → 2 stored functions (sp_*)
└── consultas.sql          → 3 consultas SQL significativas

README.txt                 → Este archivo

================================================================
 REQUISITOS
================================================================

- PostgreSQL 14 o superior
- Cliente psql, pgAdmin, DBeaver o Neon (neon.tech)
- Usuario con privilegios CREATE TABLE, CREATE FUNCTION, CREATE TRIGGER

================================================================
 INSTRUCCIONES DE EJECUCIÓN (orden obligatorio)
================================================================

OPCIÓN A — psql (línea de comandos)
--------------------------------------
1. Conéctese a su base de datos:
   psql -h <host> -U <usuario> -d <base_de_datos>

2. Ejecute los scripts EN ESTE ORDEN:
   \i scripts/creacion_tablas.sql
   \i scripts/datos_prueba.sql
   \i scripts/triggers.sql
   \i scripts/procedimientos.sql
   \i scripts/consultas.sql

OPCIÓN B — pgAdmin / DBeaver
--------------------------------------
1. Abra el Query Tool conectado a su base de datos.
2. Abra cada archivo y ejecútelo en el orden indicado arriba.
   (Archivo → Abrir → seleccione el .sql → F5 o botón Ejecutar)

OPCIÓN C — Neon (neon.tech)
--------------------------------------
1. Cree un proyecto en https://neon.tech
2. Copie la connection string (formato postgresql://...)
3. Use psql con esa connection string:
   psql "postgresql://usuario:password@host/dbname?sslmode=require"
4. Ejecute los scripts en el orden indicado.

================================================================
 VERIFICACIÓN RÁPIDA
================================================================

Después de ejecutar los scripts, compruebe que todo quedó bien:

-- Contar registros en las entidades principales
SELECT 'artistas'       AS tabla, COUNT(*) FROM artistas
UNION ALL
SELECT 'asistentes',    COUNT(*) FROM asistentes
UNION ALL
SELECT 'ventas',        COUNT(*) FROM ventas
UNION ALL
SELECT 'presentaciones',COUNT(*) FROM presentaciones
UNION ALL
SELECT 'contratos',     COUNT(*) FROM contratos
UNION ALL
SELECT 'escenarios',    COUNT(*) FROM escenarios
UNION ALL
SELECT 'tipos_boleta',  COUNT(*) FROM tipos_boleta
UNION ALL
SELECT 'staff',         COUNT(*) FROM staff;

-- Probar procedimiento almacenado de ventas
SELECT * FROM sp_reporte_ventas_por_dia('2026-05-01', '2026-05-31');

-- Probar procedimiento de pagos a artistas
SELECT * FROM sp_calcular_pagos_artistas() LIMIT 5;

-- Verificar triggers (ver cupo disponible)
SELECT nombre, cupo_total, cupo_disponible FROM tipos_boleta;

================================================================
 DESCRIPCIÓN DE TRIGGERS
================================================================

1. trg_validar_cupo_venta (BEFORE INSERT ON ventas)
   Valida que haya cupo disponible antes de registrar la venta.
   Si cupo_disponible < cantidad solicitada, lanza excepción.
   Si pasa la validación, descuenta el cupo automáticamente.

2. trg_auditar_presentaciones (AFTER UPDATE ON presentaciones)
   Registra en auditoria_presentaciones cualquier cambio en:
   fecha_hora_inicio, fecha_hora_fin, escenario_id o estado.
   Permite trazabilidad completa de cambios en la programación.

================================================================
 DESCRIPCIÓN DE PROCEDIMIENTOS ALMACENADOS
================================================================

1. sp_reporte_ventas_por_dia(fecha_inicio, fecha_fin)
   Retorna ventas diarias agrupadas por tipo de boleta con
   acumulados en el rango de fechas indicado.

2. sp_calcular_pagos_artistas(artista_id)
   Calcula el adelanto pagado al firmar y el monto pendiente
   por pagar a cada artista según su contrato vigente.

================================================================
 DESCRIPCIÓN DE CONSULTAS SIGNIFICATIVAS
================================================================

1. Ranking de artistas por ingresos en cada escenario
   → JOINs múltiples + RANK() window function

2. Resumen financiero por tipo de boleta con % de ocupación
   → Subconsulta en FROM + CROSS JOIN escalar + agregaciones

3. Top 10 asistentes por gasto total con boleta y pago preferidos
   → Subconsultas correlacionadas + GROUP BY + HAVING + LIMIT

================================================================
 REPOSITORIO DEL GRUPO
================================================================

Repositorio GitHub: [URL del repositorio del grupo]

================================================================
