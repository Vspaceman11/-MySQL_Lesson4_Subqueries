USE ShopDB;

SELECT 
customers.LName AS CustomerLName,
customers.FName AS CustomerFName,
customers.MName AS CustomerMName,
employees.LName AS EmployeesLName,
employees.FName AS EmployeesFName,
employees.MName AS EmployeesMName
FROM orders
INNER JOIN customers
ON orders.CustomerNo = customers.CustomerNo
INNER JOIN employees
ON orders.EmployeeID = employees.EmployeeID
INNER JOIN orderdetails
ON orders.OrderID = orderdetails.OrderID
WHERE orderdetails.TotalPrice > 100
GROUP BY CustomerLName,CustomerFName,CustomerMName,EmployeesLName,EmployeesFName,EmployeesMName;


-- SUBQUERY STATEMENTS -- 
DROP TEMPORARY TABLE TmpTable;
CREATE TEMPORARY TABLE TmpTable
SELECT (SELECT LName FROM Customers
		WHERE CustomerNo = (SELECT CustomerNo FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS CustomerLName,
		(SELECT FName FROM Customers
		WHERE CustomerNo = (SELECT CustomerNo FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS CustomerFName,
		(SELECT MName FROM Customers
		WHERE CustomerNo = (SELECT CustomerNo FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS CustomerMName,
		(SELECT LName FROM Employees
		WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS EmployeesLName,
		(SELECT FName FROM Employees
		WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS EmployeesFName,
		(SELECT MName FROM Employees
		WHERE EmployeeID = (SELECT EmployeeID FROM Orders
							WHERE Orders.OrderId = OrderDetails.OrderId)) AS EmployeesMName
FROM OrderDetails WHERE OrderDetails.TotalPrice > 100;

SELECT CustomerLName, CustomerFName, CustomerMName, EmployeesLName, EmployeesFName, EmployeesMName FROM TmpTable
GROUP BY CustomerLName, CustomerFName, CustomerMName, EmployeesLName, EmployeesFName, EmployeesMName;
                            