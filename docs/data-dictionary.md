# Data dictionary

Extracted from the supplied coursework schema. Demo row counts describe the packaged CSV files.

## Customer
Demo rows: 1000

```sql
customerID			INT UNSIGNED	PRIMARY KEY,
    firstName			VARCHAR(50)		NOT NULL,
    lastName			VARCHAR(50)		NOT NULL,
    gender				VARCHAR(20),
    birthDate			DATE,
    email				VARCHAR(50),
    phoneNumber			VARCHAR(20)
```

## CustomerAddress
Demo rows: 1000

```sql
customerID			INT UNSIGNED	PRIMARY KEY,
    street				VARCHAR(50),
    city				VARCHAR(50)		NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    postalCode			VARCHAR(20),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## NormalCustomer
Demo rows: 700

```sql
customerID			INT UNSIGNED	PRIMARY KEY,
    frequencyOfVisit	INT UNSIGNED	NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## PremiumCustomer
Demo rows: 300

```sql
customerID			INT UNSIGNED	PRIMARY KEY,
    startDate			DATE			NOT NULL,
    endDate				DATE			NOT NULL,
    tier				ENUM('silver', 'gold', 'platinum')	NOT NULL,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## Branch
Demo rows: 100

```sql
branchID			INT UNSIGNED	PRIMARY KEY,
    branchName			VARCHAR(50)		NOT NULL,
    location			VARCHAR(200)	NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    phoneNumber			VARCHAR(20)		NOT NULL,
    openTime			TIME,
    closeTime			TIME
```

## Department
Demo rows: 22

```sql
departmentID		INT UNSIGNED	PRIMARY KEY,
    departmentName		VARCHAR(50)		NOT NULL
```

## Employee
Demo rows: 500

```sql
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
```

## EmployeeAddress
Demo rows: 500

```sql
employeeID			INT UNSIGNED	PRIMARY KEY,
    street				VARCHAR(50),
    city				VARCHAR(50)		NOT NULL,
    country				VARCHAR(50)		NOT NULL,
    postalCode			VARCHAR(20),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
```

## Staff
Demo rows: 400

```sql
employeeID			INT UNSIGNED	PRIMARY KEY,
    employmentType		ENUM('part-time', 'full-time')	NOT NULL,
    hourlyRate			DOUBLE,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
```

## Manager
Demo rows: 100

```sql
employeeID			INT UNSIGNED	PRIMARY KEY,
    yearOfExperience	INT UNSIGNED,
    performanceScore	DOUBLE,
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
```

## Task
Demo rows: 10

```sql
taskID				INT UNSIGNED	PRIMARY KEY,
    taskName			VARCHAR(50)		NOT NULL,
    taskType			ENUM('stocking', 'cleaning', 'cashiering', 'others')	NOT NULL
```

## TaskAssignment
Demo rows: 500

```sql
taskID				INT UNSIGNED,
    employeeID			INT UNSIGNED,
    taskShift			ENUM('morning', 'afternoon', 'evening')	NOT NULL,
    PRIMARY KEY (taskID, employeeID),
    FOREIGN KEY (taskID) REFERENCES Task(taskID),
    FOREIGN KEY (employeeID) REFERENCES Employee(employeeID)
```

## Warehouse
Demo rows: 100

```sql
warehouseID			INT UNSIGNED	PRIMARY KEY,
    warehouseName		VARCHAR(50)		NOT NULL,
    location			VARCHAR(200)	NOT NULL,
    capacityStock		INT UNSIGNED,
    branchID			INT UNSIGNED,
    FOREIGN KEY (branchID) REFERENCES Branch(branchID)
```

## Supplier
Demo rows: 200

```sql
supplierID			INT UNSIGNED	PRIMARY KEY,
    supplierName		VARCHAR(50)		NOT NULL,
    email				VARCHAR(50),
    phoneNumber			VARCHAR(20)
```

## Category
Demo rows: 21

```sql
categoryID			INT UNSIGNED	PRIMARY KEY,
    categoryName		VARCHAR(50)		NOT NULL
```

## Product
Demo rows: 500

```sql
productID			INT UNSIGNED	PRIMARY KEY,
    productName			VARCHAR(50)		NOT NULL,
    brand				VARCHAR(50),
    price				DOUBLE,
    cost				DOUBLE,
    categoryID			INT UNSIGNED,
    warehouseID			INT UNSIGNED,
    FOREIGN KEY (categoryID) REFERENCES Category(categoryID),
    FOREIGN KEY (warehouseID) REFERENCES Warehouse(warehouseID)
```

## Promotion
Demo rows: 50

```sql
promotionID			INT UNSIGNED	PRIMARY KEY,
    promotionName		VARCHAR(50)		NOT NULL,
    promotionType		ENUM('discount', '1-free-1', 'cashback')	NOT NULL,
    discountPercent		INT UNSIGNED,
    startDate			DATE,
    endDate				DATE
```

## Orders
Demo rows: 1000

```sql
orderID				INT UNSIGNED	PRIMARY KEY,
    orderDate			DATE			NOT NULL,
    orderStatus			ENUM('completed', 'pending', 'cancelled')	NOT NULL,
    staffID				INT UNSIGNED,
    FOREIGN KEY (staffID) REFERENCES Staff(employeeID)
```

## Payment
Demo rows: 1000

```sql
paymentID			INT UNSIGNED	PRIMARY KEY,
    paymentAmount		DOUBLE			NOT NULL,
    paymentStatus		ENUM('paid', 'pending', 'unpaid')	NOT NULL,
    orderID				INT UNSIGNED,
    FOREIGN KEY (orderID) REFERENCES Orders(orderID)
```

## CreditCard
Demo rows: 300

```sql
creditCardID		INT UNSIGNED	PRIMARY KEY,
	creditCardNumber	VARCHAR(20)		NOT NULL,
    creditCardType		VARCHAR(50)		NOT NULL,
    holderName			VARCHAR(50)		NOT NULL,
    CVV					VARCHAR(3)		NOT NULL,
    expirationDate		DATE			NOT NULL,
    customerID			INT UNSIGNED,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## Transactions
Demo rows: 1000

```sql
transactionID		INT UNSIGNED	PRIMARY KEY,
    bankName			VARCHAR(50)		NOT NULL,
    accountNumber		VARCHAR(20)		NOT NULL,
    amount				DOUBLE			NOT NULL
```

## OrderCustomerList
Demo rows: 1000

```sql
orderID				INT UNSIGNED,
    customerID			INT UNSIGNED,
    PRIMARY KEY (orderID, customerID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## OrderProductList
Demo rows: 1000

```sql
orderID				INT UNSIGNED,
    productID			INT UNSIGNED,
    quantityOrdered		INT UNSIGNED	NOT NULL,
    PRIMARY KEY (orderID, productID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
```

## PaymentList
Demo rows: 1000

```sql
paymentID			INT UNSIGNED,
    customerID			INT UNSIGNED,
    PRIMARY KEY (paymentID, customerID),
    FOREIGN KEY (paymentID) REFERENCES Payment(paymentID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
```

## TransactionList
Demo rows: 1000

```sql
transactionID		INT UNSIGNED,
    creditCardID		INT UNSIGNED,
    PRIMARY KEY (transactionID, creditCardID),
    FOREIGN KEY (transactionID) REFERENCES Transactions(transactionID),
    FOREIGN KEY (creditCardID) REFERENCES CreditCard(creditCardID)
```

## PromotionList
Demo rows: 1000

```sql
promotionID			INT UNSIGNED,
    productID			INT UNSIGNED,
    PRIMARY KEY (promotionID, productID),
    FOREIGN KEY (promotionID) REFERENCES Promotion(promotionID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
```

## SupplierProductList
Demo rows: 1000

```sql
supplierID			INT UNSIGNED,
    productID			INT UNSIGNED,
    PRIMARY KEY (supplierID, productID),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID),
    FOREIGN KEY (productID) REFERENCES Product(productID)
```

## BranchSupplierList
Demo rows: 1000

```sql
branchID			INT UNSIGNED,
	supplierID			INT UNSIGNED,
    PRIMARY KEY (branchID, supplierID),
    FOREIGN KEY (branchID) REFERENCES Branch(branchID),
    FOREIGN KEY (supplierID) REFERENCES Supplier(supplierID)
```
