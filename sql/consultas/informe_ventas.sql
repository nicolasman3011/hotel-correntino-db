SELECT 
    forma_de_pago,
    COUNT(id_pago) AS Cantidad_Operaciones,
    SUM(importe_total) AS Total_Recaudado
FROM Pago
WHERE estado_pago = 'Pagado' OR estado_pago = 'Aprobado'
GROUP BY forma_de_pago;
