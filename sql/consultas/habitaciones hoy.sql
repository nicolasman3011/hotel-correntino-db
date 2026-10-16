SELECT h.numero, 
       h.categoria, 
       p.nombre, 
       p.apellido, 
       p.telefono,
       dr.fecha_ingreso, 
       dr.fecha_egreso,
       dr.fecha_hora_checkin
FROM Habitacion h
JOIN Detalle_Reserva dr ON h.numero = dr.numero
JOIN Reserva r ON dr.id_reserva = r.id_reserva
JOIN Huesped hu ON r.id_huesped = hu.id_huesped
JOIN Persona p ON hu.id_huesped = p.id_persona
WHERE r.estado_reserva = 'confirmada'
  AND dr.fecha_ingreso <= CURRENT_DATE
  AND dr.fecha_egreso > CURRENT_DATE
  AND dr.fecha_hora_checkout IS NULL;
