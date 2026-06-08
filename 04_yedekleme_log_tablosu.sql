USE BLM4522_OtomasyonProjesi;
GO

IF OBJECT_ID(N'dbo.YedeklemeOtomasyonLogu', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.YedeklemeOtomasyonLogu
    (
        LogID               BIGINT IDENTITY(1,1) PRIMARY KEY,
        VeritabaniAdi       SYSNAME NOT NULL,
        YedekTuru           NVARCHAR(20) NOT NULL,
        DosyaYolu           NVARCHAR(500) NULL,
        BasariliMi          BIT NOT NULL,
        IslemBaslangic      DATETIME2(0) NOT NULL,
        IslemBitis          DATETIME2(0) NOT NULL,
        HataMesaji          NVARCHAR(2000) NULL,
        Kaynak              NVARCHAR(100) NOT NULL DEFAULT N'T-SQL'
    );
END;
GO

IF OBJECT_ID(N'dbo.YedekKontrolUyariLogu', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.YedekKontrolUyariLogu
    (
        UyariID             BIGINT IDENTITY(1,1) PRIMARY KEY,
        VeritabaniAdi       SYSNAME NOT NULL,
        UyariTuru           NVARCHAR(100) NOT NULL,
        Aciklama            NVARCHAR(1000) NOT NULL,
        UyariZamani         DATETIME2(0) NOT NULL DEFAULT SYSDATETIME()
    );
END;
GO
