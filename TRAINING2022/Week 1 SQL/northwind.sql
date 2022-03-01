--1. Get a list of latest order IDs for all customers by using the max function on Order_ID column. 
SELECT 
    contactname,
    MAX(orderid)
FROM 
    orders 
        INNER JOIN 
    customers
USING(customerid)
GROUP BY 
    contactname;

--2. Find suppliers who sell more than one product to Northwind Trader. 
 


--3. Create a function to get latest order date for entered customer_id 

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION get_laetst_order_date( p_customer_id customers.customerid%type) 
RETURN orders.orderdate%type
IS
v_date orders.orderdate%type;
    BEGIN
        SELECT max(orderdate) INTO v_date  FROM orders WHERE customerid=p_customer_id;
        RETURN v_date;
    END get_laetst_order_date;
    
BEGIN
    DBMS_OUTPUT.put_line( get_laetst_order_date('&v'));
END;



--4. Get the top 10 most expensive products.
SELECT 
    productid,
    productname,
    unitprice
FROM 
    products
ORDER BY 
    unitprice desc
FETCH FIRST 10 ROWS ONLY;


--5. Rank products by the number of units in stock in each product category. 

SELECT 
    productid,
    productname
FROM 
    products
WHERE 
    categoryid IN (
        
        SELECT 
            categoryid 
        FROM 
            categories 
        GROUP BY 
        categoryid)
        
ORDER BY (unitsinstock);

--6. Rank customers by the total sales amount within each order date 

SELECT 
    orderdate,
    contactname,
    SUM(unitprice*quantity)
FROM 
    orderdetails INNER JOIN orders
USING(orderid)
INNER JOIN 
    customers
USING(customerid)
GROUP BY 
    orderdate,
    contactname
ORDER BY SUM(unitprice*quantity) DESC;

--7. For each order, calculate a subtotal for each Order (identified by OrderID).

SELECT 
    orderid,
    SUM(unitprice*quantity) 
FROM 
        orders 
    INNER JOIN 
        orderdetails
USING(orderid)
GROUP BY 
    orderid
ORDER BY 
    orderid DESC;

--8.Sales by Year for each order. 
--Hint: Get Subtotal as sum(UnitPrice * Quantity * (1 - Discount)) for every order_id then join with orders table

SELECT 
    shippeddate,
    orderid ,
    SUM(unitprice * quantity * (1 - discount)) as sumtotal,
    TO_CHAR(shippeddate,'YYYY') 
FROM orders INNER JOIN orderdetails
USING(orderid)
GROUP BY 
    shippeddate,
    orderid,
    TO_CHAR(shippeddate,'YYYY');

--9. Get Employee sales by country names


SELECT 
    e.country, e.Lastname, e.Firstname,o.shippedDate,o.orderid,(od.unitprice * od.quantity) as totalprice
FROM
    employees e JOIN orders o ON e.employeeid = o.employeeid, orderdetails od 

WHERE 
    o.orderid = od.orderid 
ORDER BY 
lastname;


--10. Alphabetical list of products


SELECT 
    productid, productname 
FROM
    products
ORDER BY 
    productname;

    
--11. Display the current Productlist Hint: Discontinued=’N’

SELECT 
    productid,
    productname
FROM 
    products
WHERE 
    Discontinued=0
ORDER BY 
    productid;


--12. Calculate sales price for each order after discount is applied.

SELECT 
    o.orderid,
    p.productid,
    p.productname,
    p.unitprice,
    o.quantity,
    discount,
    ((p.unitprice*o.quantity)-(p.unitprice*o.quantity*discount)) as After_discount
FROM 
        products p 
    INNER JOIN 
        orderdetails o
ON 
    p.productid=o.productid
ORDER BY 
    o.orderid;


--13. Sales by Category: For each category, we get the list of products sold and the total sales amount.

SELECT 
    c.categoryid, 
    c.categoryname, 
    p.productname, 
    SUM(od.unitprice * od.quantity * (1 - od.discount)) AS productsales
FROM 
    categories c, 
    products p, 
    orderdetails od 
WHERE 
    c.categoryid=p.categoryid 
    AND 
    od.productid=p.productid 
GROUP BY 
    c.categoryid, 
    c.categoryname, 
    p.productname
ORDER BY 
    c.categoryid, 
    p.productname;

--14. Create below views:
--        1.  vwProducts_Above_Average_Price
--            Displays products(productname,unitprice) who’s price is greater than avg(price)
CREATE VIEW vwProducts_Above_Average_Price
AS
    SELECT 
        productname, 
        unitprice
    FROM 
        products
    WHERE 
        unitprice>(SELECT 
                   AVG(unitprice) 
               FROM 
                   products)
ORDER BY 
    unitprice;

SELECT * FROM vwProducts_Above_Average_Price;

--        2.  vwQuarterly_Orders_by_Product
--            Display product(productname), customers(companyname), orders(orderyear) 

CREATE VIEW vwQuarterly_Orders_by_Product
AS
SELECT 
    p.productname, 
    c.companyname, 
    EXTRACT (Year FROM o.orderdate) AS orderyear
FROM 
    products p, 
    customers c, 
    orders o, 
    orderdetails od
WHERE 
    c.customerid=o.customerid AND o.orderid=od.orderid AND od.productid=p.productid
ORDER BY 
    c.companyname, 
    p.productname;

SELECT * FROM vwQuarterly_Orders_by_Product;

--        3. vwUnitsInStock
--            Display Supplier Continent wise sum of unitinstock.
--            'Europe'= ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France')
--            'America'= 'USA','Canada','Brazil' and 'Asia-Pacific'

CREATE VIEW vwUnitsInStock
AS
SELECT 
    sup.supplier_continent, 
    SUM(p.unitsinstock) AS continent_sum
FROM 
    products p, 
    (SELECT s.supplierid, 
                    CASE
                        WHEN s.country IN ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France')
                            THEN 'Europe'
                        WHEN s.country IN ('USA','Canada','Brazil', 'Asia-Pacific')
                            THEN 'America'
                        WHEN s.country NOT IN ('UK','Spain','Sweden','Germany','Norway', 'Denmark','Netherlands','Finland','Italy','France', 'USA','Canada','Brazil', 'Asia-Pacific')
                            THEN 'Others'
                        END AS supplier_continent 
                  FROM suppliers s) sup
WHERE 
    sup.supplierid=p.supplierid
GROUP BY 
    sup.supplier_continent;

SELECT * FROM vwUnitsInStock;


--        4. vw10Most_Expensive_Products
--            Display top 10 expensive products 

CREATE VIEW vw10Most_Expensive_Products
AS
SELECT 
    productname, unitprice
FROM 
    products
ORDER BY 
    unitprice DESC
FETCH FIRST 10 ROWS ONLY;

SELECT * FROM vw10Most_Expensive_Products;

--        5. vwCustomer_Supplier_by_City
--            Display customer supplier by city
CREATE VIEW vwCustomer_Supplier_by_City
AS
(SELECT companyname, city, contactname, 'Customers' AS relationship
FROM customers)
UNION 
(SELECT companyname, city, contactname, 'Suppliers' AS relationship
FROM suppliers) 
ORDER BY city;

SELECT * FROM vwCustomer_Supplier_by_City;
