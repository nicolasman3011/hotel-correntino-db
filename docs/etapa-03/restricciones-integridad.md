# Restricciones de Integridad Aplicadas

Para garantizar la consistencia de los datos del Hotel Correntino, se implementaron las siguientes restricciones a nivel de base de datos:

1. **Integridad de Entidad (PRIMARY KEY):** Todas las tablas cuentan con su clave primaria. En el caso de `Detalle_Reserva`, se utilizó una clave primaria compuesta (`id_reserva`, `numero`) para identificar unívocamente qué habitación pertenece a qué reserva.
2. **Integridad Referencial (FOREIGN KEY):** Se establecieron restricciones lógicas entre tablas para evitar registros huérfanos. Por ejemplo, no se puede crear un `Huesped` si su `id_persona` no existe previamente en la tabla `Persona`.
3. **Restricciones de Dominio (NOT NULL):** Se forzó la obligatoriedad de campos críticos, como `precio` en `Habitacion` o `fecha_ingreso` en `Detalle_Reserva`, evitando valores nulos que rompan la lógica del negocio.
