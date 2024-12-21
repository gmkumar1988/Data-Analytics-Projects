-- -- SELECT 
-- --     [Buying Group],
-- --     COUNT([Customer Key]) as custcount
-- -- FROM dimCustomer
-- -- GROUP BY [Buying Group]
-- -- ORDER BY custcount


-- -- SELECT 
-- --     [Postal Code]
-- -- FROM dimCustomer
-- -- WHERE [Buying Group] = 'Wingtip Toys'
-- -- GROUP BY [Postal Code]
-- -- HAVING COUNT([Customer Key]) > 3

-- SELECT 
--     [Postal Code],
--     [Customer]
-- FROM dimCustomer
-- WHERE [Postal Code] IN (SELECT
--                             [Postal Code]
--                             FROM dimCustomer
--                             where [Buying Group]= 'Wingtip Toys'
--                             GROUP BY [Postal Code]
--                             HAVING COUNT ([Customer Key])> 3)

-- SELECT 
--     COUNT(Employee) as EmplCount
--     FROM dimEmployee
-- WHERE Employee != 'Unknown'


-- SELECT 
--      CAST(CAST(COUNT(Employee)) AS DECIMAL(8,2)) /
--                     (SELECT 
--                     COUNT(Employee) as EmplCount
--                     FROM dimEmployee
--                     WHERE Employee ! = 'Unknown'
--                     ) AS SalespeoplePctOfTotal
--     FROM dimEmployee
-- WHERE Employee != 'Unknown'
-- AND [Is Salesperson] = 1

-- SELECT MAX([Fiscal Year])
--     FROM dimDate

-- SELECT 
--     d.[Fiscal Year] AS FiscalYear,
--     SUM(s.[Total Excluding Tax]) AS TotalSalesExcludingTax
-- FROM factSale
--     INNER JOIN dimDate AS d 
--     ON s.[Invoice Date Key] = d.[Date]
-- GROUP BY d.[Fiscal Year]
-- ORDER BY d.[Fiscal Year] ASC

SELECT 
    p.[Stock Item],
    SUM(Quantity) AS QuantitySold
FROM factSale AS s 
    RIGHT JOIN dimStockItem p 
    ON s.[Stock Item Key] = p.[Stock Item Key]
WHERE p.[Is Chiller Stock] = 1
GROUP BY p.[Stock Item]
ORDER BY QuantitySold DESC


