-- SLGA Database Initialization Script

CREATE DATABASE IF NOT EXISTS slga_db;

USE slga_db;

-- ===================================================================
-- CREACION DE TABLAS
-- ===================================================================

CREATE TABLE IF NOT EXISTS aulas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    capacidad INT,
    equipamiento TEXT
);

CREATE TABLE IF NOT EXISTS profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    departamento VARCHAR(100),
    estado_actual VARCHAR(50),
    email VARCHAR(100),
    telefono VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS horarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dia_semana VARCHAR(20) NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    materia VARCHAR(150) NOT NULL,
    tipo_actividad VARCHAR(50),
    profesor_id INT,
    aula_id INT,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id) ON DELETE CASCADE,
    FOREIGN KEY (aula_id) REFERENCES aulas(id) ON DELETE SET NULL
);

-- ===================================================================
-- INSERTAR AULAS - Labs y espacios administrativos
-- ===================================================================
INSERT INTO aulas (nombre, tipo, capacidad, equipamiento) VALUES
('Lab CECA', 'Laboratorio', 30, 'Computadoras Dell, Proyector, Sistema de Audio, Pizarra Interactiva'),
('Lab Fabrica de Software', 'Laboratorio', 25, 'Computadoras, Servidores, Proyector, Pizarra Electronica'),
('Lab LAI', 'Laboratorio', 28, 'Computadoras, Laptops, Proyector, Sistema de Videoconferencia'),
('Lab LAW', 'Laboratorio', 32, 'Computadoras, Servidores Web, Proyector, Equipos de Red'),
('Lab E1', 'Laboratorio', 24, 'Computadoras, Software Especializado, Proyector, Camaras de Video'),
('Aula 101', 'Aula Teoria', 35, 'Pizarra Interactiva, Proyector, Sistema de Audio, Climatizacion'),
('Aula 102', 'Aula Teoria', 35, 'Pizarra Interactiva, Proyector, Sistema de Audio, Climatizacion'),
('Cubiculo 8', 'Cubiculo', 1, 'Escritorio, Computadora, Telefono'),
('Sala de Maestros', 'Administrativo', 15, 'Mesas, Sillas, Cafeteria, WiFi'),
('Direccion Academica', 'Administrativo', 8, 'Escritorios, Computadoras, Impresora Multifuncional'),
('Aula 103', 'Aula Teoria', 40, 'Pizarra Interactiva, Proyector, Sistema de Audio, Climatizacion');

-- ===================================================================
-- INSERTAR PROFESORES - Con email, telefono y departamentos
-- ===================================================================
INSERT INTO profesores (nombre, apellidos, departamento, estado_actual, email, telefono) VALUES
-- Sistemas Computacionales
('Julia Jasmin', 'Arana Llanes', 'Sistemas Computacionales', 'En clase', 'julia.arana@universidad.edu', '+52 555 1234-5678'),
('Gabriel', 'Sanchez Bautista', 'Sistemas Computacionales', 'Disponible', 'gabriel.sanchez@universidad.edu', '+52 555 2345-6789'),
('Ismael', 'Dominguez Jimenez', 'Sistemas Computacionales', 'Disponible', 'ismael.dominguez@universidad.edu', '+52 555 4567-8901'),

-- Programacion Web
('Monica', 'Cornejo', 'Desarrollo Web', 'En clase', 'monica.cornejo@universidad.edu', '+52 555 5566-7778'),

-- Redes y Telecomunicaciones
('Monica', 'Garcia Munguia', 'Redes y Telecomunicaciones', 'Disponible', 'monica.garcia@universidad.edu', '+52 555 3456-7890'),

-- Ingenieria de Software
('Tomas', 'Leon Quintanar', 'Ingenieria de Software', 'En junta', 'tomas.leon@universidad.edu', '+52 555 6677-8889'),
('Gustavo', 'Padron Rivera', 'Ingenieria de Software', 'En clase', 'gustavo.padron@universidad.edu', '+52 555 7788-9990'),

-- Lengua Extranjera (Ingles)
('Olivia', 'Placencia Ramirez', 'Lengua Extranjera', 'En clase', 'olivia.placencia@universidad.edu', '+52 555 8899-1001');

-- ===================================================================
-- INSERTAR HORARIOS - Horario de Entrada, Clases y Salida
-- ===================================================================

-- ===========================
-- JULIA JASMIN ARANA LLANES
-- Materias: Sistemas Operativos, Administracion de Sistemas
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 1, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 1, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 1, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 1, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 1, 8),
-- Sistemas Operativos
('Lunes', '09:00', '11:00', 'Sistemas Operativos', 'Clase', 1, 6),
('Miercoles', '09:00', '11:00', 'Sistemas Operativos', 'Clase', 1, 6),
('Viernes', '09:00', '11:00', 'Sistemas Operativos', 'Laboratorio', 1, 1),
-- Administracion de Sistemas
('Martes', '11:00', '13:00', 'Administracion de Sistemas', 'Clase', 1, 7),
('Jueves', '11:00', '13:00', 'Administracion de Sistemas', 'Laboratorio', 1, 2),
-- Juntas
('Martes', '16:00', '17:00', 'Junta', 'Reunion', 1, 8),
('Jueves', '16:00', '17:00', 'Junta', 'Reunion', 1, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 1, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 1, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 1, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 1, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 1, 8);

-- ===========================
-- GABRIEL SANCHEZ BAUTISTA
-- Materias: Bases de Datos, SQL Avanzado
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 2, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 2, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 2, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 2, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 2, 8),
-- Bases de Datos
('Lunes', '10:00', '12:00', 'Bases de Datos', 'Laboratorio', 2, 3),
('Miercoles', '10:00', '12:00', 'Bases de Datos', 'Clase', 2, 6),
('Viernes', '14:00', '16:00', 'Bases de Datos', 'Laboratorio', 2, 4),
-- SQL Avanzado
('Martes', '14:00', '16:00', 'SQL Avanzado', 'Clase', 2, 7),
('Jueves', '14:00', '16:00', 'SQL Avanzado', 'Laboratorio', 2, 5),
-- Juntas
('Martes', '16:00', '17:00', 'Junta', 'Reunion', 2, 8),
('Jueves', '16:00', '17:00', 'Junta', 'Reunion', 2, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 2, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 2, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 2, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 2, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 2, 8);

-- ===========================
-- ISMAEL DOMINGUEZ JIMENEZ
-- Materias: Redes de Computadoras, Seguridad Informatica
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 3, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 3, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 3, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 3, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 3, 8),
-- Redes de Computadoras
('Lunes', '13:00', '15:00', 'Redes de Computadoras', 'Clase', 3, 7),
('Miercoles', '13:00', '15:00', 'Redes de Computadoras', 'Laboratorio', 3, 4),
('Viernes', '10:00', '12:00', 'Redes de Computadoras', 'Clase', 3, 6),
-- Seguridad Informatica
('Martes', '13:00', '15:00', 'Seguridad Informatica', 'Clase', 3, 7),
('Jueves', '13:00', '15:00', 'Seguridad Informatica', 'Laboratorio', 3, 1),
-- Juntas
('Martes', '16:00', '17:00', 'Junta', 'Reunion', 3, 8),
('Jueves', '16:00', '17:00', 'Junta', 'Reunion', 3, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 3, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 3, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 3, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 3, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 3, 8);

-- ===========================
-- MONICA CORNEJO
-- Materias: Programacion Web, Diseno de Interfaces Web
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 4, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 4, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 4, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 4, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 4, 8),
-- Programacion Web
('Lunes', '11:00', '13:00', 'Programacion Web', 'Clase', 4, 7),
('Miercoles', '11:00', '13:00', 'Programacion Web', 'Laboratorio', 4, 5),
('Viernes', '11:00', '13:00', 'Programacion Web', 'Clase', 4, 7),
-- Diseno de Interfaces Web
('Martes', '15:00', '17:00', 'Diseno de Interfaces Web', 'Laboratorio', 4, 4),
('Jueves', '15:00', '17:00', 'Diseno de Interfaces Web', 'Clase', 4, 6),
-- Juntas
('Lunes', '16:00', '17:00', 'Junta', 'Reunion', 4, 8),
('Miercoles', '16:00', '17:00', 'Junta', 'Reunion', 4, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 4, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 4, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 4, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 4, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 4, 8);

-- ===========================
-- MONICA GARCIA MUNGUIA
-- Materias: Seguridad en Redes, Administracion de Redes
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 5, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 5, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 5, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 5, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 5, 8),
-- Seguridad en Redes
('Lunes', '10:00', '12:00', 'Seguridad en Redes', 'Clase', 5, 6),
('Miercoles', '10:00', '12:00', 'Seguridad en Redes', 'Laboratorio', 5, 4),
('Viernes', '11:00', '13:00', 'Seguridad en Redes', 'Clase', 5, 7),
-- Administracion de Redes
('Martes', '13:00', '15:00', 'Administracion de Redes', 'Clase', 5, 7),
('Jueves', '13:00', '15:00', 'Administracion de Redes', 'Laboratorio', 5, 3),
-- Juntas
('Lunes', '16:00', '17:00', 'Junta', 'Reunion', 5, 8),
('Miercoles', '16:00', '17:00', 'Junta', 'Reunion', 5, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 5, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 5, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 5, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 5, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 5, 8);

-- ===========================
-- TOMAS LEON QUINTANAR
-- Materias: Ingenieria de Software, Gestion de Proyectos
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 6, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 6, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 6, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 6, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 6, 8),
-- Ingenieria de Software
('Lunes', '09:00', '11:00', 'Ingenieria de Software', 'Clase', 6, 11),
('Miercoles', '09:00', '11:00', 'Ingenieria de Software', 'Clase', 6, 11),
('Viernes', '14:00', '16:00', 'Ingenieria de Software', 'Laboratorio', 6, 2),
-- Gestion de Proyectos
('Martes', '14:00', '16:00', 'Gestion de Proyectos', 'Clase', 6, 6),
('Jueves', '09:00', '11:00', 'Gestion de Proyectos', 'Clase', 6, 7),
-- Juntas
('Lunes', '16:00', '17:00', 'Junta', 'Reunion', 6, 8),
('Miercoles', '16:00', '17:00', 'Junta', 'Reunion', 6, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 6, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 6, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 6, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 6, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 6, 8);

-- ===========================
-- GUSTAVO PADRON RIVERA
-- Materias: Arquitectura de Software, Calidad de Software
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 7, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 7, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 7, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 7, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 7, 8),
-- Arquitectura de Software
('Martes', '10:00', '12:00', 'Arquitectura de Software', 'Clase', 7, 11),
('Jueves', '10:00', '12:00', 'Arquitectura de Software', 'Laboratorio', 7, 3),
('Viernes', '15:00', '17:00', 'Arquitectura de Software', 'Clase', 7, 7),
-- Calidad de Software
('Lunes', '14:00', '16:00', 'Calidad de Software', 'Clase', 7, 6),
('Miercoles', '14:00', '16:00', 'Calidad de Software', 'Laboratorio', 7, 2),
-- Juntas
('Martes', '16:00', '17:00', 'Junta', 'Reunion', 7, 8),
('Jueves', '16:00', '17:00', 'Junta', 'Reunion', 7, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 7, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 7, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 7, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 7, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 7, 8);

-- ===========================
-- OLIVIA PLACENCIA RAMIREZ
-- Materia UNICA: English (de lunes a viernes con tiempos frecuentes)
-- ===========================
INSERT INTO horarios (dia_semana, hora_inicio, hora_fin, materia, tipo_actividad, profesor_id, aula_id) VALUES
-- Entrada
('Lunes', '08:00', '08:30', 'Disponible', 'Disponible', 8, 8),
('Martes', '08:00', '08:30', 'Disponible', 'Disponible', 8, 8),
('Miercoles', '08:00', '08:30', 'Disponible', 'Disponible', 8, 8),
('Jueves', '08:00', '08:30', 'Disponible', 'Disponible', 8, 8),
('Viernes', '08:00', '08:30', 'Disponible', 'Disponible', 8, 8),
-- English - Tiempos frecuentes durante toda la semana
('Lunes', '09:00', '10:00', 'English', 'Clase', 8, 6),
('Lunes', '11:00', '12:00', 'English', 'Clase', 8, 6),
('Lunes', '14:00', '15:00', 'English', 'Clase', 8, 6),
('Martes', '09:00', '10:00', 'English', 'Clase', 8, 7),
('Martes', '11:00', '12:30', 'English', 'Clase', 8, 7),
('Martes', '15:00', '16:30', 'English', 'Clase', 8, 7),
('Miercoles', '10:00', '11:00', 'English', 'Clase', 8, 6),
('Miercoles', '12:00', '13:00', 'English', 'Clase', 8, 6),
('Miercoles', '15:00', '16:00', 'English', 'Clase', 8, 6),
('Jueves', '09:30', '10:30', 'English', 'Clase', 8, 7),
('Jueves', '11:00', '12:00', 'English', 'Clase', 8, 7),
('Jueves', '14:00', '15:30', 'English', 'Clase', 8, 7),
('Viernes', '09:00', '10:00', 'English', 'Clase', 8, 6),
('Viernes', '10:30', '11:30', 'English', 'Clase', 8, 6),
('Viernes', '14:00', '15:30', 'English', 'Clase', 8, 6),
-- Juntas
('Martes', '16:00', '17:00', 'Junta', 'Reunion', 8, 8),
('Jueves', '16:00', '17:00', 'Junta', 'Reunion', 8, 8),
-- Salida
('Lunes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 8, 8),
('Martes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 8, 8),
('Miercoles', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 8, 8),
('Jueves', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 8, 8),
('Viernes', '17:30', '18:00', 'Fuera del campus', 'Fuera del campus', 8, 8);

-- ===================================================================
-- VERIFICAR DATOS INSERTADOS
-- ===================================================================
SELECT COUNT(*) as total_aulas FROM aulas;
SELECT COUNT(*) as total_profesores FROM profesores;
SELECT COUNT(*) as total_horarios FROM horarios;