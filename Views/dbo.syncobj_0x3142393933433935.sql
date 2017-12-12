SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
create view [dbo].[syncobj_0x3142393933433935]as select  [request_id],[user_id],[exam_id],[attended],[creation_datetime],[grade],[something],[has_description]  from  [dbo].[exam_request]  where HAS_PERMS_BY_NAME('[dbo].[exam_request]', 'OBJECT', 'SELECT')= 1  
GO