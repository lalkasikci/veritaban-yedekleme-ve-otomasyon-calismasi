USE master;
GO

ALTER DATABASE BLM4522_OtomasyonProjesi
SET RECOVERY FULL;
GO

SELECT
    name AS VeritabaniAdi,
    recovery_model_desc AS RecoveryModel
FROM sys.databases
WHERE name = N'BLM4522_OtomasyonProjesi';
GO
