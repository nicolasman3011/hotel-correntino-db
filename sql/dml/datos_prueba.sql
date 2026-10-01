-- Datos de prueba para Localidad
INSERT INTO Localidad (id_localidad, provincia) VALUES (1, 'Corrientes');
INSERT INTO Localidad (id_localidad, provincia) VALUES (2, 'Chaco');
INSERT INTO Localidad (id_localidad, provincia) VALUES (3, 'Misiones');

-- Datos de prueba para Habitacion
INSERT INTO Habitacion (numero, categoria, precio, capacidad, estado_habitacion) VALUES (101, 'Estandar', 15000.00, 2, 'Disponible');
INSERT INTO Habitacion (numero, categoria, precio, capacidad, estado_habitacion) VALUES (102, 'Suite', 35000.00, 2, 'Ocupada');

-- Datos de prueba para Persona
INSERT INTO Persona (id_persona, nombre, apellido, email, telefono, id_localidad) VALUES (10, 'Juan', 'Perez', 'jperez@email.com', '3794123456', 1);
INSERT INTO Persona (id_persona, nombre, apellido, email, telefono, id_localidad) VALUES (11, 'Maria', 'Gonzalez', 'mgonzalez@email.com', '3624123456', 2);
INSERT INTO Persona (id_persona, nombre, apellido, email, telefono, id_localidad) VALUES (20, 'Carlos', 'Rodriguez', 'crodriguez@hotel.com', '3794987654', 1);

-- Datos de prueba para Huesped
INSERT INTO Huesped (id_huesped, nacionalidad) VALUES (10, 'Argentina');
INSERT INTO Huesped (id_huesped, nacionalidad) VALUES (11, 'Argentina');

-- Datos de prueba para Empleado
INSERT INTO Empleado (id_empleado, cargo, sueldo) VALUES (20, 'Recepcionista', 450000.00);

-- Datos de prueba para Reserva
INSERT INTO Reserva (id_reserva, estado_reserva, id_empleado, id_huesped) VALUES (1001, 'Confirmada', 20, 10);

-- Datos de prueba para Pago
INSERT INTO Pago (id_pago, forma_de_pago, estado_pago, importe_total, id_reserva) VALUES (5001, 'Efectivo', 'Pagado', 15000.00, 1001);

-- Datos de prueba para Detalle_Reserva
INSERT INTO Detalle_Reserva (id_reserva, numero, fecha_ingreso, fecha_egreso, cantidad_habitaciones) VALUES (1001, 101, '2026-10-15', '2026-10-17', 1);
