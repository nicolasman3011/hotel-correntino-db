# 🏨 Hotel Correntino
**Sistema de gestión integral para un hotel de la ciudad de Corrientes**

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)
![Markdown](https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)

**Universidad Nacional del Nordeste (UNNE)** — **FaCENA**  
**Base de Datos I — Proyecto Integrador 2026**  
**Equipo 23**

---

## 📑 Índice
1. [Presentación del proyecto](#1-presentación-del-proyecto)
2. [Problemática y solución propuesta](#2-problemática-y-solución-propuesta)
3. [Objetivos del proyecto](#3-objetivos-del-proyecto)
4. [Alcance del sistema](#4-alcance-del-sistema)
5. [Diseño y modelado de la base de datos](#5-diseño-y-modelado-de-la-base-de-datos)
6. [Reglas de negocio](#6-reglas-de-negocio)
7. [Documentación por etapas](#7-documentación-por-etapas)
8. [Estructura del repositorio](#8-estructura-del-repositorio)
9. [Implementación en SQL Server](#9-implementación-en-sql-server)
10. [Consultas SQL y reportes](#10-consultas-sql-y-reportes)
11. [Seguridad y optimización](#11-seguridad-y-optimización)
12. [Tecnologías utilizadas](#12-tecnologías-utilizadas)
13. [Integrantes del equipo](#13-integrantes-del-equipo)
14. [Conclusión](#14-conclusión)
15. [Estado del Proyecto](#-estado-del-proyecto)

---

## 1. Presentación del proyecto
**Hotel Correntino** es un proyecto de base de datos relacional desarrollado para gestionar las operaciones diarias y el control de disponibilidad de un establecimiento hotelero ubicado en la ciudad de Corrientes. 

El sistema fue diseñado como parte de la asignatura Base de Datos I (FaCENA - UNNE) con la finalidad de organizar la información del negocio, automatizar el registro de huéspedes, administrar la disponibilidad de habitaciones y garantizar la consistencia en los procesos de facturación y pagos. Para su desarrollo se utilizó Microsoft SQL Server como sistema gestor de bases de datos.

## 2. Problemática y solución propuesta

### 2.1. Problemática
En la gestión manual o desorganizada de un hotel, pueden presentarse dificultades críticas como:
- *Overbooking* (sobreventa) de habitaciones por falta de actualización de disponibilidad.
- Pérdida de trazabilidad en los estados de limpieza o mantenimiento.
- Inconsistencias entre las reservas registradas y los pagos reales (señas, cancelaciones).
- Dificultad para generar historiales de huéspedes y reportes de ingresos.
- Errores de concurrencia cuando múltiples recepcionistas operan al mismo tiempo.

### 2.2. Solución propuesta
Se propone implementar una base de datos relacional robusta que centralice la operación. Esta solución busca:
- Registrar huéspedes validando identidad única (DNI).
- Controlar estados de habitaciones (Disponible, Ocupada, Reservada, Mantenimiento).
- Administrar el ciclo de vida de la reserva, desde su creación hasta el Check-Out.
- Registrar y auditar pagos, asegurando la integridad transaccional.
- Garantizar la trazabilidad de operaciones críticas mediante triggers y procedimientos almacenados.

## 3. Objetivos del proyecto

**Objetivo general**
Diseñar e implementar una base de datos relacional escalable para la administración integral del Hotel Correntino, aplicando las mejores prácticas de modelado, normalización y programación en bases de datos.

**Objetivos específicos**
- Identificar entidades, relaciones y definir reglas de negocio claras.
- Elaborar el Diagrama Entidad-Relación (DER) y su pasaje al modelo relacional.
- Aplicar la Tercera Forma Normal (3FN) para garantizar la atomicidad y evitar redundancias.
- Implementar la estructura física en SQL Server (DDL, DML, DQL).
- Programar objetos de base de datos (Procedimientos, Funciones, Triggers, Transacciones).
- Analizar estrategias de optimización mediante índices y aplicar políticas de seguridad.

## 4. Alcance del sistema
La base de datos abarca las siguientes áreas del hotel:
- **Huéspedes:** Registro de datos personales, contacto y validación de identidad.
- **Habitaciones:** Categorización, fijación de tarifas, capacidad máxima y control de estado físico.
- **Reservas:** Fechas de Check-In/Check-Out, asignación de habitaciones y estados operativos.
- **Pagos:** Registro de importes, medios de pago y vinculación directa con reservas.
- **Auditoría:** Trazabilidad de cambios de tarifas y operaciones mediante triggers.
- **Seguridad:** Control de permisos estructurado por roles (Administrador, Recepcionista, Auditor).

## 5. Diseño y modelado de la base de datos

### 5.1. Modelo conceptual
Se elaboró un Diagrama Entidad-Relación (DER) definiendo las entidades núcleo (`Huesped`, `Reserva`, `Habitacion`, `Pago`), sus atributos atómicos y cardinalidades, estableciendo las bases de la lógica del negocio.

### 5.2. Modelo relacional
El DER fue transformado en esquemas relacionales, definiendo claves primarias (PK) y foráneas (FK). Se resolvieron las relaciones muchos-a-muchos (ej. Reservas que incluyen múltiples habitaciones) mediante tablas intermedias como `Detalle_Reserva`.

### 5.3. Normalización
La estructura fue sometida a un riguroso proceso de normalización hasta la **Tercera Forma Normal (3FN)**:
- **1FN:** Se eliminaron atributos multivaluados y grupos repetitivos.
- **2FN:** Se resolvieron dependencias funcionales parciales en tablas con claves compuestas.
- **3FN:** Se eliminaron dependencias transitivas (ej. separando códigos postales y localidades en tablas maestras).

## 6. Reglas de negocio
Se definieron 22 reglas restrictivas para el correcto funcionamiento del modelo.

<details>
  <summary><b>Haz clic aquí para ver las 22 Reglas de Negocio</b></summary>
  <br>
  
  1. **R1:** Cada huésped debe estar registrado con un DNI único.
  2. **R2:** Un huésped puede realizar una o varias reservas.
  3. **R3:** Cada reserva debe estar asociada obligatoriamente a un huésped.
  4. **R4:** Cada habitación debe tener un número único.
  5. **R5:** Cada habitación tiene una categoría, precio, y cantidad máxima.
  6. **R6:** Una habitación puede encontrarse disponible, ocupada, reservada o en mantenimiento.
  7. **R7:** Las habitaciones en mantenimiento no pueden ser reservadas.
  8. **R8:** Una habitación no puede tener dos reservas para las mismas fechas.
  9. **R9:** Toda reserva debe tener una fecha de entrada y una fecha de salida.
  10. **R10:** La fecha de salida debe ser posterior a la fecha de entrada.
  11. **R11:** Una reserva puede incluir una o más habitaciones.
  12. **R12:** Cada reserva debe tener un estado: pendiente, confirmada, cancelada o finalizada.
  13. **R13:** Al realizar el check-in se debe registrar la fecha y hora de ingreso.
  14. **R14:** Al realizar el check-out se debe registrar la fecha y hora de salida.
  15. **R15:** El check-out no puede realizarse antes del check-in.
  16. **R16:** Al realizar el check-out, la habitación vuelve a quedar disponible.
  17. **R17:** Cada pago debe registrar un importe, una fecha y un medio de pago.
  18. **R18:** El importe de un pago no puede ser negativo.
  19. **R19:** Una reserva puede tener uno o varios pagos.
  20. **R20:** Los medios de pago pueden ser efectivo, tarjeta o transferencia.
  21. **R21:** Una reserva se considera pagada cuando se abona el total correspondiente.
  22. **R22:** Los empleados del hotel pueden registrar y gestionar las reservas.
</details>

## 7. Documentación por etapas
El proyecto se dividió en entregas incrementales organizadas en la carpeta `docs/`.

- **Etapa 1:** Relevamiento, definición de contexto y reglas de negocio.
- **Etapa 2:** Diseño Conceptual (DER), Modelo Relacional y Normalización.
- **Etapa 3:** Implementación física (DDL) y Poblado de datos (DML).
- **Etapa 4:** Casos de uso de extracción y reportes con DQL.
- **Etapa 5:** Programación en Base de Datos. Implementación de Procedimientos, Funciones, Triggers, Transacciones ACID, control de Seguridad e Índices.
- 
## 8. 📂 Estructura del Repositorio

El proyecto sigue una organización profesional separando la documentación teórica de los scripts ejecutables:

```text
📦 hotel-correntino
 ┣ 📂 docs
 ┃ ┣ 📂 etapa-01
 ┃ ┃ ┣ 📜 alcance.md
 ┃ ┃ ┣ 📜 decisiones-diseno.md
 ┃ ┃ ┣ 📜 descripcion-caso.md
 ┃ ┃ ┗ 📜 reglas-negocio.md
 ┃ ┣ 📂 etapa-02
 ┃ ┃ ┣ 📂 der
 ┃ ┃ ┣ 📜 decisiones-diseno.md
 ┃ ┃ ┣ 📜 modelo-relacional.md
 ┃ ┃ ┣ 📜 normalizacion.md
 ┃ ┃ ┗ 📜 relacional-hotel.png
 ┃ ┣ 📂 etapa-03
 ┃ ┃ ┣ 📜 implementacion.md
 ┃ ┃ ┣ 📜 pruebas-validacion.md
 ┃ ┃ ┗ 📜 restricciones-integridad.md
 ┃ ┣ 📂 etapa-04
 ┃ ┃ ┗ 📜 consultas.md
 ┃ ┗ 📂 etapa-05
 ┃   ┣ 📜 indices-optimizacion.md
 ┃   ┣ 📜 procedimientos-funciones.md
 ┃   ┣ 📜 seguridad.md
 ┃   ┣ 📜 transacciones.md
 ┃   ┗ 📜 trigger_auditoria.md
 ┣ 📂 sql
 ┃ ┣ 📂 consultas
 ┃ ┃ ┣ 📜 comprobante_venta.sql
 ┃ ┃ ┣ 📜 consulta_avanzada.sql
 ┃ ┃ ┣ 📜 habitaciones hoy.sql
 ┃ ┃ ┣ 📜 habitaciones_disponibles.sql
 ┃ ┃ ┣ 📜 informe_ventas.sql
 ┃ ┃ ┗ 📜 reserva_por_huesped.sql
 ┃ ┣ 📂 ddl
 ┃ ┃ ┗ 📜 crear_bd.sql
 ┃ ┣ 📂 dml
 ┃ ┃ ┗ 📜 datos_prueba.sql
 ┃ ┗ 📂 tecnico
 ┃   ┣ 📂 funciones
 ┃   ┃ ┗ 📜 funciones.sql
 ┃   ┣ 📂 indices
 ┃   ┃ ┗ 📜 optimizacion.sql
 ┃   ┣ 📂 procedimientos
 ┃   ┃ ┗ 📜 procedimientos.sql
 ┃   ┣ 📂 seguridad
 ┃   ┃ ┗ 📜 seguridad.sql
 ┃   ┣ 📂 transacciones
 ┃   ┃ ┗ 📜 transaccion.sql
 ┃   ┗ 📂 triggers
 ┃     ┣ 📜 AuditoriaTrigger.sql
 ┃     ┣ 📜 EjecucionTrigger.sql
 ┃     ┗ 📜 Trigger.sql
 ┗ 📜 README.md
```

## 9. Implementación en SQL Server
Se utilizó Microsoft SQL Server y el lenguaje T-SQL. La ejecución física se divide en:
1. `crear_bd.sql`: Define esquemas, tablas, restricciones `CHECK`, claves primarias y foráneas.
2. `datos_prueba.sql`: Inyección masiva de registros base para garantizar la viabilidad de las pruebas y el volumen en los índices.

## 10. Consultas SQL y reportes
En la **Etapa 4** se resolvieron consultas de valor comercial (DQL):
- **Comprobante de Venta/Reserva:** Generación del ticket de estadía (JOINs de reservas, habitaciones y pagos).
- **Consulta Avanzada:** Filtros complejos (uso de `GROUP BY`, `HAVING`) para encontrar clientes frecuentes o deudores.
- **Informe de Ventas:** Reportes de ocupación y proyecciones de ingresos agrupados por categorías de habitación.

## 11. Seguridad y optimización (Etapa 5)

### 11.1. Seguridad
Se crearon roles y usuarios con privilegios limitados según su función:
- **Recepcionista:** Solo puede ejecutar operaciones `INSERT` y `UPDATE` de reservas, sin acceso a borrado de facturación.
- **Auditor:** Permisos de lectura (`SELECT`) exclusivos sobre tablas operativas y de logueo.

### 11.2. Índices y Transacciones
- **Transacciones (ACID):** Se aislaron procesos críticos, como el Check-In, dentro de bloques `BEGIN TRAN ... TRY ... CATCH ... COMMIT/ROLLBACK` para evitar reservas huérfanas en caso de caídas.
- **Índices:** Creación de *Clustered* y *Non-Clustered Indexes* para optimizar búsquedas frecuentes, como el DNI de huéspedes o el filtro de disponibilidad de fechas.
- **Triggers:** Tablas de auditoría en memoria (utilizando `inserted` y `deleted`) para trazar cambios en tarifas o cancelaciones de reservas.

## 12. Tecnologías utilizadas
- **Motor de Base de Datos:** Microsoft SQL Server.
- **Herramienta de Administración:** SQL Server Management Studio (SSMS).
- **Lenguaje:** T-SQL (DDL, DML, DQL, DCL, TCL).
- **Control de Versiones:** Git / GitHub.
- **Documentación:** Markdown.

## 13. Integrantes del equipo
**Grupo 23**  
- Cabrera, Luz Arianna (44.976.967)  
- Luque, Valentin Nicolas (45.845.740)  
- Mancedo, Nicolas Javier (46.715.563)  
- Rodas, Juan Martin (46.363.476)  
- Torres, Enzo Sebastián (45.097.401)  

## 14. Conclusión
El proyecto **Hotel Correntino** evidencia la aplicación integral del ciclo de vida de una base de datos relacional. Desde la abstracción del dominio real y sus problemáticas hasta la implementación de lógicas transaccionales y mecanismos de auditoría en SQL Server, el sistema garantiza el cumplimiento riguroso de las reglas de negocio, protegiendo la integridad y optimizando el acceso a la información crítica del establecimiento.

## 15. ✅ Estado del Proyecto
- ✅ **Etapa 1:** Relevamiento y Reglas de Negocio.
- ✅ **Etapa 2:** Modelo Conceptual (DER) y Modelo Relacional.
- ✅ **Etapa 3:** Implementación Física (DDL y DML).
- ✅ **Etapa 4:** Consultas y Extracción de Datos (DQL).
- ✅ **Etapa 5:** Programación en Base de Datos (Procedimientos, Funciones, Transacciones, Triggers, Seguridad e Índices).
