SELECT r.id_reserva, r.estado_reserva, 
       dr.numero, dr.fecha_ingreso, dr.fecha_egreso,
       p.nombre, p.apellido
FROM Reserva r
JOIN Huesped h ON r.id_huesped = h.id_huesped
JOIN Persona p ON h.id_huesped = p.id_persona
JOIN Detalle_Reserva dr ON r.id_reserva = dr.id_reserva
WHERE h.id_huesped = 5;   -- id del huésped	