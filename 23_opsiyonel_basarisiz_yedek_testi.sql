USE BLM4522_OtomasyonProjesi;
GO

/*
Bu sorgu yalnızca demo amaçlıdır.
Geçersiz klasör yolu kullanıldığı için yedekleme başarısız olur.
TRY-CATCH sayesinde hata log tablosuna kaydedilir.
*/

DECLARE @Baslangic DATETIME2(0) = SYSDATETIME();
DECLARE @Bitis DATETIME2(0);
DECLARE @Dosya NVARCHAR(500) =
    N'Z:\OlmayanKlasor\BLM4522_HATALI_TEST.bak';

BEGIN TRY
    BACKUP DATABASE BLM4522_OtomasyonProjesi
    TO DISK = @Dosya
    WITH INIT, CHECKSUM;

    SET @Bitis = SYSDATETIME();

    INSERT INTO dbo.YedeklemeOtomasyonLogu
    (
        VeritabaniAdi, YedekTuru, DosyaYolu, BasariliMi,
        IslemBaslangic, IslemBitis, HataMesaji
    )
    VALUES
    (
        N'BLM4522_OtomasyonProjesi', N'HATALI TEST', @Dosya, 1,
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
        N'BLM4522_OtomasyonProjesi', N'HATALI TEST', @Dosya, 0,
        @Baslangic, @Bitis, ERROR_MESSAGE()
    );

    SELECT
        N'Beklenen hata oluştu ve log tablosuna kaydedildi.' AS Aciklama,
        ERROR_MESSAGE() AS HataMesaji;
END CATCH;
GO
