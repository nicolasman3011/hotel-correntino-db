SELECT 
    r.id_reserva,
    p.nombre + ' ' + p.apellido AS Nombre_Huesped,
    dr.fecha_ingreso,
    dr.fecha_egreso,
    hab.categoria,
    pag.importe_total,
    pag.forma_de_pago
FROM Reserva r
JOIN Huesped h ON r.id_huesped = h.id_huesped
JOIN Persona p ON h.id_huesped = p.id_persona
JOIN Detalle_Reserva dr ON r.id_reserva = dr.id_reserva
JOIN Habitacion hab ON dr.numero = hab.numero
JOIN Pago pag ON r.id_reserva = pag.id_reserva
WHERE r.id_reserva = 1001;
