CREATE TABLE [dbo].[question] (
  [quest_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](200) NOT NULL,
  [quest_type_id] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_question_quest_id] PRIMARY KEY NONCLUSTERED ([quest_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_question_creation_datetime]
  ON [dbo].[question] ([creation_datetime])
  ON [Head_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger4]
ON [dbo].[question]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN head_descriptions hd ON quest_id = hd.entity_id WHERE has_description = 1 AND hd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
GO

ALTER TABLE [dbo].[question]
  ADD CONSTRAINT [FK_question_quest_type_id] FOREIGN KEY ([quest_type_id]) REFERENCES [dbo].[question_type] ([quest_type_id])
GO