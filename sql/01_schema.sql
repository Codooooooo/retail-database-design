-- Existing databases are never dropped automatically. Use a fresh database.
CREATE DATABASE IF NOT EXISTS WalmartDB;

USE WalmartDB;

CREATE TABLE Customer (
	customerID			INT UNSIGNED	PRIMARY KEY,
    firstName			VARCHAR(50)		NOT NULL,
    lastName			VARCHAR(50)		NOT NULL,
    gender				VARCHAR(20),
    birthDate			DATE,
    email				VARCHAR(50),
    phoneNumber			VARCHAR(20)
);

CREATE TABLE CustomerAddress (
	customerID			INT UNSIGNED	PRIMARY KEY,
    street				VARCHAR(50),
    city				VARCHAR(50)		NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    postalCode			VARCHAR(20),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE NormalCustomer (
	customerID			INT UNSIGNED	PRIMARY KEY,
    frequencyOfVisit	INT UNSIGNED	NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE PremiumCustomer (
	customerID			INT UNSIGNED	PRIMARY KEY,
    startDate			DATE			NOT NULL,
    endDate				DATE			NOT NULL,
    tier				ENUM('silver', 'gold', 'platinum')	NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Branch (
	branchID			INT UNSIGNED	PRIMARY KEY,
    branchName			VARCHAR(50)		NOT NULL,
    location			VARCHAR(200)	NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    phoneNumber			VARCHAR(20)		NOT NULL,
    openTime			TIME,
    closeTime			TIME
);

CREATE TABLE Department (
	departmentID		INT UNSIGNED	PRIMARY KEY,
    departmentName		VARCHAR(50)		NOT NULL
);

CREATE TABLE Employee (
	employeeID			INT UNSIGNED	PRIMARY KEY,
    firstName			VARCHAR(50)		NOT NULL,
    lastName			VARCHAR(50)		NOT NULL,
    gender				VARCHAR(20),
    birthDate			DATE,
    email				VARCHAR(50),
    phoneNumber			VARCHAR(20),
    SSN					VARCHAR(20)		NOT NULL,
    jobTitle			VARCHAR(50)		NOT NULL,
    hireDate			DATE,
    salary				DOUBLE,
    branchID			INT UNSIGNED,
    departmentID		INT UNSIGNED,
    FOREIGN KEY (branchID) REFERENCES Branch(branchID),
    FOREIGN KEY (departmentID) REFERENCES Department(departmentID)
);

CREATE TABLE EmployeeAddress (
	employeeID			INT UNSIGNED	PRIMARY KEY,
    street				VARCHAR(50),
    city				VARCHAR(50)		NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    postalCode			VARCHAR(20),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);

CREATE TABLE Staff (
	employeeID			INT UNSIGNED	PRIMARY KEY,
    employmentType		ENUM('part-time', 'full-time')	NOT NULL,
    hourlyRate			DOUBLE,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);

CREATE TABLE Manager (
	employeeID			INT UNSIGNED	PRIMARY KEY,
    yearOfExperience	INT UNSIGNED,
    performanceScore	DOUBLE,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);

CREATE TABLE Task (
	taskID				INT UNSIGNED	PRIMARY KEY,
    taskName			VARCHAR(50)		NOT NULL,
    taskType			ENUM('stocking', 'cleaning', 'cashiering', 'others')	NOT NULL
);

CREATE TABLE TaskAssignment (
	taskID				INT UNSIGNED,
    employeeID			INT UNSIGNED,
    taskShift			ENUM('morning', 'afternoon', 'evening')	NOT NULL,
    PRIMARY KEY (taskID, employeeID),
    FOREIGN KEY (taskID) REFERENCES Task(taskID),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
);

CREATE TABLE Warehouse (
	warehouseID			INT UNSIGNED	PRIMARY KEY,
    warehouseName		VARCHAR(50)		NOT NULL,
    location			VARCHAR(200)	NOT NULL,
    capacityStock		INT UNSIGNED,
    branchID			INT UNSIGNED,
    FOREIGN KEY (branchID) REFERENCES Branch(branchID)
);

CREATE TABLE Supplier (
	supplierID			INT UNSIGNED	PRIMARY KEY,
    supplierName		VARCHAR(50)		NOT NULL,
    email				VARCHAR(50),
    phoneNumber			VARCHAR(20)
);

CREATE TABLE Category (
	categoryID			INT UNSIGNED	PRIMARY KEY,
    categoryName		VARCHAR(50)		NOT NULL
);

CREATE TABLE Product (
	productID			INT UNSIGNED	PRIMARY KEY,
    productName			VARCHAR(50)		NOT NULL,
    brand				VARCHAR(50),
    price				DOUBLE,
    cost				DOUBLE,
    categoryID			INT UNSIGNED,
    warehouseID			INT UNSIGNED,
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID),
    FOREIGN KEY (warehouseID) REFERENCES Warehouse(warehouseID)
);

CREATE TABLE Promotion (
	promotionID			INT UNSIGNED	PRIMARY KEY,
    promotionName		VARCHAR(50)		NOT NULL,
    promotionType		ENUM('discount', '1-free-1', 'cashback')	NOT NULL,
    discountPercent		INT UNSIGNED,
    startDate			DATE,
    endDate				DATE
);

CREATE TABLE Orders (
	orderID				INT UNSIGNED	PRIMARY KEY,
    orderDate			DATE			NOT NULL,
    orderStatus			ENUM('completed', 'pending', 'cancelled')	NOT NULL,
    staffID				INT UNSIGNED,
    FOREIGN KEY (staffID) REFERENCES Staff(employeeID)
);

CREATE TABLE Payment (
	paymentID			INT UNSIGNED	PRIMARY KEY,
    paymentAmount		DOUBLE			NOT NULL,
    paymentStatus		ENUM('paid', 'pending', 'unpaid')	NOT NULL,
    orderID				INT UNSIGNED,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID)
);

CREATE TABLE CreditCard (
	creditCardID		INT UNSIGNED	PRIMARY KEY,
	creditCardNumber	VARCHAR(20)		NOT NULL,
    creditCardType		VARCHAR(50)		NOT NULL,
    holderName			VARCHAR(50)		NOT NULL,
    CVV					VARCHAR(3)		NOT NULL,
    expirationDate		DATE			NOT NULL,
    customerID			INT UNSIGNED,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Transactions (
	transactionID		INT UNSIGNED	PRIMARY KEY,
    bankName			VARCHAR(50)		NOT NULL,
    accountNumber		VARCHAR(20)		NOT NULL,
    amount				DOUBLE			NOT NULL
);

CREATE TABLE OrderCustomerList (
	orderID				INT UNSIGNED,
    customerID			INT UNSIGNED,
    PRIMARY KEY (orderID, customerID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE OrderProductList (
	orderID				INT UNSIGNED,
    productID			INT UNSIGNED,
    quantityOrdered		INT UNSIGNED	NOT NULL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
);

CREATE TABLE PaymentList (
	paymentID			INT UNSIGNED,
    customerID			INT UNSIGNED,
    PRIMARY KEY (paymentID, customerID),
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE TransactionList (
	transactionID		INT UNSIGNED,
    creditCardID		INT UNSIGNED,
    PRIMARY KEY (transactionID, creditCardID),
    FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID),
    FOREIGN KEY (creditCardID) REFERENCES CreditCard(creditCardID)
);

CREATE TABLE PromotionList (
	promotionID			INT UNSIGNED,
    productID			INT UNSIGNED,
    PRIMARY KEY (promotionID, productID),
    FOREIGN KEY (promotionID) REFERENCES Promotion(promotionID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
);

CREATE TABLE SupplierProductList (
	supplierID			INT UNSIGNED,
    productID			INT UNSIGNED,
    PRIMARY KEY (supplierID, productID),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
);

CREATE TABLE BranchSupplierList (
	branchID			INT UNSIGNED,
	supplierID			INT UNSIGNED,
    PRIMARY KEY (branchID, supplierID),
    FOREIGN KEY (branchID) REFERENCES Branch(branchID),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID)
);

SHOW TABLES;
SELECT FOUND_ROWS() AS totalNumTables;
