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

SELECT 
    COUNT(Employee) as EmplCount
    FROM dimEmployee
WHERE Employee != 'Unknown'

