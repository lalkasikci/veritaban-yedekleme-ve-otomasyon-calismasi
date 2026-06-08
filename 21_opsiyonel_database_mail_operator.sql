/*
OPSİYONEL DOSYA
Database Mail ve SQL Server Agent Operator örneğidir.

DİKKAT:
- SMTP ayarlarını kendi e-posta sağlayıcına göre değiştirmelisin.
- Bu dosya yüksek yetki gerektirir.
- Parolayı düz metin olarak GitHub'a yükleme.
*/

USE master;
GO

EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
GO

EXEC sp_configure 'Database Mail XPs', 1;
RECONFIGURE;
GO

/*
Aşağıdaki örneği kendi SMTP bilgilerinle düzenledikten sonra yorum işaretlerini kaldır.

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = N'BLM4522_MailHesabi',
    @description = N'BLM4522 yedekleme bildirim hesabı',
    @email_address = N'ornek@example.com',
    @display_name = N'SQL Server Yedekleme Sistemi',
    @mailserver_name = N'smtp.example.com',
    @port = 587,
    @enable_ssl = 1,
    @username = N'ornek@example.com',
    @password = N'PAROLAYI_GITHUBA_YUKLEME';
GO

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = N'BLM4522_MailProfili',
    @description = N'BLM4522 Database Mail profili';
GO

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = N'BLM4522_MailProfili',
    @account_name = N'BLM4522_MailHesabi',
    @sequence_number = 1;
GO

EXEC msdb.dbo.sp_add_operator
    @name = N'BLM4522_Yonetici',
    @enabled = 1,
    @email_address = N'ornek@example.com';
GO
*/
