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
CREATE TRIGGER [trigger7]
ON [dbo].[exam_request]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN department_descriptions dd ON request_id = dd.entity_id WHERE has_description = 1 AND dd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
GO

ALTER TABLE [dbo].[exam_request]
  ADD CONSTRAINT [FK_exam_request_exam_id] FOREIGN KEY ([exam_id]) REFERENCES [dbo].[exam] ([exam_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[exam_request]
  ADD CONSTRAINT [FK_exam_request_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO