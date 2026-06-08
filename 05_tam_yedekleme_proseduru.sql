USE BLM4522_OtomasyonProjesi;
GO

CREATE OR ALTER PROCEDURE dbo.usp_TamYedekAl
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Baslangic DATETIME2(0) = SYSDATETIME();
    DECLARE @Bitis DATETIME2(0);
    DECLARE @Dosya NVARCHAR(500);
    DECLARE @Sql NVARCHAR(MAX);

    SET @Dosya =
        N'C:\SQLBackup\BLM4522\BLM4522_OtomasyonProjesi_FULL_' +
        CONVERT(CHAR(8), GETDATE(), 112) + N'_' +
        REPLACE(CONVERT(CHAR(8), GETDATE(), 108), ':', '') + N'.bak';

    BEGIN TRY
        SET @Sql =
            N'BACKUP DATABASE BLM4522_OtomasyonProjesi
              TO DISK = N''' + REPLACE(@Dosya, '''', '''''') + N'''
              WITH INIT, COMPRESSION, CHECKSUM, STATS = 10;';

        EXEC sys.sp_executesql @Sql;

        SET @Bitis = SYSDATETIME();

        INSERT INTO dbo.YedeklemeOtomasyonLogu
        (
            VeritabaniAdi, YedekTuru, DosyaYolu, BasariliMi,
            IslemBaslangic, IslemBitis, HataMesaji
        )
        VALUES
        (
            N'BLM4522_OtomasyonProjesi', N'TAM', @Dosya, 1,
            @Baslangic, @Bitis, NULL
        );
    END TRY
    BEGIN CATCH
        SET @Bitis = SYSDATETIME();

        INSERT INTO dbo.YedeklemeOtomasyonLogu
        (
            VeritabaniAdi, YedekTuru, DosyaYolu, BasariliMi,
            IslemBaslangic, IslemBitis, HataMesaji
        )
        VALUES
        (
            N'BLM4522_OtomasyonProjesi', N'TAM', @Dosya, 0,
            @Baslangic, @Bitis, ERROR_MESSAGE()
        );

        THROW;
    END CATCH;
END;
GO
