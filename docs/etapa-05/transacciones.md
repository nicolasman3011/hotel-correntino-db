# 🔄 Módulo de Transacciones - Hotel Correntino

## 1. Introducción y Objetivos
Una transacción en bases de datos es una secuencia de operaciones ejecutadas como una única unidad lógica de trabajo. Para garantizar la integridad de los datos, el sistema debe cumplir estrictamente con las propiedades **ACID** (Atomicidad, Consistencia, Aislamiento y Durabilidad). 

El objetivo principal de implementar transacciones en el sistema del **Hotel Correntino** es asegurar que las operaciones críticas —como la generación de una reserva y la modificación del estado de una habitación— se ejecuten por completo o se reviertan en su totalidad ante cualquier fallo, evitando datos huérfanos o inconsistencias lógicas.

---

## 2. Análisis del Escenario en el Sistema
En el dominio de gestión hotelera, un proceso crítico es el registro de una nueva reserva. Esta operación involucra múltiples tablas de forma secuencial:
1. **Registro de la cabecera de la reserva** en la tabla `Reserva`.
2. **Asociación del detalle** de las fechas y habitaciones solicitadas en la tabla `Detalle_Reserva`.
3. **Actualización del estado** de la infraestructura física en la tabla `Habitacion` (pasando de "Disponible" a "Ocupada" o "Reservada").

Si ocurre un corte de energía, un error de sintaxis o una falla lógica a mitad de este proceso (por ejemplo, se registra la reserva pero la habitación nunca se actualiza a ocupada), el sistema genera una inconsistencia grave. Las transacciones evitan este comportamiento.

---

## 3. Implementación Técnica (`RegistrarReservaHotel`)
El procedimiento almacenado implementado en SQL Server maneja el control de flujo mediante bloques de control de excepciones estructurados:

- **`BEGIN TRANSACTION`**: Marca el punto de inicio a partir del cual todas las modificaciones de datos quedan pendientes de confirmación.
- **`COMMIT TRANSACTION`**: Se ejecuta únicamente si todas las sentencias de inserción y actualización finalizan con éxito, haciendo permanentes los cambios en la base de datos.
- **`ROLLBACK TRANSACTION`**: Se activa dentro del bloque `CATCH` en caso de registrarse cualquier anomalía, deshaciendo todas las operaciones intermedias y restaurando la base de datos a su estado anterior.

---

## 4. Conclusión
La incorporación de bloques transaccionales (`TRY...CATCH` junto a control de transacciones explícitas) dota al sistema del Hotel Correntino de robustez y fiabilidad, garantizando que la concurrencia de múltiples usuarios interactuando con la disponibilidad de las habitaciones no corrompa la información del negocio.