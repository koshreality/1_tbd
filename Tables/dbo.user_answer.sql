CREATE TABLE [dbo].[user_answer] (
  [user_answer_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [request_id] [uniqueidentifier] NOT NULL,
  [answer_variant_id] [uniqueidentifier] NULL,
  [has_description] [bit] NOT NULL DEFAULT (0),
  [submitted_at] [datetime] NOT NULL DEFAULT (getdate()),
  [reviewed_at] [datetime] NULL,
  [reviewed_by] [uniqueidentifier] NULL,
  [grade] [float] NULL,
  CONSTRAINT [PK_user_answer_user_answer_id2] PRIMARY KEY NONCLUSTERED ([user_answer_id]) ON [Department_Filegroup]
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_user_answer_submitted_at]
  ON [dbo].[user_answer] ([submitted_at])
  ON [Head_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger8]
ON [dbo].[user_answer]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN department_descriptions dd ON user_answer_id = dd.entity_id WHERE has_description = 1 AND dd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
GO

ALTER TABLE [dbo].[user_answer]
  ADD CONSTRAINT [FK_user_answer_answer_variant_id] FOREIGN KEY ([answer_variant_id]) REFERENCES [dbo].[question_test_answer_variant] ([answer_variant_id])
GO

ALTER TABLE [dbo].[user_answer]
  ADD CONSTRAINT [FK_user_answer_request_id] FOREIGN KEY ([request_id]) REFERENCES [dbo].[exam_request] ([request_id])
GO

ALTER TABLE [dbo].[user_answer]
  ADD CONSTRAINT [FK_user_answer_reviewed_by] FOREIGN KEY ([reviewed_by]) REFERENCES [dbo].[user] ([user_id])
GO