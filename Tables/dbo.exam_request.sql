CREATE TABLE [dbo].[exam_request] (
  [request_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [user_id] [uniqueidentifier] NOT NULL,
  [exam_id] [uniqueidentifier] NOT NULL,
  [attended] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [grade] [float] NULL,
  [something] [varchar](100) NULL,
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_exam_request_request_id] PRIMARY KEY NONCLUSTERED ([request_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE CLUSTERED INDEX [UK_exam_request_creation_datetime]
  ON [dbo].[exam_request] ([creation_datetime] DESC)
  ON [Department_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [exam_request_AFTER_INSERT_UPDATE_trigger]
ON [dbo].[exam_request]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN department_descriptions dd ON request_id = dd.entity_id WHERE has_description = 1 AND dd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT request_id FROM INSERTED WHERE has_description = 0)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [exam_request_AFTER_DELETE_trigger]
ON [dbo].[exam_request]
AFTER DELETE
AS
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT request_id FROM DELETED WHERE has_description = 1)
GO

ALTER TABLE [dbo].[exam_request] WITH NOCHECK
  ADD CONSTRAINT [FK_exam_request_exam_id] FOREIGN KEY ([exam_id]) REFERENCES [dbo].[exam] ([exam_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[exam_request] WITH NOCHECK
  ADD CONSTRAINT [FK_exam_request_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO