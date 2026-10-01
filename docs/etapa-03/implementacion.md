# Implementación de la Base de Datos

En esta etapa se tradujo el modelo relacional a sentencias DDL (Data Definition Language) para crear la estructura física en SQL Server, y sentencias DML (Data Manipulation Language) para la inserción de datos de prueba.

El código fuente ejecutable se encuentra separado de esta documentación, en la raíz del repositorio:
* **DDL (Creación de tablas):** `/sql/ddl/crear_bd.sql`
* **DML (Datos de prueba):** `/sql/dml/datos_prueba.sql`

Se respetaron las jerarquías de creación: primero las tablas independientes (Localidad, Habitacion, Persona) y luego las tablas dependientes (Huesped, Empleado, Reserva, Pago, Detalle_Reserva) para no violar la integridad referencial.
