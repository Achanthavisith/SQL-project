CREATE TABLE dbo.CustomerLogin(
	[LoginID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Email] varchar(50) NOT NULL,
	[Password] varchar(50) NOT NULL,
	[LastLogin] datetime  DEFAULT (getdate()) NOT NULL,
	[AcctCreated] datetime  DEFAULT (getdate()) NOT NULL
) 
GO

CREATE TABLE dbo.Customerinfo(
	[UserID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Fname] varchar(50) NOT NULL,
	[lname] varchar(50) NOT NULL,
	[Address] varchar(50) NOT NULL,
	[DateofBirth] date NOT NULL,
	[Country] varchar(50) NOT NULL,
	[loginID] int UNIQUE FOREIGN KEY REFERENCES dbo.CustomerLogin(LoginID) NOT NULL,
	[isMinor] bit DEFAULT(0) NOT NULL
) 
GO

CREATE TABLE dbo.ShippingAddress(
	[ShippingID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BillAddress] varchar(50) NOT NULL,
	[ShipAddress] varchar(50) NOT NULL,
	[CreditCard] varchar(50) NOT NULL,
	[Country] varchar(50) NOT NULL,
	[BillZip] varchar (10) NOT NULL,
	[UserID] int FOREIGN KEY REFERENCES dbo.CustomerInfo(UserID) NOT NULL, 
	[isPrimary] bit DEFAULT(0) NOT NULL
) 
GO

CREATE TABLE dbo.Shirts(
	[ShirtID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BrandName] varchar(50) NOT NULL,
	[ShirtSize] varchar(10) NOT NULL,
	[ShirtPrice] smallmoney NOT NULL,
	[ShirtQuantity] int NOT NULL,
	[inStock] bit default(0) NOT NULL
) 
GO

CREATE TABLE dbo.Pants(
	[PantID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BrandName] varchar(50) NOT NULL,
	[PantSize] varchar(10) NOT NULL,
	[PantPrice] smallmoney NOT NULL,
	[PantQuantity] int NOT NULL,
	[inStock] bit default(0) NOT NULL
) 
GO

CREATE TABLE dbo.Accessories(
	[AccessoryID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BrandName] varchar(50) NOT NULL,
	[AccessorySize] varchar(10) NULL,
	[AccessoryPrice] smallmoney NOT NULL,
	[AccessoryQuantity] int NOT NULL,
	[inStock] bit default(0) NOT NULL
) 
GO
CREATE TABLE dbo.CustomerOrders(
	[OrderID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[ShipSpeed] varchar (20) NOT NULL,
	[purchaseDate] datetime DEFAULT (getdate()) NOT NULL,
	[ShippingID] int FOREIGN KEY REFERENCES dbo.ShippingAddress(ShippingID) NOT NULL,
	[UserID] int FOREIGN KEY REFERENCES dbo.Customerinfo(UserID) NOT NULL
) 
GO
CREATE TABLE dbo.Purchase(
	[PurchaseID] int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[OrderID] int FOREIGN KEY REFERENCES dbo.CustomerOrders(OrderID) NOT NULL,
	[AccessoryID] int  FOREIGN KEY REFERENCES dbo.Accessories(AccessoryID) NULL,
	[PantID] int  FOREIGN KEY REFERENCES dbo.Pants(PantID) NULL,
	[ShirtID] int  FOREIGN KEY REFERENCES dbo.Shirts(ShirtID) NULL,
	[AccessoryQuantity] int NOT NULL,
	[PantQuantity] int NOT NULL,
	[ShirtQuantity] int NOT NULL,
) 
GO

--insert for CustomerLogin
INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email1@email.com','Pass1')
GO

INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email2@email.com','Pass2')
GO

INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email3@email.com','Pass3')
GO

INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email4@email.com','Pass4')
GO

INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email5@email.com','Pass5')
GO

INSERT INTO dbo.CustomerLogin (Email, Password)
VALUES ('Email6@email.com','Pass6')
GO

--inserts for customerinfo and shipaddress
DECLARE @id int
--1st insert
BEGIN TRAN;
INSERT INTO dbo.CustomerInfo (Fname, lname, Address, DateofBirth, Country, loginid, isMinor)
VALUES ('Andrew', 'Wilks', '300 Oak Street, WA 98001', '1996-08-30', 'United States', '1', '0')
SET @id = SCOPE_IDENTITY();

INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('300 Oak Street, WA 98001', 'ShipAdd1','4432220584769719', 'United States', 'Zip1', @id, '1');


--2nd insert
BEGIN TRAN;
INSERT INTO dbo.CustomerInfo (Fname, lname, Address, DateofBirth, Country, loginid, isMinor)
VALUES ('Henry', 'Cox', '5002 Wonder ln, CA 90215', '1998-07-30', 'United States', '2', '0')
SET @id = SCOPE_IDENTITY();

INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('5002 Wonder ln, CA 90215', 'ShipAdd1','4429216011874242', 'United States', 'Zip1', @id, '1');


--3rd insert
BEGIN TRAN;
INSERT INTO dbo.CustomerInfo (Fname,lname, Address, DateofBirth, Country, loginid, isMinor)
VALUES ('Drew', 'Berry', '324 Vincent Ave, GA 30501', '1990-04-17', 'United States', '3', '0')
SET @id = SCOPE_IDENTITY();

INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('324 Vincent Ave, GA 30501', 'ShipAdd1','4198253199088237', 'United States', 'Zip1', @id, '1');
INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('324 Vincent Ave, GA 30501', 'ShippAdd2', '4198253199088237', 'United States','Zip2', @id, '0');


--4th insert
BEGIN TRAN;
INSERT INTO dbo.CustomerInfo (Fname,lname, Address, DateofBirth, Country, loginid, isMinor)
VALUES ('Will', 'Hanks', '748 Phillip Cir, NY 50141', '1986-01-25', 'United States', '4', '0')
SET @id = SCOPE_IDENTITY();

INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('748 Phillip Cir, NY 50141', 'ShipAdd1','4388474638553702', 'United States', 'Zip1', @id, '1');


--5th insert
BEGIN TRAN;
INSERT INTO dbo.CustomerInfo (Fname, lname, Address, DateofBirth, Country, loginid, isMinor) 
VALUES ('Paul', 'Smith', '101 Frasier Street, TX 60541', '1996-08-17', 'United States', '5', '0');
SET @id = SCOPE_IDENTITY();

INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('101 Frasier Street', 'ShipAdd1','4429216011874242', 'United States', 'Zip1', @id, '0');
INSERT INTO dbo.ShippingAddress (BillAddress, ShipAddress, CreditCard, Country, BillZip, UserID, isPrimary) 
VALUES ('101 Frasier Street', 'ShippAdd2', '4429216011874242', 'United States','Zip2', @id, '1');
GO

--insert into shirts
INSERT INTO dbo.Shirts(BrandName, ShirtSize, ShirtPrice, ShirtQuantity, inStock)
VALUES ('RedHour', 'L', '15.00', '15', '1')
GO

INSERT INTO dbo.Shirts(BrandName, ShirtSize, ShirtPrice, ShirtQuantity, inStock)
VALUES ('RedHour', 'S', '15.00', '17', '1')
GO

INSERT INTO dbo.Shirts(BrandName, ShirtSize, ShirtPrice, ShirtQuantity, inStock)
VALUES ('Diamond', 'L', '20.00', '26', '1')
GO

INSERT INTO dbo.Shirts(BrandName, ShirtSize, ShirtPrice, ShirtQuantity, inStock)
VALUES ('Leviate', 'XL', '10.00', '28', '1')
GO

INSERT INTO dbo.Shirts(BrandName, ShirtSize, ShirtPrice, ShirtQuantity, inStock)
VALUES ('Leviate', 'M', '10.00', '14', '1')
GO

--insert for pants

INSERT INTO dbo.Pants(BrandName, PantSize, PantPrice, PantQuantity, inStock)
VALUES ('Levis', '36x30', '50.00', '14', '1')
GO

INSERT INTO dbo.Pants(BrandName, PantSize, PantPrice, PantQuantity, inStock)
VALUES ('Levis', '32x28', '20.00', '14', '1')
GO

INSERT INTO dbo.Pants(BrandName, PantSize, PantPrice, PantQuantity, inStock)
VALUES ('Gap', '30x28', '60.00', '14', '1')
GO

INSERT INTO dbo.Pants(BrandName, PantSize, PantPrice, PantQuantity, inStock)
VALUES ('Wrangler', '36x28', '20.00', '14', '1')
GO

INSERT INTO dbo.Pants(BrandName, PantSize, PantPrice, PantQuantity, inStock)
VALUES ('Wrangler', '30x28', '20.00', '14', '1')
GO

--insert for accessories
INSERT INTO dbo.Accessories(BrandName, AccessorySize, AccessoryPrice, AccessoryQuantity, inStock)
VALUES ('OtterBox', 'iPhoneXs', '40.00', '10', '1')
GO

INSERT INTO dbo.Accessories(BrandName, AccessorySize, AccessoryPrice, AccessoryQuantity, inStock)
VALUES ('47', 'Intern Hat', '30.00', '16', '1')
GO

INSERT INTO dbo.Accessories(BrandName, AccessorySize, AccessoryPrice, AccessoryQuantity, inStock)
VALUES ('FullSocks', '6-10', '16.00', '11', '1')
GO

INSERT INTO dbo.Accessories(BrandName, AccessorySize, AccessoryPrice, AccessoryQuantity, inStock)
VALUES ('J-earrings', '16g', '10.00', '10', '1')
GO

INSERT INTO dbo.Accessories(BrandName, AccessorySize, AccessoryPrice, AccessoryQuantity, inStock)
VALUES ('Apple', 'earbuds', '40.00', '15', '1')
GO


--insert for orders and purchases
DECLARE @Shipid int = '5'
DECLARE @OrderId int
DECLARE @UserId int

SELECT @UserId = UserID from dbo.ShippingAddress where @shipid = ShippingID

--1st insert
BEGIN TRAN;
INSERT INTO dbo.CustomerOrders(ShipSpeed, ShippingID, UserID)
VALUES ('3-5 day', @shipid, @UserId)
Set @UserId = SCOPE_IDENTITY();
Set @OrderId = SCOPE_IDENTITY();

INSERT INTO dbo.Purchase(OrderID, AccessoryID, PantID, ShirtID, AccessoryQuantity, PantQuantity, ShirtQuantity) 
VALUES (@orderId, '1', '1','2', '2', '1', '1');
GO

--insert for orders and purchases
DECLARE @Shipid int = '4'
DECLARE @OrderId int
DECLARE @UserId int

SELECT @UserId = UserID from dbo.ShippingAddress where @shipid = ShippingID

--1st insert
BEGIN TRAN;
INSERT INTO dbo.CustomerOrders(ShipSpeed, ShippingID, UserID)
VALUES ('1 day', @shipid, @UserId)
Set @UserId = SCOPE_IDENTITY();
Set @OrderId = SCOPE_IDENTITY();

INSERT INTO dbo.Purchase(OrderID, AccessoryID, PantID, ShirtID, AccessoryQuantity, PantQuantity, ShirtQuantity) 
VALUES (@orderId, NULL, '3','2', '0', '1', '2');
GO

--
DECLARE @Shipid int = '3'
DECLARE @OrderId int
DECLARE @UserId int

SELECT @UserId = UserID from dbo.ShippingAddress where @shipid = ShippingID

--1st insert
BEGIN TRAN;
INSERT INTO dbo.CustomerOrders(ShipSpeed, ShippingID, UserID)
VALUES ('1 day', @shipid, @UserId)
Set @UserId = SCOPE_IDENTITY();
Set @OrderId = SCOPE_IDENTITY();

INSERT INTO dbo.Purchase(OrderID, AccessoryID, PantID, ShirtID, AccessoryQuantity, PantQuantity, ShirtQuantity) 
VALUES (@orderId, NULL, '3','2', '0', '1', '2');

INSERT INTO dbo.Purchase(OrderID, AccessoryID, PantID, ShirtID, AccessoryQuantity, PantQuantity, ShirtQuantity) 
VALUES (@orderId, NULL, '5', NULL, '0', '1', '0')
GO 

--
DECLARE @Shipid int = '3'
DECLARE @OrderId int
DECLARE @UserId int

SELECT @UserId = UserID from dbo.ShippingAddress where @shipid = ShippingID

--1st insert
BEGIN TRAN;
INSERT INTO dbo.CustomerOrders(ShipSpeed, ShippingID, UserID)
VALUES ('2 day', @shipid, @UserId)
Set @UserId = SCOPE_IDENTITY();
Set @OrderId = SCOPE_IDENTITY();

INSERT INTO dbo.Purchase(OrderID, AccessoryID, PantID, ShirtID, AccessoryQuantity, PantQuantity, ShirtQuantity) 
VALUES (@orderId, NULL, '2','1', '0', '6', '2');
GO 


SELECT * FROM dbo.Shirts
SELECT * FROM dbo.ShippingAddress
SELECT * FROM dbo.CustomerOrders
SELECT * FROM dbo.Purchase
SELECT * FROM dbo.Customerinfo
SELECT * FROM dbo.CustomerLogin
SELECT * FROM dbo.Pants
SELECT * FROM dbo.Accessories




CREATE PROCEDURE dbo.updtpantsquantity
@quantity int,
@id int
AS
BEGIN
      UPDATE dbo.pants 
      SET PantQuantity = @quantity
      WHERE PantID = @id 
END

--
CREATE PROCEDURE dbo.deletepurchase
       @purchaseid  INT        
AS 
BEGIN 
     DELETE 
     FROM   dbo.Purchase
     WHERE  
     OrderID = @purchaseid
END
GO

exec dbo.deletepurchase
@purchaseid = '4'

exec dbo.updtpantsquantity
@quantity = '100',
@id = '1'






DROP TABLE dbo.Shirts
DROP TABLE dbo.Accessories
DROP TABLE dbo.Customerinfo
DROP TABLE dbo.CustomerLogin
DROP TABLE dbo.CustomerOrders
DROP TABLE dbo.Pants
DROP TABLE dbo.Purchase
DROP TABLE dbo.ShippingAddress


