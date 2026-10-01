CREATE TABLE Localidad (
id_localidad INT NOT NULL,
provincia VARCHAR(50) NOT NULL,
PRIMARY KEY (id_localidad)
);

CREATE TABLE Persona (
id_persona INT NOT NULL,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
telefono VARCHAR(20) NOT NULL,
id_localidad INT NOT NULL,
PRIMARY KEY (id_persona),
FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad)
);

CREATE TABLE Huesped (
id_huesped INT NOT NULL,
nacionalidad VARCHAR(50) NOT NULL,
PRIMARY KEY (id_huesped),
FOREIGN KEY (id_huesped) REFERENCES Persona(id_persona)
);

CREATE TABLE Habitacion (
numero INT NOT NULL,
categoria VARCHAR(50) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
capacidad INT NOT NULL,
estado_habitacion VARCHAR(20) NOT NULL,
PRIMARY KEY (numero)
);

CREATE TABLE Empleado (
id_empleado INT NOT NULL,
cargo VARCHAR(50) NOT NULL,
sueldo DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id_empleado),
FOREIGN KEY (id_empleado) REFERENCES Persona(id_persona)
);

CREATE TABLE Reserva (
id_reserva INT NOT NULL,
estado_reserva VARCHAR(20) NOT NULL,
id_empleado INT NOT NULL,
id_huesped INT NOT NULL,
PRIMARY KEY (id_reserva),
FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
FOREIGN KEY (id_huesped) REFERENCES Huesped(id_huesped)
);

CREATE TABLE Pago (
id_pago INT NOT NULL,
forma_de_pago VARCHAR(50) NOT NULL,
estado_pago VARCHAR(20) NOT NULL,
importe_total DECIMAL(10,2) NOT NULL,
id_reserva INT NOT NULL,
PRIMARY KEY (id_pago),
FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva)
);

CREATE TABLE Detalle_Reserva (
id_reserva INT NOT NULL,
numero INT NOT NULL,
fecha_ingreso DATE NOT NULL,
fecha_egreso DATE NOT NULL,
cantidad_habitaciones INT NOT NULL,
PRIMARY KEY (id_reserva, numero),
FOREIGN KEY (id_reserva) REFERENCES Reserva(id_reserva),
FOREIGN KEY (numero) REFERENCES Habitacion(numero)
);
