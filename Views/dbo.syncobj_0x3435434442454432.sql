SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3435434442454432]as select  [test_id],[name],[cert_type_id],[creation_datetime]  from  [dbo].[test]  where HAS_PERMS_BY_NAME('[dbo].[test]', 'OBJECT', 'SELECT')= 1  
GO