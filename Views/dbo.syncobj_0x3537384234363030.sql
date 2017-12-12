SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3537384234363030]as select  [dep_id],[region_id],[name],[creation_datetime]  from  [dbo].[department]  where HAS_PERMS_BY_NAME('[dbo].[department]', 'OBJECT', 'SELECT')= 1  
GO