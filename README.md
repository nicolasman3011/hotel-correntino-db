# 🏨 Proyecto Base de Datos: Hotel Correntino

**Universidad Nacional del Nordeste (UNNE)**  
**Facultad de Ciencias Exactas y Naturales y Agrimensura (FaCENA)**  
**Cátedra:** Base de datos  

## 👥 Equipo de Trabajo
* Valentín Nicolas Luque (45845740)
* Rodas Juan Martin (46363476)
* Cabrera Luz (44976967)
* Nicolas Javier Mancedo (46715563)
* Torres, Enzo Sebastián (45097401)
---

## 📝 Propuesta
Decidimos trabajar con un hotel de la ciudad de Corrientes que necesita actualizar y mejorar su sistema actual de gestión de reservas. El hotel busca contar con un sistema que permita registrar huéspedes, habitaciones y reservas, facilitando la organización de la información y evitando problemas al momento de gestionar las reservas y la disponibilidad de las habitaciones.

## 🎯 Requerimientos del Sistema
- [x] Registrar huéspedes.
- [x] Registrar habitaciones.
- [x] Registrar reservas.
- [x] Registrar limpieza de habitaciones.
- [x] Registrar check-in y check-out.
- [x] Registrar pagos.
- [x] Corroborar estado de habitaciones.

---

## 📋 Reglas de Negocio

<details>
  <summary><b>Haz clic aquí para ver las 22 Reglas de Negocio</b></summary>

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

---

## 🚀 Hoja de Ruta (Roadmap)
- [x] Definición del proyecto y reglas de negocio.
- [ ] Diseño del Diagrama Entidad-Relación (DER).
- [ ] Creación de scripts DDL (Tablas y restricciones).
- [ ] Creación de scripts DML (Datos de prueba).
- [ ] Consultas SQL y Vistas.
