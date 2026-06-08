USE BLM4522_OtomasyonProjesi;
GO

CREATE OR ALTER PROCEDURE dbo.usp_YedekGecmisiRaporu
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        bs.database_name AS VeritabaniAdi,
        CASE bs.type
            WHEN 'D' THEN N'Tam Yedek'
            WHEN 'I' THEN N'Fark Yedeği'
            WHEN 'L' THEN N'Log Yedeği'
            ELSE bs.type
        END AS YedekTuru,
        bs.backup_start_date AS BaslangicZamani,
        bs.backup_finish_date AS BitisZamani,
        CAST(bs.backup_size / 1024.0 / 1024.0 AS DECIMAL(18,2)) AS Boyut_MB,
        CAST(bs.compressed_backup_size / 1024.0 / 1024.0 AS DECIMAL(18,2)) AS SikistirilmisBoyut_MB,
        bmf.physical_device_name AS DosyaYolu
    FROM msdb.dbo.backupset AS bs
    INNER JOIN msdb.dbo.backupmediafamily AS bmf
        ON bs.media_set_id = bmf.media_set_id
    WHERE bs.database_name = N'BLM4522_OtomasyonProjesi'
    ORDER BY bs.backup_finish_date DESC;
END;
GO
