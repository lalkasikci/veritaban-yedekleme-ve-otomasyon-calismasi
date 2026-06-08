USE BLM4522_OtomasyonProjesi;
GO

/* Önce veride değişiklik yaparak transaction log oluştur */
INSERT INTO dbo.Siparisler (MusteriAdi, ToplamTutar)
VALUES (N'Log Yedeği Test Kaydı', 250.00);
GO

EXEC dbo.usp_LogYedegiAl;
GO
