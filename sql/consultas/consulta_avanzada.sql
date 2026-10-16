SELECT 
    hab.categoria,
    COUNT(dr.id_reserva) AS Total_Veces_Reservada
FROM Habitacion hab
JOIN Detalle_Reserva dr ON hab.numero = dr.numero
GROUP BY hab.categoria
ORDER BY Total_Veces_Reservada DESC;
