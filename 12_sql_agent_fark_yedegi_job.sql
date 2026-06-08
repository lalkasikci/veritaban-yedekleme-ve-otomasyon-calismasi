USE msdb;
GO

IF EXISTS (SELECT 1 FROM dbo.sysjobs WHERE name = N'BLM4522 - Fark Yedeği')
    EXEC dbo.sp_delete_job @job_name = N'BLM4522 - Fark Yedeği';
GO

EXEC dbo.sp_add_job
    @job_name = N'BLM4522 - Fark Yedeği',
    @enabled = 1,
    @description = N'BLM4522_OtomasyonProjesi için 6 saatte bir fark yedeği alır.';
GO

EXEC dbo.sp_add_jobstep
    @job_name = N'BLM4522 - Fark Yedeği',
    @step_name = N'Fark yedeği prosedürünü çalıştır',
    @subsystem = N'TSQL',
    @database_name = N'BLM4522_OtomasyonProjesi',
    @command = N'EXEC dbo.usp_FarkYedegiAl;',
    @on_success_action = 1,
    @on_fail_action = 2;
GO

EXEC dbo.sp_add_schedule
    @schedule_name = N'BLM4522 - 6 Saatte Bir Fark Yedeği',
    @freq_type = 4,
    @freq_interval = 1,
    @freq_subday_type = 8,
    @freq_subday_interval = 6,
    @active_start_time = 030000;
GO

EXEC dbo.sp_attach_schedule
    @job_name = N'BLM4522 - Fark Yedeği',
    @schedule_name = N'BLM4522 - 6 Saatte Bir Fark Yedeği';
GO

EXEC dbo.sp_add_jobserver
    @job_name = N'BLM4522 - Fark Yedeği';
GO
