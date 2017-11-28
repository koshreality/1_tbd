CREATE TABLE [dbo].[user_answer] (
  [user_answer_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [request_id] [uniqueidentifier] NOT NULL,
  [answer_variant_id] [uniqueidentifier] NOT NULL,
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
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT user_answer_id FROM INSERTED WHERE has_description = 0)
IF NOT EXISTS (SELECT * FROM INSERTED 
                        INNER HASH JOIN exam_request er ON INSERTED.request_id = er.request_id
                        INNER HASH JOIN exam ON er.exam_id = exam.exam_id
                        INNER HASH JOIN test t ON exam.test_id = t.test_id
                        INNER HASH JOIN test_questions tq ON t.test_id = tq.test_id
                        INNER HASH JOIN question q ON tq.question_id = q.quest_id
                        INNER HASH JOIN question_answer_variant qav ON q.quest_id = qav.question_id
                        WHERE INSERTED.answer_variant_id = qav.answer_variant_id)
  BEGIN
    ROLLBACK TRAN
      PRINT 'this answer does not apply to the exam test'
  END
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger14]
ON [dbo].[user_answer]
AFTER DELETE
AS
DELETE FROM department_descriptions
WHERE entity_id IN
      (SELECT user_answer_id FROM DELETED WHERE has_description = 1)
GO

ALTER TABLE [dbo].[user_answer]
  ADD CONSTRAINT [FK_user_answer_answer_variant_id] FOREIGN KEY ([answer_variant_id]) REFERENCES [dbo].[question_answer_variant] ([answer_variant_id])
GO

ALTER TABLE [dbo].[user_answer] WITH NOCHECK
  ADD CONSTRAINT [FK_user_answer_request_id] FOREIGN KEY ([request_id]) REFERENCES [dbo].[exam_request] ([request_id])
GO

ALTER TABLE [dbo].[user_answer] WITH NOCHECK
  ADD CONSTRAINT [FK_user_answer_reviewed_by] FOREIGN KEY ([reviewed_by]) REFERENCES [dbo].[user] ([user_id])
GO