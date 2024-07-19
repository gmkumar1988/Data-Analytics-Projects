-- SELECT 
--     [Buying Group],
--     COUNT([Customer Key]) as custcount
-- FROM dimCustomer
-- GROUP BY [Buying Group]
-- ORDER BY custcount


SELECT 
    [Postal Code]
FROM dimCustomer
WHERE [Buying Group] = 'Wingtip Toys'
GROUP BY [Postal Code]
HAVING COUNT([Customer Key]) > 3
