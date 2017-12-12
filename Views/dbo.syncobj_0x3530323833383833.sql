SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3530323833383833]as select  [cert_type_id],[something],[creation_datetime],[has_description]  from  [dbo].[cert_type]  where HAS_PERMS_BY_NAME('[dbo].[cert_type]', 'OBJECT', 'SELECT')= 1  
GO