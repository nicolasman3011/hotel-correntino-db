# Etapa 5: Procedimientos y Funciones Almacenadas

En esta etapa se implementaron mecanismos avanzados en el motor de base de datos para encapsular la lógica del negocio, garantizando que el sistema del Hotel Correntino sea más robusto, seguro y fácil de mantener a largo plazo. 

Siguiendo la estructura del proyecto, se detallan a continuación los componentes desarrollados para automatizar operaciones repetitivas y cálculos centrales.

### Tema Técnico 1: Función Definida por el Usuario
**Mecanismo:** `CalcularCostoEstadia`
*   **Para qué se utiliza:** Calcula de forma automática el costo total de una estadía. Recibe como parámetros las fechas de ingreso y egreso, el precio por noche de la habitación y un porcentaje de descuento, retornando el monto neto a cobrar.
*   **Por qué fue elegido:** Se implementó para favorecer la modularidad. Al encapsular la lógica matemática de las tarifas en una función reutilizable, si en el futuro cambian las reglas comerciales (ej. nuevos impuestos o fórmulas de descuento), solo se modifica este fragmento de código sin alterar los demás procesos del sistema.
*   **Cómo se integra al sistema:** Se puede invocar tanto desde consultas `SELECT` para simulaciones de precios, como desde procedimientos almacenados al momento de registrar facturas o pagos.
*   **Cómo se demuestra su funcionamiento:** Ejecutando una consulta escalar que le pase fechas y precios de prueba, verificando que el retorno matemático aplique correctamente los días contabilizados y el descuento.
*   **Script:** `sql/tecnico/funciones/calcular_costo_estadia.sql`

### Tema Técnico 2: Procedimiento Almacenado
**Mecanismo:** `RegistrarReservaHotel`
*   **Para qué se utiliza:** Gestiona el ciclo completo de alta de una reserva. Valida la disponibilidad, inserta el encabezado en la tabla `Reserva`, inserta las fechas en `Detalle_Reserva` y actualiza el estado de la `Habitacion` a "reservada".
*   **Por qué fue elegido:** Se eligió para garantizar el rendimiento, la seguridad y la consistencia de los datos. Al ser un conjunto de instrucciones precompiladas, evita que un usuario o aplicación externa modifique las tablas de forma directa o deje una reserva a medias (por ejemplo, insertando la cabecera pero olvidando actualizar el estado de la habitación). Además, concentra validaciones críticas mediante bloqueos lógicos (`THROW`) para evitar el *overbooking* (solapamiento de fechas).
*   **Cómo se integra al sistema:** Actúa como la operación transaccional principal que consumirá la interfaz del recepcionista cada vez que ingrese un nuevo cliente al hotel.
*   **Cómo se demuestra su funcionamiento:** Mediante dos pruebas de ejecución (`EXEC`). Un caso exitoso con fechas disponibles (verificando la inserción en las 3 tablas involucradas) y un caso fallido intentando registrar un cliente en fechas que se solapan con una reserva existente, esperando que el motor aborte la operación y devuelva el mensaje de error programado.
*   **Script:** `sql/tecnico/procedimientos/registrar_reserva_hotel.sql`
* **Objetivo:** Mostrar todas las habitaciones en estado desocupado.
* **Script:** `sql/consultas/habitaciones_disponibles.sql`

* ### Caso de Uso 6:habitcaciones ocupadas
* **Objetivo:** Mostrar todas las habitaciones las cuales estan ocupadas.
* **Script:** `sql/consultas/habitaciones_hoy.sql`
