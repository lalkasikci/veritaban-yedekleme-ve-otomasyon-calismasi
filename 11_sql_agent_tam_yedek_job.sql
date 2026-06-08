USE msdb;
GO

IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'BLM4522 - Günlük Tam Yedek')
    EXEC dbo.sp_delete_job @job_name = N'BLM4522 - Günlük Tam Yedek';
GO

EXEC dbo.sp_add_job
    @job_name = N'BLM4522 - Günlük Tam Yedek',
    @enabled = 1,
    @description = N'BLM4522_OtomasyonProjesi için her gün tam yedek alır.';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'BLM4522 - Günlük Tam Yedek',
    @step_name = N'Tam yedek prosedürünü çalıştır',
    @subsystem = N'TSQL',
    @database_name = N'BLM4522_OtomasyonProjesi',
    @command = N'EXEC dbo.usp_TamYedekAl;',
    @on_success_action = 1,
    @on_fail_action = 2;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'BLM4522 - Her Gün 02:00',
    @freq_type = 4,
    @freq_interval = 1,
    @active_start_time = 020000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'BLM4522 - Günlük Tam Yedek',
    @schedule_name = N'BLM4522 - Her Gün 02:00';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'BLM4522 - Günlük Tam Yedek';
GO
