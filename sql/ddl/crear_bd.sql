CREATE TABLE Localidad
(
  id_localidad INT NOT NULL,
  provincia VARCHAR NOT NULL,
  PRIMARY KEY (id_localidad)
);

CREATE TABLE Persona
(
  nombre VARCHAR NOT NULL,
  apellido VARCHAR NOT NULL,
  email VARCHAR NOT NULL,
  telefono NUMERIC NOT NULL,
  id_persona INT NOT NULL,
  id_localidad INT NOT NULL,
  PRIMARY KEY (id_persona),
  FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad)
);

CREATE TABLE Huesped
(
  nacionalidad VARCHAR NOT NULL,
  id_huesped INT NOT NULL,
  PRIMARY KEY (id_huesped),
  FOREIGN KEY (id_huesped) REFERENCES Persona(id_persona)
);

CREATE TABLE Habitación
(
  numero INT NOT NULL,
  categoria CHAR NOT NULL,
  precio FLOAT NOT NULL,
  capacidad INT NOT NULL,
  estado_habitacion CHAR NOT NULL,
  PRIMARY KEY (numero)
);

CREATE TABLE Empleado
(
  cargo VARCHAR NOT NULL,
  sueldo FLOAT NOT NULL,
  id_empleado INT NOT NULL,
  PRIMARY KEY (id_empleado),
  FOREIGN KEY (id_empleado) REFERENCES Persona(id_persona)
);

CREATE TABLE Reserva
(
  estado_reserva CHAR NOT NULL,
  id_reserva INT NOT NULL,
  fecha_ingreso DATE NOT NULL,
  fecha_Egreso DATE NOT NULL,
  id_empleado INT NOT NULL,
  id_huesped INT NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(),
  FOREIGN KEY (id_huesped) REFERENCES Huesped()
);

CREATE TABLE Pago
(
  forma_de_pago CHAR NOT NULL,
  estado_pago CHAR NOT NULL,
  importe_total FLOAT NOT NULL,
  id_pago INT NOT NULL,
  id_reserva INT NOT NULL,
  PRIMARY KEY (id_pago),
  FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);

CREATE TABLE Detalle_Reserva
(
  cantidad_habitaciones INT NOT NULL,
  id_reserva INT NOT NULL,
  numero INT NOT NULL,
  PRIMARY KEY (id_reserva),
  FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
  FOREIGN KEY (numero) REFERENCES Habitación(numero)
);
