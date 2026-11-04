# Índices y Optimización de Consultas - Hotel Correntino

## 1. Introducción y Objetivos
La optimización del rendimiento en bases de datos relacionales es fundamental para garantizar tiempos de respuesta eficientes, especialmente a medida que crece el volumen de transacciones y registros en el sistema del **Hotel Correntino**. El uso estratégico de índices permite acelerar las operaciones de recuperación de datos sin alterar la lógica de las consultas.

---

## 2. Estrategia de Indexación
Para mejorar el rendimiento de las consultas más frecuentes (como búsquedas de habitaciones disponibles por fechas o filtrado de huéspedes por DNI), se implementaron los siguientes tipos de índices:
- **Índices Agrupados (*Clustered Index*):** Definen el orden físico de almacenamiento de las filas en la tabla, optimizando las búsquedas por rangos (por ejemplo, fechas de reservas).
- **Índices No Agrupados (*Non-Clustered Index*):** Crean una estructura de almacenamiento separada que apunta a los datos originales, ideales para acelerar columnas de búsqueda frecuente como el DNI del huésped o el estado de la habitación.

---

## 3. Análisis y Buenas Prácticas de Rendimiento
- **Evitar *Scans* innecesarios:** Se diseñaron las consultas y los índices para promover *Index Seeks* en lugar de escaneos completos de tablas (*Table Scans*).
- **Mantenimiento:** Monitoreo del uso de índices para evitar sobrecargas de almacenamiento y penalizaciones en las operaciones de escritura (`INSERT`, `UPDATE`, `DELETE`).

---

## 4. Evidencia Técnica y Scripts
El código SQL ejecutable con los scripts de creación de índices y las pruebas de optimización se encuentra disponible en el repositorio:
- **Enlace al script:** [Repositorio Hotel Correntino - Índices y Optimización](https://github.com/nicolasman3011/hotel-correntino-db/tree/main/sql/tecnico/indices)
