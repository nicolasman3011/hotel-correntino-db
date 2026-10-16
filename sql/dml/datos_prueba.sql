-- ==========================================================
-- SCRIPT DE POBLADO DE DATOS (DML) - HOTEL CORRENTINO
-- ==========================================================

-- LOCALIDAD (Ciudades del interior de Corrientes)
INSERT INTO Localidad (id_localidad, provincia) VALUES
(1, 'Corrientes Capital'),
(2, 'Goya'),
(3, 'Paso de los Libres');

-- PERSONA (Incluye DNI para cumplir Regla 1 y localidades reales)
INSERT INTO Persona (id_persona, dni, nombre, apellido, email, telefono, id_localidad) VALUES
(1, '35123456', 'Juan', 'Perez', 'jperez@gmail.com', '3794112233', 1), -- Huésped (Capital)
(2, '38987654', 'Maria', 'Gomez', 'mgomez@gmail.com', '3777998877', 2), -- Huésped (Goya)
(3, '40111222', 'Carlos', 'Lopez', 'clopez@gmail.com', '3772554433', 3), -- Huésped (Paso de los Libres)
(4, '32444555', 'Ana', 'Martinez', 'amartinez@hotel.com', '3794667788', 1), -- Empleada (Capital)
(5, '29888999', 'Diego', 'Romero', 'dromero@hotel.com', '3794223344', 1); -- Empleado (Capital)

-- HUESPED
INSERT INTO Huesped (id_huesped, nacionalidad) VALUES
(1, 'Argentina'),
(2, 'Argentina'),
(3, 'Argentina');

-- EMPLEADO
INSERT INTO Empleado (id_empleado, cargo, sueldo) VALUES
(4, 'Recepcionista', 450000.00),
(5, 'Gerente', 750000.00);

-- HABITACION (Respeta Regla 6: disponible, ocupada, reservada, mantenimiento)
INSERT INTO Habitacion (numero, categoria, precio, capacidad, estado_habitacion) VALUES
(101, 'Simple', 15000.00, 1, 'disponible'),
(102, 'Doble', 25000.00, 2, 'ocupada'),
(103, 'Suite', 45000.00, 4, 'reservada'),
(104, 'Doble', 25000.00, 2, 'mantenimiento');

-- RESERVA (Respeta Regla 12, 13, 14 y 15 con fechas y estados permitidos)
INSERT INTO Reserva (id_reserva, estado_reserva, fecha_hora_checkin, fecha_hora_checkout, id_empleado, id_huesped) VALUES
(1, 'finalizada', '2023-10-01 14:00:00', '2023-10-05 10:00:00', 4, 1),
(2, 'confirmada', NULL, NULL, 4, 2), -- Aún no hizo check-in
(3, 'cancelada', NULL, NULL, 5, 3);

-- DETALLE_RESERVA (Respeta Regla 10: egreso mayor a ingreso)
INSERT INTO Detalle_Reserva (id_reserva, numero, fecha_ingreso, fecha_egreso, cantidad_habitaciones) VALUES
(1, 102, '2023-10-01', '2023-10-05', 1),
(2, 103, '2023-10-20', '2023-10-25', 1),
(3, 101, '2023-11-01', '2023-11-03', 1);

-- PAGO (Respeta Regla 17, 18 y 20: importes positivos, medios de pago válidos)
INSERT INTO Pago (id_pago, fecha_pago, forma_de_pago, estado_pago, importe_total, id_reserva) VALUES
(1, '2023-10-01', 'tarjeta', 'Aprobado', 100000.00, 1),
(2, '2023-10-15', 'transferencia', 'Pendiente', 125000.00, 2);
