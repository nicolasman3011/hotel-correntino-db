# Etapa 4: Consultas y Casos de Uso

En esta etapa se desarrollaron sentencias DQL (Data Query Language) utilizando `SELECT` y `JOIN` para extraer información estratégica para el Hotel Correntino.

### Caso de Uso 1: Comprobante de Venta
* **Objetivo:** Generar el detalle completo de una reserva específica para entregar al huésped al momento del check-out.
* **Script:** `sql/consultas/comprobante_venta.sql`

### Caso de Uso 2: Informe de Recaudación
* **Objetivo:** Calcular el total de dinero ingresado al hotel agrupado por forma de pago.
* **Script:** `sql/consultas/informe_ventas.sql`

### Caso de Uso 3: Consulta Avanzada (Ocupación)
* **Objetivo:** Mostrar qué categorías de habitaciones son las más solicitadas por los clientes.
* **Script:** `sql/consultas/consulta_avanzada.sql`

### Caso de Uso 4:reserva de un huesped
* **Objetivo:** Mostrar la reserva por el id de un huesped.
* **Script:** `sql/consultas/reserva_por_huesped.sql`

### Caso de Uso 5:comprobacion de estado de habitcaciones
* **Objetivo:** Mostrar todas las habitaciones en estado desocupado.
* **Script:** `sql/consultas/habitaciones_disponibles.sql`

* ### Caso de Uso 6:habitcaciones ocupadas
* **Objetivo:** Mostrar todas las habitaciones las cuales estan ocupadas.
* **Script:** `sql/consultas/habitaciones_hoy.sql`
