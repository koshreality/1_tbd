SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x4134433832343044]as select  [answer_id],[something],[has_description],[creation_datetime]  from  [dbo].[answer]  where HAS_PERMS_BY_NAME('[dbo].[answer]', 'OBJECT', 'SELECT')= 1  
GO