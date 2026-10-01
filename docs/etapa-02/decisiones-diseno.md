# Decisiones de Diseño - Etapa 2

A partir del pasaje del Modelo Entidad-Relación al Modelo Relacional, el equipo tomó las siguientes decisiones de diseño para garantizar la normalización y eficiencia de la base de datos:

1. **Generalización/Especialización (Herencia):** Se implementó una tabla supertipo `Persona` para centralizar los datos comunes (nombre, apellido, email, teléfono). De esta manera, `Empleado` y `Huesped` actúan como subtipos, heredando la clave primaria y agregando únicamente sus atributos específicos (como el sueldo o la nacionalidad)
2. **Resolución de relación Muchos a Muchos (N:M):** Para vincular las reservas con las habitaciones, se creó la tabla intermedia `Detalle_Reserva` Esto permite que una sola reserva pueda abarcar múltiples habitaciones al mismo tiempo.
3. **Fechas a nivel de Cabecera:** Se decidió ubicar los atributos `fecha_ingreso` y `fecha_Egreso` en la tabla principal `Reserva`. Como regla de negocio, esto significa que todas las habitaciones que pertenezcan a una misma reserva compartirán los mismos días de entrada y salida.
4. **Normalización de Ubicación:** Se extrajo la información geográfica a una tabla independiente llamada `Localidad`, vinculada a `Persona` mediante una clave foránea, para evitar la redundancia de datos (por ejemplo, escribir "Corrientes" múltiples veces).

