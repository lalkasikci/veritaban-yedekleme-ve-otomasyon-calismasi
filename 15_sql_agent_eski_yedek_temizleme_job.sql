USE msdb;
GO

IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'BLM4522 - Eski Yedekleri Temizle')
    EXEC dbo.sp_delete_job @job_name = N'BLM4522 - Eski Yedekleri Temizle';
GO

EXEC dbo.sp_add_job
    @job_name = N'BLM4522 - Eski Yedekleri Temizle',
    @enabled = 1,
    @description = N'14 günden eski bak ve trn dosyalarını temizler.';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'BLM4522 - Eski Yedekleri Temizle',
    @step_name = N'Eski yedekleri temizle',
    @subsystem = N'TSQL',
    @database_name = N'master',
    @command = N'EXEC dbo.usp_BLM4522_EskiYedekleriTemizle;',
    @on_success_action = 1,
    @on_fail_action = 2;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'BLM4522 - Haftalık Temizlik',
    @freq_type = 8,
    @freq_interval = 1,
    @active_start_time = 040000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'BLM4522 - Eski Yedekleri Temizle',
    @schedule_name = N'BLM4522 - Haftalık Temizlik';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'BLM4522 - Eski Yedekleri Temizle';
GO
