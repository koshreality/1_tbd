SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4439454343383435]as select  [user_answer_id],[request_id],[answer_variant_id],[has_description],[submitted_at],[reviewed_at],[reviewed_by],[grade]  from  [dbo].[user_answer]  where HAS_PERMS_BY_NAME('[dbo].[user_answer]', 'OBJECT', 'SELECT')= 1  
GO