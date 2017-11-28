CREATE TABLE [dbo].[test_questions] (
  [test_id] [uniqueidentifier] NOT NULL,
  [question_id] [uniqueidentifier] NOT NULL,
  [order] [int] NULL,
  [creation_datetime] [varchar](50) NOT NULL DEFAULT (getdate())
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_test_questions_creation_datetime]
  ON [dbo].[test_questions] ([creation_datetime])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[test_questions]
  ADD CONSTRAINT [FK_test_questions_question_id] FOREIGN KEY ([question_id]) REFERENCES [dbo].[question] ([quest_id])
GO

ALTER TABLE [dbo].[test_questions]
  ADD CONSTRAINT [FK_test_questions_test_id] FOREIGN KEY ([test_id]) REFERENCES [dbo].[test] ([test_id])
GO