USE BLM4522_OtomasyonProjesi;
GO

IF OBJECT_ID(N'dbo.Siparisler', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.Siparisler
    (
        SiparisID       INT IDENTITY(1,1) PRIMARY KEY,
        MusteriAdi      NVARCHAR(120) NOT NULL,
        ToplamTutar     DECIMAL(12,2) NOT NULL,
        SiparisTarihi   DATETIME2(0) NOT NULL DEFAULT SYSDATETIME()
    );
END;
GO

INSERT INTO dbo.Siparisler (MusteriAdi, ToplamTutar)
VALUES
(N'Ayşe Yılmaz', 1250.50),
(N'Mehmet Kaya', 875.00),
(N'Zeynep Demir', 430.75),
(N'Can Akın', 1999.90);
GO

SELECT * FROM dbo.Siparisler;
GO
