# Practica_Bases_Datos_Hospital

**Integrantes:** 
González Hernández Judith,  
Magaña Fierro Elka Natalia

**Introducción:** 
Este proyecto implementa un sistema integral de gestión hospitalaria diseñado para administrar la interacción entre pacientes, personal médico, departamentos y tratamientos. El esquema permite realizar un seguimiento detallado desde la asignación de médicos a departamentos hasta la prescripción de medicamentos tras una consulta.

2. Modelo Relacional
El esquema consta de 8 relaciones interconectadas con más de 100 tuplas para garantizar la integridad y complejidad de las consultas.


<img width="1007" height="643" alt="image" src="https://github.com/user-attachments/assets/76167e35-d831-4081-9ce2-34ad9a8a271f" />

###  Diccionario de Variables (Dominios)
Para las expresiones de Cálculo Relacional de Dominios (CRD), se definen las siguientes variables siguiendo el orden de los atributos en el esquema relacional:

* **PACIENTE (PAC):** $\langle i, n, e, c \rangle$  
    *(id_pac, nombre, edad, ciudad)*
* **MEDICO (MED):** $\langle i, n, s, d \rangle$  
    *(id_med, nombre, especialidad, id_depto)*
* **DEPARTAMENTO (DEP):** $\langle i, n, p, e \rangle$  
    *(id_depto, nombre_depto, presupuesto, edificio)*
* **CONSULTA (CON):** $\langle i, p, m, f, c \rangle$  
    *(id_con, id_pac, id_med, fecha, costo)*
* **MEDICAMENTO (MDK):** $\langle i, n, t, p \rangle$  
    *(id_medicamento, nombre_comercial, tipo, precio)*
* **RECETA (REC):** $\langle i, c, m, d \rangle$  
    *(id_rec, id_con, id_medicamento, dosis)*
* **ENFERMERO (ENF):** $\langle i, n, t, d \rangle$  
    *(id_enf, nombre, turno, id_depto)*
* **EQUIPAMIENTO (EQU):** $\langle i, n, e, d \rangle$  
    *(id_equi, nombre_equipo, estado, id_depto)*


## Consultas de Equivalencia (20 Casos)

### Bloque 1: Operadores Básicos (5 Consultas)
| # | Descripción | Álgebra Relacional (AR) | SQL |
|:--|:---|:---|:---|
| 1 | Pacientes de la ciudad 'CDMX' | σ ciudad='CDMX' (PACIENTE) | `SELECT * FROM PACIENTE WHERE ciudad='CDMX';` |
| 2 | Solo nombres de los médicos | π nombre (MEDICO) | `SELECT nombre FROM MEDICO;` |
| 3 | Medicamentos con precio > 100 | σ precio > 100 (MEDICAMENTO) | `SELECT * FROM MEDICAMENTO WHERE precio > 100;` |
| 4 | Departamentos en edificio 'A' | π nombre_depto (σ edificio='A' (DEPARTAMENTO)) | `SELECT nombre_depto FROM DEPARTAMENTO WHERE edificio='A';` |
| 5 | Pacientes menores de edad | σ edad < 18 (PACIENTE) | `SELECT * FROM PACIENTE WHERE edad < 18;` |

### Bloque 2: Reuniones / Joins (5 Consultas)
| # | Descripción | Cálculo Relacional de Tuplas (CRT) | SQL |
|:--|:---|:---|:---|
| 6 | Médico y su Departamento | { t.nombre, u.nombre_depto | t ∈ MED ∧ u ∈ DEP ∧ t.id_depto = u.id_depto } | `SELECT M.nombre, D.nombre_depto FROM MEDICO M JOIN DEPARTAMENTO D ON M.id_depto = D.id_depto;` |
| 7 | Consultas por Paciente | { t.id_con, u.nombre | t ∈ CON ∧ u ∈ PAC ∧ t.id_pac = u.id_pac } | `SELECT C.id_con, P.nombre FROM CONSULTA C JOIN PACIENTE P ON C.id_pac = P.id_pac;` |
| 8 | Turno de Enfermeros | { t.nombre, t.turno, u.nombre_depto | t ∈ ENF ∧ u ∈ DEP ∧ t.id_depto = u.id_depto } | `SELECT E.nombre, E.turno, D.nombre_depto FROM ENFERMERO E JOIN DEPARTAMENTO D ON E.id_depto = D.id_depto;` |
| 9 | Equipos en Urgencias | { t.nombre_equipo | t ∈ EQU ∧ ∃u ∈ DEP (u.id_depto = t.id_depto ∧ u.nombre_depto = 'Urgencias') } | `SELECT nombre_equipo FROM EQUIPAMIENTO E JOIN DEPARTAMENTO D ON E.id_depto = D.id_depto WHERE D.nombre_depto = 'Urgencias';` |
| 10 | Fármacos por Receta | { t.id_rec, u.nombre_comercial | t ∈ REC ∧ u ∈ MDK ∧ t.id_med = u.id_med } | `SELECT R.id_rec, M.nombre_comercial FROM RECETA R JOIN MEDICAMENTO M ON R.id_medicamento = M.id_medicamento;` |

### Bloque 3: Agregación y Agrupación (5 Consultas)
| # | Descripción | Cálculo Relacional de Dominios (CRD) | SQL |
|:--|:---|:---|:---|
| 11 | Presupuesto por Edificio | { <e, SUM(p)> | ∃i, n (<i,n,p,e> ∈ DEP) } | `SELECT edificio, SUM(presupuesto) FROM DEPARTAMENTO GROUP BY edificio;` |
| 12 | Promedio de edad total | { <AVG(e)> | ∃i, n, c (<i,n,e,c> ∈ PAC) } | `SELECT AVG(edad) FROM PACIENTE;` |
| 13 | Cantidad de Citas por Med | { <m, COUNT(i)> | ∃p, f, c (<i,p,m,f,c> ∈ CON) } | `SELECT id_med, COUNT(*) FROM CONSULTA GROUP BY id_med;` |
| 14 | Precio Máximo Fármaco | { <MAX(p)> | ∃i, n, t (<i,n,t,p> ∈ MDK) } | `SELECT MAX(precio) FROM MEDICAMENTO;` |
| 15 | Costo Total Consultas | { <SUM(c)> | ∃i, p, m, f (<i,p,m,f,c> ∈ CON) } | `SELECT SUM(costo) FROM CONSULTA;` |

### Bloque 4: División y Cuantificadores (5 Consultas)
| # | Tipo | Descripción | SQL |
|:--|:---|:---|:---|
| 16 | División | Pacientes atendidos por TODOS los médicos de Diagnóstico | `SELECT id_pac FROM PACIENTE P WHERE NOT EXISTS (SELECT id_med FROM MEDICO WHERE especialidad='Diagnostico' EXCEPT SELECT id_med FROM CONSULTA C WHERE C.id_pac = P.id_pac);` |
| 17 | División | Médicos que recetaron TODOS los 'Analgesicos' | `SELECT id_med FROM MEDICO M WHERE NOT EXISTS (SELECT id_medicamento FROM MEDICAMENTO WHERE tipo='Analgesico' EXCEPT SELECT id_medicamento FROM RECETA R JOIN CONSULTA C ON R.id_con = C.id_con WHERE C.id_med = M.id_med);` |
| 18 | División | Deptos con TODOS sus equipos en estado 'Operativo' | `SELECT id_depto FROM DEPARTAMENTO D WHERE NOT EXISTS (SELECT estado FROM EQUIPAMIENTO WHERE estado='Operativo' EXCEPT SELECT estado FROM EQUIPAMIENTO E WHERE E.id_depto = D.id_depto);` |
| 19 | Universal | Médicos con sueldo mayor al promedio de todos los médicos | `SELECT nombre FROM MEDICO WHERE id_med IN (SELECT id_med FROM MEDICO WHERE salario > (SELECT AVG(salario) FROM MEDICO));` |
| 20 | Universal | Medicamentos con precio superior a la media | `SELECT nombre_comercial FROM MEDICAMENTO WHERE precio > (SELECT AVG(precio) FROM MEDICAMENTO);` |

---
##  4. Instalación y Ejecución

Siga estos pasos para desplegar el entorno de base de datos y cargar el sistema hospitalario:

### **Paso 1: Clonar el Repositorio**
Primero, obtenga una copia local del proyecto:

git clone [https://github.com/tu-usuario/Practica_Bases_Datos_Hospital.git](https://github.com/tu-usuario/Practica_Bases_Datos_Hospital.git)
cd Practica_Bases_Datos_Hospital

### **Paso 2: Levantar el Contenedor de Base de Datos**

Utilice Docker para desplegar una instancia de PostgreSQL:

docker run --name practica_db -e POSTGRES_PASSWORD=tu_clave -d postgres

### **Paso 3: Cargar Esquema y Datos**
Copiar el archivo:
docker cp hospital.sql practica_db:/hospital.sql
Ejecutar script:
docker exec -it practica_db psql -U postgres -f /hospital.sql


Nota sobre Seguridad: Todas las consultas de cálculo relacional (CRT/CRD) presentadas han sido diseñadas como expresiones seguras, garantizando resultados finitos al restringir las variables de tupla y dominio a los dominios activos de las relaciones del hospital.

## Verificación de Carga
Para verificar que las 100+ tuplas se cargaron correctamente, ejecute:
```sql
SELECT table_name, row_count 
FROM (SELECT 'PACIENTE' as table_name, COUNT(*) as row_count FROM PACIENTE
      UNION SELECT 'MEDICO', COUNT(*) FROM MEDICO
      UNION SELECT 'DEPARTAMENTO', COUNT(*) FROM DEPARTAMENTO
      UNION SELECT 'CONSULTA', COUNT(*) FROM CONSULTA
      UNION SELECT 'MEDICAMENTO', COUNT(*) FROM MEDICAMENTO
      UNION SELECT 'RECETA', COUNT(*) FROM RECETA
      UNION SELECT 'ENFERMERO', COUNT(*) FROM ENFERMERO
      UNION SELECT 'EQUIPAMIENTO', COUNT(*) FROM EQUIPAMIENTO) AS resumen;
