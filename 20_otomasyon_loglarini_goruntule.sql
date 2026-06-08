USE BLM4522_OtomasyonProjesi;
GO

SELECT
    LogID,
    VeritabaniAdi,
    YedekTuru,
    DosyaYolu,
    BasariliMi,
    IslemBaslangic,
    IslemBitis,
    HataMesaji,
    Kaynak
FROM dbo.YedeklemeOtomasyonLogu
ORDER BY LogID DESC;
GO

SELECT
    UyariID,
    VeritabaniAdi,
    UyariTuru,
    Aciklama,
    UyariZamani
FROM dbo.YedekKontrolUyariLogu
ORDER BY UyariID DESC;
GO
