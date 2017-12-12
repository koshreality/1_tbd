SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3841313331323846]as select  [attach_id],[creation_datetime],[data],[attach_type_id],[name]  from  [dbo].[dep_attachments]  with (index([PK_dep_attachments_attach_id2]))  where HAS_PERMS_BY_NAME('[dbo].[dep_attachments]', 'OBJECT', 'SELECT')= 1  
GO