SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4346394241363336]as select  [region_id],[country],[region],[city],[town],[village],[street],[creation_datetime]  from  [dbo].[region]  where HAS_PERMS_BY_NAME('[dbo].[region]', 'OBJECT', 'SELECT')= 1  
GO