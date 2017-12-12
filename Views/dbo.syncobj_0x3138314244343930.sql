SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3138314244343930]as select  [att_type_id],[name],[creation_datetime]  from  [dbo].[attachment_type]  where HAS_PERMS_BY_NAME('[dbo].[attachment_type]', 'OBJECT', 'SELECT')= 1  
GO