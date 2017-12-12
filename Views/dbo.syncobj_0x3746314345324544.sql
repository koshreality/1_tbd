SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3746314345324544]as select  [user_id],[name],[surname],[patronymic],[date_of_birth],[nationality_region_id],[creation_datetime],[has_description]  from  [dbo].[user]  where HAS_PERMS_BY_NAME('[dbo].[user]', 'OBJECT', 'SELECT')= 1  
GO