-- QUERY 1
-- Seleccione todos los datos de la tabla Departament del schema HumanResource

SELECT
	*
FROM
	HumanResources.Department;

-- QUERY 2
/*
	Seleccione un agrupamiento de los nombres de grupos que existen en la tabla
	Departament del schema HumanResources.
*/

SELECT
	GroupName
FROM
	HumanResources.Department
GROUP BY
	GroupName;

-- QUERY 3
-- Seleccione todos los departamentos ordenándolos en orden descendente.

SELECT
	*
FROM
	HumanResources.Department
ORDER BY
	[Name] DESC;

-- QUERY 4
-- Seleccione todos los departamentos ordenándolos en orden ascendente.

SELECT
	*
FROM
	HumanResources.Department
ORDER BY
	[Name] ASC;

-- QUERY 5
-- Seleccione todos los empleados de la tabla Employee del schema Human Resources.

SELECT
	*
FROM
	HumanResources.Employee;

-- QUERY 6
/*
	Seleccione todos los empleados de la tabla Employee del schema Human Resources donde
	el género sea masculino
*/

SELECT
	*
FROM
	HumanResources.Employee
WHERE
	Gender = 'M';

-- QUERY 7
/*
	Seleccione todos los empleados de la tabla Employee del schema Human Resources donde
	el nivel de organización sea mayor a 3
*/

SELECT
	*
FROM
	HumanResources.Employee
WHERE
	OrganizationLevel > 3;

-- QUERY 8
/*
	Seleccione todos los empleados de la tabla Employee del schema Human Resources donde
	el nivel de organización sea mayor e igual a 2 y que el género sea femenino
*/

SELECT
	*
FROM
	HumanResources.Employee
WHERE
	OrganizationLevel >= 2
	AND Gender = 'F';

-- QUERY 9
/*
	Selección los campos BusinessEntityID,NationalIDNumber de la tabla Employee del
	schema Human Resources donde los jobtitle sean Marketing Assistant o Design Engineer.
*/

SELECT
	BusinessEntityID,
	NationalIDNumber
FROM
	HumanResources.Employee
WHERE
	JobTitle = 'Marketing Assistant'
	OR JobTitle = 'Design Engineer';

-- QUERY 10
/*
	Seleccionar todos los empleados de la tabla Employee del schema Human Resources que
	estén entre la fecha de nacimiento de 1 de enero de 1969 y 31 de diciembre de 1972.
*/

SELECT
	*
FROM
	HumanResources.Employee
WHERE
	BirthDate BETWEEN '1969-01-01' AND '1972-12-31';

-- QUERY 11
/*
	De la tabla Employee del schema Human Resources Calcule el total de ah pagar por horas
	de vacacion si se conece que cada hora cuesta $8.00
*/

SELECT
	BusinessEntityID,
	LoginID,
	VacationHours,
	8.00 AS VacationProfitPerHour,
	(8.00 * VacationHours) TotalToPay
FROM
	HumanResources.Employee;

-- QUERY 12
/*
	De la tabla Production.ProductSubcategory muestre cuantas subcategorías hay registradas
	por categoría
*/

SELECT
	cat.ProductCategoryID,
	cat.[Name],
	COUNT(subcat.ProductSubcategoryID) AS SubCategories
FROM
	Production.ProductSubcategory subcat
	INNER JOIN Production.ProductCategory cat ON subcat.ProductCategoryID = cat.ProductCategoryID
GROUP BY
	cat.ProductCategoryID,
	cat.[Name];

-- QUERY 13
-- De la tabla Sales.Customer mostrar cuantos clientes existen registrados por territorios

SELECT
	terr.TerritoryID,
	terr.[Name],
	COUNT(cus.CustomerID) AS Customers
FROM
	Sales.Customer cus
	INNER JOIN Sales.SalesTerritory terr ON cus.TerritoryID = terr.TerritoryID
GROUP BY
	terr.TerritoryID,
	terr.[Name];

-- QUERY 14
/*
	De la tabla sales.SalesOrderHeader mostrar la suma total del Sub Total de compra según el
	IdCustomer que se coloque.
*/

DECLARE @CustomerID INT = 14324;

/*
Probado con:
14324
22814
11407
*/

SELECT
	CustomerID,
	SUM(SubTotal) AS SumSubTotal
FROM
	Sales.SalesOrderHeader
WHERE
	CustomerID = @CustomerID
GROUP BY
	CustomerID;

-- QUERY 15
/*
	De la tabla Sales. CreditCard mostrar cuantas tarjetas según su tipo están registradas en el
	sistema
*/

SELECT
	CardType,
	COUNT(CreditCardID) AS TotalCards
FROM
	Sales.CreditCard
GROUP BY
	CardType;

-- QUERY 16
/*
	De la tabla Sales.SalesOrderDetail evaluar Linea total de compra que es el total de la
	compra , si la compra es mayor de $1000.00 realizar un descuento del 10% y mostrar el
	nuevo total a pagar si es mayor $1500.00 realizar un descuento del 14% y mostrar el
	nuevo total a pagar si es mayor de $2000.00 realizar un descuento del 18% y mostrar el
	nuevo total a pagar.
*/

SELECT
	LineTotal,
	CASE
		WHEN (LineTotal > 1000 AND LineTotal <= 1500) THEN LineTotal - (0.10 * LineTotal)
		WHEN (LineTotal > 1500 AND LineTotal <= 2000) THEN LineTotal - (0.14 * LineTotal)
		WHEN (LineTotal > 2000) THEN LineTotal - (0.18 * LineTotal)
		ELSE LineTotal
	END
	AS NewLineTotal
FROM
	Sales.SalesOrderDetail;
