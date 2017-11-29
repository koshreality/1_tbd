CREATE TABLE [dbo].[user] (
  [user_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](50) NOT NULL,
  [surname] [varchar](50) NULL,
  [patronymic] [varchar](50) NULL,
  [date_of_birth] [date] NULL,
  [nationality_region_id] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_user_user_id] PRIMARY KEY NONCLUSTERED ([user_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_user]
  ON [dbo].[user] ([name], [surname], [patronymic], [date_of_birth], [nationality_region_id], [creation_datetime] DESC)
  ON [Department_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [user_AFTER_DELETE_trigger]
ON [dbo].[user]
AFTER DELETE
AS
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT user_id FROM DELETED WHERE has_description = 1)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [user_AFTER_INSERT_UPDATE_trigger]
ON [dbo].[user]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN department_descriptions dd ON user_id = dd.entity_id WHERE has_description = 1 AND dd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT user_id FROM INSERTED WHERE has_description = 0)
GO

ALTER TABLE [dbo].[user] WITH NOCHECK
  ADD CONSTRAINT [FK_user_nationality_region_id] FOREIGN KEY ([nationality_region_id]) REFERENCES [dbo].[region] ([region_id])
GO