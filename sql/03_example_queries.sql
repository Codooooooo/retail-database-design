USE WalmartDB;

-- Order value calculated from the catalog price (not historical realized revenue).
SELECT o.orderID, o.orderStatus, SUM(p.price * op.quantityOrdered) AS catalog_order_value
FROM Orders o JOIN OrderProductList op ON o.orderID = op.orderID
JOIN Product p ON p.productID = op.productID
GROUP BY o.orderID, o.orderStatus;

-- Product assortment by category.
SELECT c.categoryID, c.categoryName, COUNT(p.productID) AS product_count
FROM Category c LEFT JOIN Product p ON c.categoryID = p.categoryID
GROUP BY c.categoryID, c.categoryName;

-- Employee distribution across branches.
SELECT b.branchID, b.branchName, COUNT(e.employeeID) AS employee_count
FROM Branch b LEFT JOIN Employee e ON e.branchID = b.branchID
GROUP BY b.branchID, b.branchName;
