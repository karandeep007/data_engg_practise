--Encryption and decryption of columns in SQL server.
--Lets assume we need to encrypt the credit card IDs in Sales schema of AdventureWorks DB

--1. Setup Encryption Keys

--1.1 Creates a database master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'super(not)securepwd'
--1.2 Verify key created
SELECT name KeyName, 
    symmetric_key_id KeyID, 
    key_length KeyLength, 
    algorithm_desc KeyAlgorithm
FROM sys.symmetric_keys;

--1.3 Creating a symmetric key to encrypt data
--Two Ways to create such a key A) certificate B) password
-- We will try method B, as moving passwords between 2 DB's has proved to be simpler than transferring certificates

CREATE SYMMETRIC KEY godrej_db_key WITH ALGORITHM = AES_256 ENCRYPTION BY Password = 'omg(not)securedagain'

--1.4 Verify Key created using 1.2

--2. Great! we are all set to encrypt our data now.

--2.1 Let's add a column that will recieve out 'encrypted' credit card id, VARBINARY is the data type in which the output of EncryptBy() can be stored.
-- Just keeping max for ease.
-- We will also be adding an 'authenticator' to prevent 'whole-value-substitution' attack on encrypted value/
-- refer for more info: https://learn.microsoft.com/en-us/sql/t-sql/functions/encryptbykey-transact-sql?view=sql-server-ver16#remarks
alter table Sales.CreditCard
drop column secure_cardnumber varbinary(128)

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY godrej_db_key DECRYPTION BY Password = 'omg(not)securedagain'

-- authenticator : CreditCardID
UPDATE Sales.CreditCard  
SET secure_cardnumber = EncryptByKey(Key_GUID('godrej_db_key'),   
    CardNumber, 1, CONVERT( varbinary, CreditCardID) );  

select * from Sales.CreditCard 

-- 3. Amazing! We encrypted out credit card numbers. Lets try to retrieve it

OPEN SYMMETRIC KEY godrej_db_key DECRYPTION BY Password = 'omg(not)securedagain'


SELECT CreditCardID, CardType, secure_cardnumber,
CONVERT(nvarchar, 
	DecryptByKey(secure_cardnumber, 1,CONVERT(varbinary, CreditCardID)
	)
) AS 'Decrypted Card Number', CardNumber
FROM Sales.CreditCard 

--FYI if Convert 'nvarchar' doesn't work, try convert 'varchar'
-- That's all folks
-- Further reading: https://www.sqlshack.com/an-overview-of-the-column-level-sql-server-encryption/
