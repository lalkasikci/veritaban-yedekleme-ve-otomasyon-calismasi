/*
OPSİYONEL DOSYA
Önce 21_opsiyonel_database_mail_operator.sql dosyasını kendi bilgilerinle düzenleyip çalıştır.

Bu dosya dört job için hata durumunda e-posta bildirimi bağlar.
*/

USE msdb;
GO

/*
EXEC dbo.sp_update_job
    @job_name = N'BLM4522 - Günlük Tam Yedek',
    @notify_level_email = 2,
    @notify_email_operator_name = N'BLM4522_Yonetici';

EXEC dbo.sp_update_job
    @job_name = N'BLM4522 - Fark Yedeği',
    @notify_level_email = 2,
    @notify_email_operator_name = N'BLM4522_Yonetici';

EXEC dbo.sp_update_job
    @job_name = N'BLM4522 - Saatlik Log Yedeği',
    @notify_level_email = 2,
    @notify_email_operator_name = N'BLM4522_Yonetici';

EXEC dbo.sp_update_job
    @job_name = N'BLM4522 - Yedek Durumu Kontrol',
    @notify_level_email = 2,
    @notify_email_operator_name = N'BLM4522_Yonetici';
GO
*/
