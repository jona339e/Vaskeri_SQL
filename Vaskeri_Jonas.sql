USE Master
GO
IF DB_ID('BBBDB') IS NOT NULL
	BEGIN
		ALTER DATABASE BBBDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE BBBDB
	END
GO
CREATE DATABASE BBBDB
GO
USE BBBDB
GO

CREATE TABLE Vaskerier (
ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Navn NVARCHAR(255),
Åbner Time(0),
Lukker Time(0),
)

CREATE TABLE Bruger (
ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
BrugerNavn NVARCHAR(255),
Email NVARCHAR(255) UNIQUE,
[Password] NVARCHAR(255),
check (LEN([Password]) >= 5),
Konto Decimal(8,2),
VaskeriID int FOREIGN KEY REFERENCES Vaskerier(ID),
Oprettet date
)

CREATE TABLE Maskiner (
ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
MaskineNavn NVARCHAR(255),
PrisPrVask Decimal(7,2),
VaskeTid int,
VaskeriID int FOREIGN KEY REFERENCES Vaskerier(ID)
)

CREATE TABLE BOOKING (
ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
Tidspunk smalldatetime,
BrugerID int FOREIGN KEY REFERENCES Bruger(ID),
MaskineID int FOREIGN KEY REFERENCES Maskiner(ID),
)

INSERT INTO Vaskerier VALUES ('Whitewash inc.', '08:00', '20:00')
INSERT INTO Vaskerier VALUES ('Double Bubble', '02:00', '22:00')
INSERT INTO Vaskerier VALUES ('Wash & Coffee', '12:00', '20:00')

INSERT INTO Bruger VALUES('John', 'John_doe66@gmail.com', 'password', 100.00, 2, '2021-02-15')
INSERT INTO Bruger VALUES('Neil Armstrong', 'firstman@nasa.gov', 'eagleLander69', 1000.00, 1, '2021-02-10')
INSERT INTO Bruger VALUES('Batman', 'noreply@thecave.com', 'Rob1n', 500.00, 3, '2020-03-10')
INSERT INTO Bruger VALUES('Goldman Sachs', 'moneylaundering@gs.com', 'NotRecognized', 100000.00, 1, '2021-01-01')
INSERT INTO Bruger VALUES('50 Cent', '50cent@gmail.com', 'ItsMyBirthday', 0.50, 3, '2020-07-06')


INSERT INTO Maskiner VALUES ('Mielle 911 Turbo', 5.00, 60, 2)
INSERT INTO Maskiner VALUES ('Siemons IClean', 10000.00, 30, 1)
INSERT INTO Maskiner VALUES ('Electrolax FX-2', 15.00, 45, 2)
INSERT INTO Maskiner VALUES ('NASA Spacewasher 8000', 500.00, 5, 1)
INSERT INTO Maskiner VALUES ('The Lost Sock', 3.50, 90, 3)
INSERT INTO Maskiner VALUES ('Yo Mama', 0.50 , 120, 3)


INSERT INTO BOOKING VALUES ('2021-02-26 12:00:00', 1, 1)
INSERT INTO BOOKING VALUES ('2021-02-26 16:00:00', 1, 3)
INSERT INTO BOOKING VALUES ('2021-02-26 08:00:00', 2, 4)
INSERT INTO BOOKING VALUES ('2021-02-26 15:00:00', 3, 5)
INSERT INTO BOOKING VALUES ('2021-02-26 20:00:00', 4, 2)
INSERT INTO BOOKING VALUES ('2021-02-26 19:00:00', 4, 2)
INSERT INTO BOOKING VALUES ('2021-02-26 10:00:00', 4, 2)
INSERT INTO BOOKING VALUES ('2021-02-26 16:00:00', 5, 6)


BEGIN TRAN T1
INSERT INTO BOOKING VALUES('2020-09-15 12:00', 4, 2)
COMMIT

go
CREATE VIEW OverallView AS 
	SELECT BOOKING.Tidspunk, Bruger.BrugerNavn, Maskiner.MaskineNavn, Maskiner.PrisPrVask FROM BOOKING
	JOIN Bruger ON BOOKING.BrugerID = Bruger.ID
	JOIN Maskiner ON BOOKING.MaskineID = Maskiner.ID
go

Select * FROM OverallView

SELECT * FROM Bruger WHERE Email LIKE '%@gmail.com'

SELECT * FROM Maskiner JOIN Vaskerier ON Maskiner.VaskeriID = Vaskerier.ID

SELECT Maskiner.MaskineNavn ,COUNT(booking.MaskineID) AS Bookinger From Maskiner
JOIN BOOKING on booking.maskineID = maskiner.ID
Group By Maskiner.MaskineNavn

DELETE FROM BOOKING WHERE CAST(Tidspunk as time(0)) BETWEEN '12:00:00' AND '14:00:00'

Update Bruger set [Password] = 'SelinaKyle' where BrugerNavn = 'Batman'



