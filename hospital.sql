-- TABLAS
CREATE TABLE DEPARTAMENTO (id_depto VARCHAR(5) PRIMARY KEY, nombre_depto VARCHAR(50), presupuesto NUMERIC, edificio CHAR(1));
CREATE TABLE MEDICO (id_med VARCHAR(5) PRIMARY KEY, nombre VARCHAR(100), especialidad VARCHAR(50), id_depto VARCHAR(5) REFERENCES DEPARTAMENTO(id_depto));
CREATE TABLE PACIENTE (id_pac VARCHAR(5) PRIMARY KEY, nombre VARCHAR(100), edad INTEGER, ciudad VARCHAR(50));
CREATE TABLE CONSULTA (id_con SERIAL PRIMARY KEY, id_pac VARCHAR(5) REFERENCES PACIENTE(id_pac), id_med VARCHAR(5) REFERENCES MEDICO(id_med), fecha DATE, costo NUMERIC);
CREATE TABLE MEDICAMENTO (id_medicamento VARCHAR(5) PRIMARY KEY, nombre_comercial VARCHAR(50), tipo VARCHAR(30), precio NUMERIC);
CREATE TABLE RECETA (id_rec SERIAL PRIMARY KEY, id_con INTEGER REFERENCES CONSULTA(id_con), id_medicamento VARCHAR(5) REFERENCES MEDICAMENTO(id_medicamento), dosis VARCHAR(100));
CREATE TABLE ENFERMERO (id_enf VARCHAR(5) PRIMARY KEY, nombre VARCHAR(100), turno VARCHAR(20), id_depto VARCHAR(5) REFERENCES DEPARTAMENTO(id_depto));
CREATE TABLE EQUIPAMIENTO (id_equipo VARCHAR(5) PRIMARY KEY, nombre_equipo VARCHAR(50), estado VARCHAR(20), id_depto VARCHAR(5) REFERENCES DEPARTAMENTO(id_depto));

-- 1. Departamentos (5)
INSERT INTO DEPARTAMENTO VALUES
 ('D1','Urgencias',800000,'A'), ('D2','Pediatria',400000,'B'), ('D3','Cardio',900000,'C'), 
 ('D4','Gineco',350000,'A'), ('D5','Onco',1200000,'D');


-- 2. Médicos (10 total)
INSERT INTO MEDICO VALUES 
('M1','Dr. House','Diagnostico','D1'), ('M2','Dr. Strange','Cirugia','D3'), ('M3','Dra. Grey','General','D2'), ('M4','Dr. Ross','Pediatria','D2'), ('M5','Dra. Cuddy','Endocrino','D1'),
('M6','Dr. Wilson','Onco','D5'), ('M7','Dra. Cameron','Urgencias','D1'),
('M8','Dr. Chase','Cardio','D3'), ('M9','Dr. Foreman','Diagnostico','D1'),
('M10','Dra. Yang','Cirugia','D3');

-- 3. Pacientes (25 total)
INSERT INTO PACIENTE VALUES 
('P1','Juan Perez',45,'CDMX'), ('P2','Maria Garcia',12,'Guadalajara'),
('P3','Luis Rodriguez',67,'Monterrey'), ('P4','Ana Martinez',34,'CDMX'),
('P5','Jose Hernandez',28,'Cancun'), ('P6','Rosa Lopez',55,'Puebla'),
('P7','Carlos Gonzalez',19,'CDMX'), ('P8','Elena Perez',41,'Guadalajara'),
('P9','Miguel Angel',33,'Monterrey'), ('P10','Sofia Castro',25,'CDMX'),
('P11','Diego Ruiz',72,'Toluca'), ('P12','Carmen Diaz',48,'CDMX'),
('P13','Raul Silva',38,'Leon'), ('P14','Laura Mejia',22,'Cancun'),
('P15','Jorge Ortega',50,'CDMX'), ('P16','Martha Rojas',61,'Puebla'),
('P17','Oscar Torres',29,'Guadalajara'), ('P18','Alicia Vera',15,'Monterrey'),
('P19','Hugo Lara',44,'CDMX'), ('P20','Ximena Solis',31,'Toluca'),
('P21','Ivan Bravo',37,'CDMX'), ('P22','Paola Rios',26,'Guadalajara'),
('P23','Rene Nava',59,'Monterrey'), ('P24','Sonia Luna',43,'Cancun'),
('P25','Felipe Cruz',20,'CDMX');

-- 4. Consultas (25 total)
INSERT INTO CONSULTA (id_pac, id_med, fecha, costo) VALUES 
('P1','M1','2025-01-10',1500), ('P2','M4','2025-01-11',800),
('P3','M2','2025-01-12',2500), ('P4','M5','2025-01-12',1200),
('P5','M1','2025-01-13',1500), ('P6','M6','2025-01-14',3000),
('P7','M7','2025-01-15',1100), ('P8','M3','2025-01-16',900),
('P9','M8','2025-01-17',2000), ('P10','M9','2025-01-18',1800),
('P11','M1','2025-01-19',1500), ('P12','M2','2025-01-20',2500),
('P13','M10','2025-01-21',4000), ('P14','M4','2025-01-22',800),
('P15','M1','2025-01-23',1500), ('P16','M6','2025-01-24',3000),
('P17','M8','2025-01-25',2000), ('P18','M3','2025-01-26',900),
('P19','M5','2025-01-27',1200), ('P20','M7','2025-01-28',1100),
('P21','M9','2025-01-29',1800), ('P22','M2','2025-01-30',2500),
('P23','M8','2025-01-31',2000), ('P24','M10','2025-02-01',4000),
('P25','M4','2025-02-02',800);

-- 5. Medicamentos (15 total)
INSERT INTO MEDICAMENTO VALUES 
('MD1','Paracetamol','Analgesico',50), ('MD2','Amoxicilina','Antibiotico',120),
('MD3','Ibuprofeno','Antiinflamatorio',85), ('MD4','Insulina','Hormona',450),
('MD5','Metformina','Antidiabetico',200), ('MD6','Omeprazol','Protector',95),
('MD7','Losartan','Antihipertensivo',180), ('MD8','Atorvastatina','Colesterol',320),
('MD9','Salbutamol','Broncodilatador',250), ('MD10','Loratadina','Antihistaminico',60),
('MD11','Diclofenaco','Analgesico',75), ('MD12','Azitromicina','Antibiotico',150),
('MD13','Fluoxetina','Antidepresivo',400), ('MD14','Diazepam','Ansiolitico',220),
('MD15','Cetirizina','Antialergico',70);

-- 6. Recetas (15 total)
INSERT INTO RECETA (id_con, id_medicamento, dosis) VALUES 
(1,'MD1','500mg cada 8h'), (2,'MD10','10mg cada 24h'),
(3,'MD11','100mg cada 12h'), (4,'MD5','850mg con comida'),
(5,'MD6','20mg en ayunas'), (6,'MD13','20mg por la mañana'),
(7,'MD2','500mg cada 8h'), (8,'MD3','400mg cada 6h'),
(9,'MD7','50mg cada 24h'), (10,'MD1','500mg cada 8h'),
(11,'MD8','20mg noche'), (12,'MD14','5mg antes de dormir'),
(13,'MD9','2 disparos c/6h'), (14,'MD15','10mg noche'),
(15,'MD4','10 unidades SC');

-- 7. Enfermeros (10 total)
INSERT INTO ENFERMERO VALUES 
('E1','Laura Paz','Matutino','D1'), ('E2','Pedro Nodal','Vespertino','D1'),
('E3','Marta Sanchez','Nocturno','D2'), ('E4','Julia Dominguez','Matutino','D2'),
('E5','Roberto Solis','Vespertino','D3'), ('E6','Elena Cano','Nocturno','D3'),
('E7','Francisco Gil','Matutino','D4'), ('E8','Lucia Mendez','Vespertino','D4'),
('E9','Daniela Soto','Nocturno','D5'), ('E10','Kevin Ruiz','Matutino','D5');

-- 8. Equipamiento (10 total)
INSERT INTO EQUIPAMIENTO VALUES 
('EQ1','Desfibrilador','Operativo','D1'), ('EQ2','Monitor Signos','Operativo','D1'),
('EQ3','Incubadora','Mantenimiento','D2'), ('EQ4','Balanza Ped','Operativo','D2'),
('EQ5','Electrocardiografo','Operativo','D3'), ('EQ6','Eco-Doppler','Operativo','D3'),
('EQ7','Ecografo 4D','Mantenimiento','D4'), ('EQ8','Monitor Fetal','Operativo','D4'),
('EQ9','Acelerador Lineal','Operativo','D5'), ('EQ10','Bomba Infusion','Operativo','D5');
