USE BLM4522_OtomasyonProjesi;
GO

CREATE OR ALTER PROCEDURE dbo.usp_YedekDurumuKontrolEt
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SonTamYedek DATETIME;
    DECLARE @SonFarkYedegi DATETIME;
    DECLARE @SonLogYedegi DATETIME;

    SELECT @SonTamYedek = MAX(backup_finish_date)
    FROM msdb.dbo.backupset
    WHERE database_name = N'BLM4522_OtomasyonProjesi'
      AND type = 'D';

    SELECT @SonFarkYedegi = MAX(backup_finish_date)
    FROM msdb.dbo.backupset
    WHERE database_name = N'BLM4522_OtomasyonProjesi'
      AND type = 'I';

    SELECT @SonLogYedegi = MAX(backup_finish_date)
    FROM msdb.dbo.backupset
    WHERE database_name = N'BLM4522_OtomasyonProjesi'
      AND type = 'L';

    IF @SonTamYedek IS NULL OR @SonTamYedek < DATEADD(DAY, -1, GETDATE())
    BEGIN
        INSERT INTO dbo.YedekKontrolUyariLogu
        (VeritabaniAdi, UyariTuru, Aciklama)
        VALUES
        (
            N'BLM4522_OtomasyonProjesi',
            N'TAM YEDEK UYARISI',
            N'Son 24 saat içinde tam yedek alınmamıştır.'
        );
    END;

    IF @SonFarkYedegi IS NULL OR @SonFarkYedegi < DATEADD(HOUR, -12, GETDATE())
    BEGIN
        INSERT INTO dbo.YedekKontrolUyariLogu
        (VeritabaniAdi, UyariTuru, Aciklama)
        VALUES
        (
            N'BLM4522_OtomasyonProjesi',
            N'FARK YEDEĞİ UYARISI',
            N'Son 12 saat içinde fark yedeği alınmamıştır.'
        );
    END;

    IF @SonLogYedegi IS NULL OR @SonLogYedegi < DATEADD(HOUR, -1, GETDATE())
    BEGIN
        INSERT INTO dbo.YedekKontrolUyariLogu
        (VeritabaniAdi, UyariTuru, Aciklama)
        VALUES
        (
            N'BLM4522_OtomasyonProjesi',
            N'LOG YEDEĞİ UYARISI',
            N'Son 1 saat içinde transaction log yedeği alınmamıştır.'
        );
    END;

    SELECT
        @SonTamYedek AS SonTamYedek,
        @SonFarkYedegi AS SonFarkYedegi,
        @SonLogYedegi AS SonLogYedegi;
END;
GO
