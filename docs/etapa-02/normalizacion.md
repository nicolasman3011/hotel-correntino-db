# Proceso de Normalización
Apartado de 3 FN 

1FN: 

Regla: Todos los valores deben ser atómicos (indivisibles) y no deben existir grupos repetitivos (múltiples datos del mismo tipo en un solo campo o columnas repetidas  

En nuestra tabla relacional se cumple ya que cada celda de cada tabla contiene un solo dato simple (un solo email, un solo precio, una sola nacionalidad). 

Y no hay listas separadas por comas. Si una reserva tiene 3 habitaciones, no se guardan en la tabla Reserva como "Habitación 101, 102, 103", sino que se crean 3 filas separadas en la tabla Detalle_Reserva. 

 

2FN: 

Regla: Cumplir la 1FN y que ningún atributo no clave dependa de forma parcial de una clave primaria compuesta. Todos los atributos deben depender de la clave completa. 

Cumplimos esta normalizacion ya que las tablas con clave simple de un solo atributo (Persona, Empleado, Habitacion, Pago, etc.) cumplen 2FN automáticamente. 

 

En la tabla Detalle_Reserva, la clave primaria es compuesta: (id_reserva, numero). 

 

3FN: 

Regla: Cumplir la 2FN y que no existan dependencias transitivas (es decir, que un atributo no clave dependa de otro atributo no clave). Todo dato debe depender únicamente de la clave primaria. 

Herencia Persona / Empleado / Huesped: Se aisló la información personal en Persona. Así, cargo y sueldo (de Empleado) o nacionalidad (de Huesped) no generan duplicación de datos de contacto. 

Ademas  en “Tabla Localidad” los datos de ubicación geográfica no están dentro de la tabla Persona. Esto es distinto al diagrama relacional ya que decidimos cambiarlo para tener mas datos a cerca de desde donde vienen las personas al hotel. Y asi tener mas informacion q se puede utilizar en publicidad o lo que crea pertinente el usuario de la base de datos. 

 

 
