SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3243423443383535]as select  [attachment_id],[data],[creation_datetime],[attach_type_id],[name]  from  [dbo].[head_attachments]  with (index([PK_head_attachments_attach_id]))  where HAS_PERMS_BY_NAME('[dbo].[head_attachments]', 'OBJECT', 'SELECT')= 1  
GO