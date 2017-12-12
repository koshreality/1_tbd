SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4442354537324636]as select  [answer_variant_id],[question_id],[answer_id],[is_right],[creation_datetime],[something]  from  [dbo].[question_answer_variant]  where HAS_PERMS_BY_NAME('[dbo].[question_answer_variant]', 'OBJECT', 'SELECT')= 1  
GO