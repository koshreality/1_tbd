SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4439314131463642]as select  [sec_type_id],[name],[has_description],[creation_datetime],[something]  from  [dbo].[section_type]  where HAS_PERMS_BY_NAME('[dbo].[section_type]', 'OBJECT', 'SELECT')= 1  
GO