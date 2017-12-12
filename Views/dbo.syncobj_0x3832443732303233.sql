SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3832443732303233]as select  [quest_type_id],[quest_type],[sec_type_id],[grade_criteria],[creation_datetime],[manual_grading]  from  [dbo].[question_type]  where HAS_PERMS_BY_NAME('[dbo].[question_type]', 'OBJECT', 'SELECT')= 1  
GO