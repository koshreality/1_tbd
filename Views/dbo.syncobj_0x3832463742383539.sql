SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3832463742383539]as select  [quest_id],[name],[quest_type_id],[creation_datetime],[has_description]  from  [dbo].[question]  where HAS_PERMS_BY_NAME('[dbo].[question]', 'OBJECT', 'SELECT')= 1  
GO