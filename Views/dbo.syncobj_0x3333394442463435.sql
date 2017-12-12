SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3333394442463435]as select  [grade_crit_id],[has_description],[creation_datetime],[max_grade],[something]  from  [dbo].[grade_criteria]  where HAS_PERMS_BY_NAME('[dbo].[grade_criteria]', 'OBJECT', 'SELECT')= 1  
GO