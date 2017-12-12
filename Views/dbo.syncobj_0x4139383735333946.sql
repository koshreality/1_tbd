SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4139383735333946]as select  [role_id],[name]  from  [dbo].[roles]  where HAS_PERMS_BY_NAME('[dbo].[roles]', 'OBJECT', 'SELECT')= 1  
GO