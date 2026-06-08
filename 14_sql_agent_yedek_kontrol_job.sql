USE msdb;
GO

IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'BLM4522 - Yedek Durumu Kontrol')
    EXEC dbo.sp_delete_job @job_name = N'BLM4522 - Yedek Durumu Kontrol';
GO

EXEC dbo.sp_add_job
    @job_name = N'BLM4522 - Yedek Durumu Kontrol',
    @enabled = 1,
    @description = N'Yedeklerin zamanında alınıp alınmadığını kontrol eder.';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'BLM4522 - Yedek Durumu Kontrol',
    @step_name = N'Yedek kontrol prosedürünü çalıştır',
    @subsystem = N'TSQL',
    @database_name = N'BLM4522_OtomasyonProjesi',
    @command = N'EXEC dbo.usp_YedekDurumuKontrolEt;',
    @on_success_action = 1,
    @on_fail_action = 2;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'BLM4522 - Her Gün 08:00 Kontrol',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 080000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'BLM4522 - Yedek Durumu Kontrol',
    @schedule_name = N'BLM4522 - Her Gün 08:00 Kontrol';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'BLM4522 - Yedek Durumu Kontrol';
GO
