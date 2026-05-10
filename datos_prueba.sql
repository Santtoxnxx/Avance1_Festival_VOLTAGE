-- ============================================================
--  VOLTAGE FESTIVAL · Bases de Datos 2 · 2026-1
--  Script 2: Datos de prueba
--  Mínimo 30 registros en entidades principales
-- ============================================================

-- ============================================================
-- ESCENARIOS (4 escenarios)
-- ============================================================
INSERT INTO escenarios (nombre, capacidad_maxima, ubicacion, tipo_escenario, equipamiento, tiene_zona_vip) VALUES
('Main Stage Voltage',   18000, 'Zona Norte - Parque Simón Bolívar', 'Principal',  'Sistema L-Acoustics K2 96 cabinets, consola SSL 9000, pantallas LED 300m²', TRUE),
('Underground Arena',     6000, 'Zona Sur - Carpa estructural',       'Indoor',     'Sistema d&b audiotechnik J-Series, visuales 360° mapping', FALSE),
('Solar Terrace',         4500, 'Zona Este - Explanada cubierta',     'Outdoor',    'Sistema QSC TouchMix, equipo DJ Pioneer CDJ-3000 + mixer DJM-A9', TRUE),
('Quantum Dome',          2500, 'Zona Oeste - Domo geodésico',        'Carpa',      'Sistema Meyer Sound Leopard, instalación audiovisual inmersiva', FALSE);

-- ============================================================
-- TIPOS DE BOLETA (5 categorías)
-- ============================================================
INSERT INTO tipos_boleta (nombre, descripcion, precio_cop, cupo_total, cupo_disponible, dias_valido, incluye_zona_vip) VALUES
('General Día',        'Acceso 1 día a todos los escenarios públicos',            180000, 10000, 9650, 1, FALSE),
('General Abono',      'Acceso 3 días completos, escenarios públicos',            420000,  8000, 7740, 3, FALSE),
('VIP Día',            'Acceso 1 día + zona VIP + bar premium + parking',         480000,  1500, 1430, 1, TRUE),
('VIP Abono',          'Acceso 3 días + todas las zonas VIP + servicios premium', 990000,   800,  765, 3, TRUE),
('Platino All-Access',  'Acceso total incluyendo backstage, meet & greet, catering exclusivo', 2200000, 200, 195, 3, TRUE);

-- ============================================================
-- ARTISTAS (35 artistas)
-- ============================================================
INSERT INTO artistas (nombre_artistico, nombre_real, pais_origen, genero_especifico, integrantes_principales, biografia) VALUES
('Carl Voltage',       'Carlos Vergara Díaz',      'Colombia',     'Techno',        'Solo',                        'Pionero del techno colombiano, residente en Berlín desde 2018'),
('Luna Bass',          'Valentina Ríos',            'Colombia',     'Drum & Bass',   'Solo',                        'Referente femenina del DnB en Latinoamérica'),
('NEXO',               'David Salas',               'Colombia',     'Progressive House','Solo',                    'DJ/productor bogotano con +500k oyentes mensuales en Spotify'),
('Spektrum',           'Spektrum Collective',        'Alemania',     'Techno',        'Markus Kohl, Jana Dreher',   'Dúo berlinés conocido por sus sets de 6 horas'),
('Mia Holtz',          'Mia Holtz',                 'Países Bajos', 'Trance',        'Solo',                       'Considerada una de las mejores productoras de trance de la década'),
('DJ Rampage',         'Ramón Parra',               'México',       'Reggaeton EDM', 'Solo',                       'Fusión única de reggaetón con electrónica'),
('Cosmic Drift',       'Cosmic Drift',               'Reino Unido',  'Ambient Techno','Lena Fox, Oliver Stark',    'Conocidos por sus sets cinematográficos con visuales en vivo'),
('Nova Rave',          'Camila Torres',             'Argentina',    'House',         'Solo',                       'Productora porteña radicada en Barcelona'),
('Binary Code',        'Andrés Méndez',             'Colombia',     'Minimal Techno','Solo',                      'Ingeniero de sonido y DJ, fundador del colectivo Bogotá Beats'),
('AURA',               'Sofia Restrepo',            'Colombia',     'Deep House',   'Solo',                        'Primera artista colombiana en tocar en Fabric London'),
('Volt & Thunder',     'Volt & Thunder',             'Suecia',       'Big Room EDM', 'Erik Nilsson, Petra Holm',  'Bestsellers de festivales open air europeos'),
('Deepsky',            'James Wright',              'Estados Unidos','Progressive House','Solo',                  'Veterano de la escena desde los años 2000'),
('Echo Chamber',       'Echo Chamber',              'Francia',      'Electro House', 'Hugo Lefebvre, Camille Roy','Dúo parisino con estética retro futurista'),
('Solaris',            'Dani Vega',                 'España',       'Melodic Techno','Solo',                     'Residente habitual de DC10 en Ibiza'),
('Bass Architect',     'Ricardo Lozano',            'Colombia',     'Dubstep',       'Solo',                      'Referente del dubstep en Colombia desde 2014'),
('Pulse Generator',    'Pulse Generator',            'Brasil',       'Techno',        'Bruno Costa, Ana Lima',     'Proyecto techno industrial de São Paulo'),
('Lena Voigt',         'Lena Voigt',                'Alemania',     'Techno',        'Solo',                      'Ex-residente del Berghain, ahora en gira mundial'),
('Neon Jungle',        'Felipe Castillo',           'Colombia',     'Future Bass',  'Solo',                       'Joven promesa con gran seguimiento en Twitch'),
('Meridian Arc',       'Meridian Arc',               'Australia',    'Psytrance',     'Jake Burns, Sara O\'Neill','Proyecto de psytrance progresivo muy aclamado en festivales'),
('K-Flux',             'Kwame Asante',              'Ghana',        'Afrotech',      'Solo',                      'Mezcla única de ritmos africanos con electrónica'),
('Iris Voss',          'Iris Voss',                 'Austria',      'Techno',        'Solo',                      'Seleccionada en Resident Advisor Top 10 DJs 2025'),
('Datacide',           'Marco Pinto',               'Italia',       'Industrial Techno','Solo',                  'Sets oscuros y potentes, referencia del techno italiano'),
('Synthwave Riders',   'Synthwave Riders',           'Japón',        'Synthwave',     'Hiro Tanaka, Yuki Mori',   'Estética retro ochentera con producción impecable'),
('Lara Nova',          'Laura Novak',               'República Checa','Melodic House','Solo',                    'Productora y DJ conocida por su estilo emocional'),
('Grid Matrix',        'Sebastián García',          'Colombia',     'Techno',        'Solo',                      'Uno de los DJs más prometedores de la escena local'),
('Parallax',           'Parallax',                   'Bélgica',      'Trance',        'Tom De Smedt, Els Wouters','Dúo especialista en uplifting trance'),
('Night Protocol',     'Fabian Werner',             'Alemania',     'Dark Techno',   'Solo',                      'Conocido por sus sets de madrugada de hasta 8 horas'),
('Solar Flare',        'Isabella Moretti',          'Italia',       'Tech House',    'Solo',                      'Productora con sello propio, muy activa en redes'),
('Quantum Beat',       'Juan David Cárdenas',       'Colombia',     'Bass Music',    'Solo',                      'Fundador del festival Under Bogotá'),
('Aeon Flux',          'Aeon Flux',                  'Canadá',       'Electro',       'Sarah Lin, Mike Cho',       'Proyecto electro con influencias de los 80 y 90'),
('Tierra EDM',         'Martina Herrera',           'Colombia',     'Latin House',   'Solo',                      'Fusiona cumbia y champeta con house moderno'),
('Orbital Storm',      'Orbital Storm',              'Rusia',        'Psy Trance',    'Alexei Volkov, Nadia Kova','Vibraciones hipnóticas reconocidas en el circuito internacional'),
('Subzero',            'Pablo Nieto',               'Colombia',     'Drum & Bass',   'Solo',                      'Mayor exponente del DnB en la escena underground bogotana'),
('Hologram',           'Chen Wei',                  'China',        'Future House',  'Solo',                      'Primera vez en Latinoamérica, gran expectativa'),
('Nyx',                'Alejandra Vargas',          'Colombia',     'Ambient Techno','Solo',                      'Artista multidisciplinar: música, instalación y performance');

-- ============================================================
-- CONTRATOS (35, uno por artista)
-- ============================================================
INSERT INTO contratos (artista_id, cachet_usd, fecha_firma, fecha_inicio, fecha_fin, clausulas, metodo_pago, porcentaje_adelanto, estado) VALUES
(1,  15000, '2026-01-10', '2026-07-17', '2026-07-20', 'Incluye pasajes y alojamiento 4 noches. Backline propio.', 'Transferencia bancaria', 40, 'Vigente'),
(2,  12000, '2026-01-12', '2026-07-17', '2026-07-20', 'Rider técnico adjunto. 2 sets de 1h cada uno.',            'Transferencia bancaria', 30, 'Vigente'),
(3,  18000, '2026-01-15', '2026-07-17', '2026-07-20', 'Headliner nacional. Backline cedido por festival.',        'Transferencia bancaria', 50, 'Vigente'),
(4,  45000, '2026-01-20', '2026-07-17', '2026-07-20', 'Vuelos business + hotel 5 estrellas. Cláusula de exclusividad regional 30 días.', 'Swift internacional', 40, 'Vigente'),
(5,  55000, '2026-01-22', '2026-07-17', '2026-07-20', 'Co-headliner Main Stage día 2. Producción de visuales incluida.', 'Swift internacional', 30, 'Vigente'),
(6,  20000, '2026-01-25', '2026-07-17', '2026-07-20', 'Vuelos desde CDMX + hotel. Merch exclusivo 50/50.',        'Swift internacional', 40, 'Vigente'),
(7,  60000, '2026-02-01', '2026-07-17', '2026-07-20', 'Headliner día 3. Sistema de visuales propio requerido.',   'Swift internacional', 35, 'Vigente'),
(8,  22000, '2026-02-03', '2026-07-17', '2026-07-20', 'Vuelos desde Barcelona + 4 noches hotel.',                 'Swift internacional', 30, 'Vigente'),
(9,   9000, '2026-02-05', '2026-07-17', '2026-07-20', 'Set de 90 minutos en Underground Arena.',                  'Transferencia bancaria', 40, 'Vigente'),
(10, 13000, '2026-02-08', '2026-07-17', '2026-07-20', 'Primera artista colombiana con headliner en Main Stage.',  'Transferencia bancaria', 50, 'Vigente'),
(11, 70000, '2026-02-10', '2026-07-17', '2026-07-20', 'Headliner principal día 1. Producción pyro incluida.',     'Swift internacional', 40, 'Vigente'),
(12, 35000, '2026-02-12', '2026-07-17', '2026-07-20', 'Set de 2 horas. Back catalog completo disponible.',        'Swift internacional', 30, 'Vigente'),
(13, 28000, '2026-02-15', '2026-07-17', '2026-07-20', 'Dúo. 2 tickets de vuelo + hotel.',                         'Swift internacional', 35, 'Vigente'),
(14, 32000, '2026-02-18', '2026-07-17', '2026-07-20', 'Solo vuelos. Hotel gestionado por artista.',               'Swift internacional', 30, 'Vigente'),
(15,  8000, '2026-02-20', '2026-07-17', '2026-07-20', 'Set local 75 min.',                                        'Transferencia bancaria', 40, 'Vigente'),
(16, 25000, '2026-02-22', '2026-07-17', '2026-07-20', 'Dúo + manager = 3 vuelos + hotel.',                        'Swift internacional', 30, 'Vigente'),
(17, 50000, '2026-03-01', '2026-07-17', '2026-07-20', 'Ex-residente Berghain. Set mínimo 3 horas.',               'Swift internacional', 35, 'Vigente'),
(18,  7000, '2026-03-05', '2026-07-17', '2026-07-20', 'Artista local en crecimiento. Set de apertura.',           'Transferencia bancaria', 40, 'Vigente'),
(19, 38000, '2026-03-08', '2026-07-17', '2026-07-20', 'Dúo. 2 vuelos desde Sídney + hotel premium.',              'Swift internacional', 30, 'Vigente'),
(20, 18000, '2026-03-10', '2026-07-17', '2026-07-20', 'Primera vez en Colombia. Kit de percusión propio.',        'Swift internacional', 40, 'Vigente'),
(21, 48000, '2026-03-12', '2026-07-17', '2026-07-20', 'Top 10 RA. Co-headliner Underground Arena.',               'Swift internacional', 35, 'Vigente'),
(22, 27000, '2026-03-15', '2026-07-17', '2026-07-20', 'Set oscuro 2 horas, horario de madrugada.',                'Swift internacional', 30, 'Vigente'),
(23, 30000, '2026-03-18', '2026-07-17', '2026-07-20', 'Dúo. Equipamiento vintage propio (1 tonelada de carga).',  'Swift internacional', 40, 'Vigente'),
(24, 24000, '2026-03-20', '2026-07-17', '2026-07-20', 'Vuelos desde Praga + hotel 4 noches.',                     'Swift internacional', 30, 'Vigente'),
(25,  7500, '2026-03-22', '2026-07-17', '2026-07-20', 'Artista local emergente, set de 60 min.',                  'Transferencia bancaria', 40, 'Vigente'),
(26, 40000, '2026-03-25', '2026-07-17', '2026-07-20', 'Dúo. Vuelos desde Bruselas + hotel.',                      'Swift internacional', 30, 'Vigente'),
(27, 52000, '2026-03-28', '2026-07-17', '2026-07-20', 'Set madrugada 4 horas. Cláusula de silencio técnico previo.','Swift internacional', 35, 'Vigente'),
(28, 21000, '2026-04-01', '2026-07-17', '2026-07-20', 'Productora con sello propio. 1 set + masterclass.',        'Swift internacional', 40, 'Vigente'),
(29,  9500, '2026-04-03', '2026-07-17', '2026-07-20', 'Artista local. 2 sets en Quantum Dome.',                   'Transferencia bancaria', 40, 'Vigente'),
(30, 33000, '2026-04-05', '2026-07-17', '2026-07-20', 'Dúo Canadá. Vuelos + hotel 4 noches.',                     'Swift internacional', 30, 'Vigente'),
(31,  8500, '2026-04-08', '2026-07-17', '2026-07-20', 'Set local. Fusión géneros propuesta interesante.',         'Transferencia bancaria', 40, 'Vigente'),
(32, 29000, '2026-04-10', '2026-07-17', '2026-07-20', 'Dúo Rusia. Vuelos + 4 noches hotel.',                      'Swift internacional', 30, 'Vigente'),
(33,  7000, '2026-04-12', '2026-07-17', '2026-07-20', 'Set local 60 min. Opening Underground Arena.',             'Transferencia bancaria', 40, 'Vigente'),
(34, 41000, '2026-04-15', '2026-07-17', '2026-07-20', 'Artista China primera vez en Colombia.',                   'Swift internacional', 35, 'Vigente'),
(35, 11000, '2026-04-18', '2026-07-17', '2026-07-20', 'Artista local multidisciplinar. Instalación + set.',       'Transferencia bancaria', 40, 'Vigente');

-- ============================================================
-- PRESENTACIONES (35 presentaciones en 3 días)
-- Día 1: 2026-07-18 | Día 2: 2026-07-19 | Día 3: 2026-07-20
-- ============================================================
INSERT INTO presentaciones (artista_id, escenario_id, fecha_hora_inicio, fecha_hora_fin, estado, notas) VALUES
-- DÍA 1 - Main Stage Voltage
(18, 1, '2026-07-18 16:00:00', '2026-07-18 17:00:00', 'Programada', 'Set de apertura del festival'),
(25, 1, '2026-07-18 17:15:00', '2026-07-18 18:15:00', 'Programada', 'Segundo set del día'),
(6,  1, '2026-07-18 19:00:00', '2026-07-18 20:30:00', 'Programada', 'Artista internacional'),
(10, 1, '2026-07-18 21:00:00', '2026-07-18 22:30:00', 'Programada', 'Headliner nacional Día 1'),
(11, 1, '2026-07-18 23:00:00', '2026-07-19 01:00:00', 'Programada', 'Headliner principal Día 1 - Cierre'),
-- DÍA 1 - Underground Arena
(33, 2, '2026-07-18 17:00:00', '2026-07-18 18:00:00', 'Programada', 'Opening Underground'),
(9,  2, '2026-07-18 18:30:00', '2026-07-18 20:00:00', 'Programada', 'Set techno local'),
(22, 2, '2026-07-18 20:30:00', '2026-07-18 22:30:00', 'Programada', 'Industrial techno'),
(17, 2, '2026-07-18 23:00:00', '2026-07-19 02:00:00', 'Programada', 'Set de 3 horas - madrugada'),
-- DÍA 1 - Solar Terrace
(35, 3, '2026-07-18 16:30:00', '2026-07-18 17:30:00', 'Programada', 'Instalación + set apertura'),
(31, 3, '2026-07-18 18:00:00', '2026-07-18 19:30:00', 'Programada', 'Latin House'),
(8,  3, '2026-07-18 20:00:00', '2026-07-18 21:30:00', 'Programada', 'House Internacional'),
-- DÍA 1 - Quantum Dome
(29, 4, '2026-07-18 17:00:00', '2026-07-18 18:30:00', 'Programada', 'Bass Music local'),
(15, 4, '2026-07-18 19:00:00', '2026-07-18 20:30:00', 'Programada', 'Dubstep local'),
-- DÍA 2 - Main Stage Voltage
(20, 1, '2026-07-19 16:00:00', '2026-07-19 17:15:00', 'Programada', 'Afrotech - primera vez en Colombia'),
(13, 1, '2026-07-19 17:45:00', '2026-07-19 19:15:00', 'Programada', 'Electro House - dúo francés'),
(3,  1, '2026-07-19 20:00:00', '2026-07-19 21:30:00', 'Programada', 'Headliner nacional Día 2'),
(5,  1, '2026-07-19 22:30:00', '2026-07-20 00:30:00', 'Programada', 'Co-headliner Día 2 - Mia Holtz'),
-- DÍA 2 - Underground Arena
(1,  2, '2026-07-19 17:00:00', '2026-07-19 19:00:00', 'Programada', 'Carl Voltage - set 2 horas'),
(16, 2, '2026-07-19 19:30:00', '2026-07-19 21:30:00', 'Programada', 'Pulse Generator - techno Brasil'),
(21, 2, '2026-07-19 22:00:00', '2026-07-20 00:30:00', 'Programada', 'Iris Voss - Top 10 RA'),
-- DÍA 2 - Solar Terrace
(24, 3, '2026-07-19 17:00:00', '2026-07-19 18:30:00', 'Programada', 'Melodic House - Lara Nova'),
(14, 3, '2026-07-19 19:00:00', '2026-07-19 21:00:00', 'Programada', 'Melodic Techno - Solaris'),
-- DÍA 2 - Quantum Dome
(19, 4, '2026-07-19 18:00:00', '2026-07-19 20:00:00', 'Programada', 'Psytrance - Meridian Arc'),
(26, 4, '2026-07-19 20:30:00', '2026-07-19 22:30:00', 'Programada', 'Trance - Parallax'),
-- DÍA 3 - Main Stage Voltage
(2,  1, '2026-07-20 16:00:00', '2026-07-20 17:00:00', 'Programada', 'Luna Bass - opening DnB'),
(12, 1, '2026-07-20 17:30:00', '2026-07-20 19:30:00', 'Programada', 'Deepsky - veterano'),
(4,  1, '2026-07-20 20:00:00', '2026-07-20 22:00:00', 'Programada', 'Spektrum - dúo berlinés'),
(7,  1, '2026-07-20 22:30:00', '2026-07-21 01:00:00', 'Programada', 'CIERRE Cosmic Drift - headliner final'),
-- DÍA 3 - Underground Arena
(23, 2, '2026-07-20 17:00:00', '2026-07-20 19:00:00', 'Programada', 'Synthwave Riders'),
(34, 2, '2026-07-20 19:30:00', '2026-07-20 21:00:00', 'Programada', 'Hologram - primera vez en LATAM'),
(27, 2, '2026-07-20 21:30:00', '2026-07-21 01:30:00', 'Programada', 'Night Protocol - 4 horas madrugada'),
-- DÍA 3 - Solar Terrace
(30, 3, '2026-07-20 17:00:00', '2026-07-20 18:30:00', 'Programada', 'Aeon Flux - electro canadiense'),
(28, 3, '2026-07-20 19:00:00', '2026-07-20 21:00:00', 'Programada', 'Solar Flare - tech house'),
-- DÍA 3 - Quantum Dome
(32, 4, '2026-07-20 18:00:00', '2026-07-20 20:00:00', 'Programada', 'Orbital Storm - psytrance'),
(1,  4, '2026-07-20 20:30:00', '2026-07-20 22:00:00', 'Programada', 'Carl Voltage - segundo set Quantum Dome');

-- ============================================================
-- ASISTENTES (35 asistentes)
-- ============================================================
INSERT INTO asistentes (numero_documento, tipo_documento, nombres, apellidos, email, telefono, fecha_nacimiento, ciudad_residencia) VALUES
('1020345678', 'CC', 'Santiago',   'Moreno Rueda',      'santiago.moreno@gmail.com',    '3001234567', '1998-03-14', 'Bogotá'),
('1035678901', 'CC', 'Valeria',    'Pinto Salcedo',     'valeria.pinto@hotmail.com',    '3102345678', '2000-07-22', 'Bogotá'),
('1045890123', 'CC', 'Nicolás',    'Castro Vargas',     'nicolas.castro@gmail.com',     '3203456789', '1997-11-05', 'Medellín'),
('1056012345', 'CC', 'Isabella',   'Ramírez Gil',       'isabella.ramirez@gmail.com',   '3154567890', '1999-02-18', 'Bogotá'),
('1067234567', 'CC', 'Mateo',      'Torres Acosta',     'mateo.torres@outlook.com',     '3005678901', '1996-09-30', 'Cali'),
('1078456789', 'CC', 'Sara',       'González López',    'sara.gonzalez@gmail.com',      '3116789012', '2001-04-12', 'Bogotá'),
('1089678901', 'CC', 'Julián',     'Herrera Suárez',    'julian.herrera@gmail.com',     '3227890123', '1995-06-25', 'Bogotá'),
('1090891234', 'CC', 'Daniela',    'Rodríguez Ospina',  'daniela.r@yahoo.com',          '3138901234', '2002-12-08', 'Bogotá'),
('1101012345', 'CC', 'Sebastián',  'Martínez Cruz',     'sebastian.m@gmail.com',        '3009012345', '1993-08-17', 'Barranquilla'),
('1112234567', 'CC', 'Camila',     'Jiménez Reyes',     'camila.j@gmail.com',           '3100123456', '1998-01-29', 'Bogotá'),
('1123456789', 'CC', 'Andrés',     'López Pedraza',     'andres.lopez@gmail.com',       '3211234567', '1994-05-11', 'Bogotá'),
('1134678901', 'CC', 'Luciana',    'Díaz Montoya',      'luciana.diaz@hotmail.com',     '3142345678', '2000-10-04', 'Medellín'),
('1145890123', 'CC', 'David',      'García Cano',       'david.garcia@gmail.com',       '3013456789', '1997-03-23', 'Bogotá'),
('1156012345', 'CC', 'Sofia',      'Álvarez Benítez',   'sofia.alvarez@gmail.com',      '3124567890', '1999-07-16', 'Bogotá'),
('1167234567', 'CC', 'Felipe',     'Sánchez Ríos',      'felipe.sanchez@outlook.com',   '3235678901', '1996-12-01', 'Cali'),
('1178456789', 'CC', 'Alejandra',  'Muñoz Torres',      'alejandra.m@gmail.com',        '3156789012', '2001-02-28', 'Bogotá'),
('1189678901', 'CC', 'Diego',      'Vargas Forero',     'diego.vargas@gmail.com',       '3007890123', '1992-09-09', 'Bogotá'),
('1190891234', 'CC', 'Mariana',    'Rojas Niño',        'mariana.rojas@yahoo.com',      '3108901234', '2003-04-15', 'Bogotá'),
('1201012345', 'CC', 'Daniel',     'Flores Bermúdez',   'daniel.flores@gmail.com',      '3219012345', '1995-11-22', 'Bucaramanga'),
('1212234567', 'CC', 'Valentina',  'Cruz Echeverri',    'valentina.c@gmail.com',        '3130123456', '2000-06-07', 'Bogotá'),
('1223456789', 'CC', 'Pablo',      'Romero Guerrero',   'pablo.romero@gmail.com',       '3001234568', '1991-01-14', 'Bogotá'),
('1234678901', 'CC', 'Laura',      'Mora Castillo',     'laura.mora@hotmail.com',       '3102345679', '1998-08-31', 'Bogotá'),
('1245890123', 'CC', 'Tomás',      'Peña Salinas',      'tomas.pena@gmail.com',         '3203456790', '1997-04-19', 'Medellín'),
('1256012345', 'CC', 'Carolina',   'Delgado Parra',     'carolina.d@gmail.com',         '3154567891', '2001-10-26', 'Bogotá'),
('1267234567', 'CC', 'Miguel',     'Santos Ruiz',       'miguel.santos@outlook.com',    '3005678902', '1993-02-03', 'Bogotá'),
('1278456789', 'CC', 'Natalia',    'Ortega Mendoza',    'natalia.ortega@gmail.com',     '3116789013', '1999-09-12', 'Bogotá'),
('1289678901', 'CC', 'Alejandro',  'Navarro Cifuentes', 'alejandro.n@gmail.com',        '3227890124', '1996-05-08', 'Cali'),
('1290891234', 'CC', 'Gabriela',   'Fuentes Arango',    'gabriela.f@yahoo.com',         '3138901235', '2002-03-25', 'Bogotá'),
('1301012345', 'CC', 'Esteban',    'Gutiérrez Vega',    'esteban.g@gmail.com',          '3009012346', '1994-12-18', 'Bogotá'),
('1312234567', 'CC', 'Renata',     'Medina Ospina',     'renata.medina@gmail.com',      '3100123457', '2000-07-05', 'Bogotá'),
('1323456789', 'CC', 'Joaquín',    'Silva Arenas',      'joaquin.silva@gmail.com',      '3211234568', '1990-03-30', 'Bogotá'),
('1334678901', 'CC', 'Manuela',    'Ramos Duque',       'manuela.ramos@hotmail.com',    '3142345679', '1997-11-14', 'Medellín'),
('1345890123', 'CC', 'Cristian',   'Aguilar León',      'cristian.a@gmail.com',         '3013456790', '1995-08-02', 'Bogotá'),
('1356012345', 'CC', 'Paula',      'Blanco Torres',     'paula.blanco@gmail.com',       '3124567891', '1998-06-21', 'Bogotá'),
('1367234567', 'CC', 'Simón',      'Fernández Cely',    'simon.fernandez@outlook.com',  '3235678902', '2001-01-10', 'Bogotá');

-- ============================================================
-- VENTAS (35 ventas)
-- ============================================================
INSERT INTO ventas (asistente_id, tipo_boleta_id, cantidad, precio_unitario, total_venta, fecha_venta, metodo_pago, codigo_transaccion, estado_pago) VALUES
(1,  2, 1, 420000,  420000,  '2026-05-01 10:23:00', 'PSE',             'TXN-VLT-000001', 'Confirmado'),
(2,  4, 1, 990000,  990000,  '2026-05-01 11:05:00', 'Tarjeta crédito', 'TXN-VLT-000002', 'Confirmado'),
(3,  2, 2, 420000,  840000,  '2026-05-02 09:15:00', 'PSE',             'TXN-VLT-000003', 'Confirmado'),
(4,  1, 1, 180000,  180000,  '2026-05-02 14:30:00', 'Nequi',           'TXN-VLT-000004', 'Confirmado'),
(5,  3, 1, 480000,  480000,  '2026-05-03 16:45:00', 'Tarjeta crédito', 'TXN-VLT-000005', 'Confirmado'),
(6,  2, 1, 420000,  420000,  '2026-05-03 18:20:00', 'PSE',             'TXN-VLT-000006', 'Confirmado'),
(7,  5, 1, 2200000, 2200000, '2026-05-04 10:00:00', 'Tarjeta crédito', 'TXN-VLT-000007', 'Confirmado'),
(8,  1, 2, 180000,  360000,  '2026-05-04 12:10:00', 'Daviplata',       'TXN-VLT-000008', 'Confirmado'),
(9,  4, 1, 990000,  990000,  '2026-05-05 09:30:00', 'PSE',             'TXN-VLT-000009', 'Confirmado'),
(10, 2, 1, 420000,  420000,  '2026-05-05 15:45:00', 'Nequi',           'TXN-VLT-000010', 'Confirmado'),
(11, 3, 2, 480000,  960000,  '2026-05-06 11:20:00', 'Tarjeta crédito', 'TXN-VLT-000011', 'Confirmado'),
(12, 1, 1, 180000,  180000,  '2026-05-06 16:00:00', 'Efectivo',        'TXN-VLT-000012', 'Confirmado'),
(13, 2, 1, 420000,  420000,  '2026-05-07 10:45:00', 'PSE',             'TXN-VLT-000013', 'Confirmado'),
(14, 5, 1, 2200000, 2200000, '2026-05-07 13:30:00', 'Tarjeta crédito', 'TXN-VLT-000014', 'Confirmado'),
(15, 1, 3, 180000,  540000,  '2026-05-08 09:15:00', 'Nequi',           'TXN-VLT-000015', 'Confirmado'),
(16, 4, 1, 990000,  990000,  '2026-05-08 14:00:00', 'PSE',             'TXN-VLT-000016', 'Confirmado'),
(17, 2, 1, 420000,  420000,  '2026-05-09 11:30:00', 'Tarjeta débito',  'TXN-VLT-000017', 'Confirmado'),
(18, 1, 1, 180000,  180000,  '2026-05-09 15:20:00', 'Daviplata',       'TXN-VLT-000018', 'Confirmado'),
(19, 3, 1, 480000,  480000,  '2026-05-10 10:05:00', 'Tarjeta crédito', 'TXN-VLT-000019', 'Confirmado'),
(20, 2, 2, 420000,  840000,  '2026-05-10 12:45:00', 'PSE',             'TXN-VLT-000020', 'Confirmado'),
(21, 1, 1, 180000,  180000,  '2026-05-11 09:00:00', 'Nequi',           'TXN-VLT-000021', 'Confirmado'),
(22, 4, 1, 990000,  990000,  '2026-05-11 16:30:00', 'Tarjeta crédito', 'TXN-VLT-000022', 'Confirmado'),
(23, 2, 1, 420000,  420000,  '2026-05-12 10:20:00', 'PSE',             'TXN-VLT-000023', 'Confirmado'),
(24, 5, 1, 2200000, 2200000, '2026-05-12 14:15:00', 'Tarjeta crédito', 'TXN-VLT-000024', 'Confirmado'),
(25, 1, 2, 180000,  360000,  '2026-05-13 11:00:00', 'Daviplata',       'TXN-VLT-000025', 'Confirmado'),
(26, 3, 1, 480000,  480000,  '2026-05-13 13:45:00', 'PSE',             'TXN-VLT-000026', 'Confirmado'),
(27, 2, 1, 420000,  420000,  '2026-05-14 09:30:00', 'Nequi',           'TXN-VLT-000027', 'Confirmado'),
(28, 1, 1, 180000,  180000,  '2026-05-14 15:10:00', 'Efectivo',        'TXN-VLT-000028', 'Confirmado'),
(29, 4, 1, 990000,  990000,  '2026-05-15 10:55:00', 'Tarjeta crédito', 'TXN-VLT-000029', 'Confirmado'),
(30, 2, 1, 420000,  420000,  '2026-05-15 14:20:00', 'PSE',             'TXN-VLT-000030', 'Confirmado'),
(31, 1, 1, 180000,  180000,  '2026-05-16 09:45:00', 'Nequi',           'TXN-VLT-000031', 'Confirmado'),
(32, 3, 2, 480000,  960000,  '2026-05-16 12:30:00', 'Tarjeta crédito', 'TXN-VLT-000032', 'Confirmado'),
(33, 2, 1, 420000,  420000,  '2026-05-17 10:10:00', 'PSE',             'TXN-VLT-000033', 'Confirmado'),
(34, 5, 1, 2200000, 2200000, '2026-05-17 11:50:00', 'Tarjeta crédito', 'TXN-VLT-000034', 'Confirmado'),
(35, 1, 1, 180000,  180000,  '2026-05-18 09:00:00', 'Daviplata',       'TXN-VLT-000035', 'Confirmado');

-- ============================================================
-- STAFF (20 miembros)
-- ============================================================
INSERT INTO staff (numero_documento, nombres, apellidos, rol, escenario_id, turno, salario_dia_cop, contacto_emergencia) VALUES
('80123456', 'Carlos',  'Mendoza',    'Técnico de sonido', 1, 'Completo',  220000, 'Ana Mendoza 3001111111'),
('52234567', 'Adriana', 'López',      'Técnico de luces',  1, 'Noche',     200000, 'Luis López 3112222222'),
('79345678', 'Hernán',  'Suárez',     'Técnico de sonido', 2, 'Completo',  220000, 'María Suárez 3223333333'),
('31456789', 'Patricia','Gómez',      'Coordinador',       1, 'Completo',  280000, 'Jorge Gómez 3134444444'),
('1009876', 'Óscar',    'Valencia',   'Seguridad',         1, 'Noche',     150000, 'Rosa Valencia 3005555555'),
('1010987', 'Luisa',    'Bermúdez',   'Seguridad',         2, 'Noche',     150000, 'Pedro Bermúdez 3116666666'),
('1012098', 'Rober',    'Acosta',     'Seguridad',         3, 'Completo',  150000, 'Elena Acosta 3227777777'),
('52678901', 'Marcela', 'Fonseca',    'Taquilla',          NULL,'Completo', 160000, 'Tomás Fonseca 3148888888'),
('79789012', 'Gustavo', 'Prada',      'Taquilla',          NULL,'Completo', 160000, 'Sandra Prada 3009999999'),
('1013109', 'Verónica', 'Morales',    'Médico',            NULL,'Completo', 300000, 'Dr. Morales 3101010101'),
('1014210', 'Ernesto',  'Cárdenas',   'Médico',            NULL,'Noche',    300000, 'Inés Cárdenas 3211111112'),
('80890123', 'Rafael',  'Téllez',     'Técnico de luces',  2, 'Noche',     200000, 'Pilar Téllez 3142020202'),
('52901234', 'Gloria',  'Nieves',     'Logística',         NULL,'Completo', 180000, 'Raúl Nieves 3013030303'),
('79012345', 'Mario',   'Corredor',   'Logística',         NULL,'Tarde',    180000, 'Luz Corredor 3124040404'),
('1015321', 'Pamela',   'Rueda',      'Prensa',            NULL,'Completo', 210000, 'Héctor Rueda 3235050505'),
('1016432', 'Camilo',   'Espinosa',   'Técnico de sonido', 3, 'Completo',  220000, 'Dora Espinosa 3156060606'),
('1017543', 'Ingrid',   'Castañeda',  'Técnico de luces',  3, 'Noche',     200000, 'Felipe Castañeda 3007070707'),
('1018654', 'Rodrigo',  'Betancourt', 'Coordinador',       2, 'Completo',  280000, 'Clara Betancourt 3118080808'),
('1019765', 'Paola',    'Sarmiento',  'Seguridad',         4, 'Completo',  150000, 'Jaime Sarmiento 3229090909'),
('1020876', 'Nicolás',  'Pineda',     'Técnico de sonido', 4, 'Completo',  220000, 'Diana Pineda 3131010101');
