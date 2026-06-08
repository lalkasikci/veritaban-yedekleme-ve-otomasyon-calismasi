USE master;
GO

/*
Bu prosedür msdb içindeki xp_delete_file yordamını kullanarak
14 günden eski yedek dosyalarını temizler.
*/

CREATE OR ALTER PROCEDURE dbo.usp_BLM4522_EskiYedekleriTemizle
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SilmeSiniri DATETIME = DATEADD(DAY, -14, GETDATE());

    EXEC master.dbo.xp_delete_file
        0,
        N'C:\SQLBackup\BLM4522',
        N'bak',
        @SilmeSiniri,
        1;

    EXEC master.dbo.xp_delete_file
        0,
        N'C:\SQLBackup\BLM4522',
        N'trn',
        @SilmeSiniri,
        1;
END;
GO
