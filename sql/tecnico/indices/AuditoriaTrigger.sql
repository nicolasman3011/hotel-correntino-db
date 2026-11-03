CREATE TABLE precio_habitacion(
    id_auditoria INT IDENTITY(1,1) PRIMARY KEY,
    num_habitacion INT NOT NULL,
    precio_anterior DECIMAL(10,2),
    precio_actualizado DECIMAL(10,2),
    actualizacion VARCHAR(50),
    empleado VARCHAR(50),
    fecha_modifiacion DATETIME DEFAULT GETDATE()
);
GO
