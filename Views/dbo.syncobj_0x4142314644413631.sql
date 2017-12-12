SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4142314644413631]as select  [exam_id],[test_id],[dep_id],[beginning],[ending],[creation_datetime],[conducted_by],[something],[price]  from  [dbo].[exam]  where HAS_PERMS_BY_NAME('[dbo].[exam]', 'OBJECT', 'SELECT')= 1  
GO