﻿CREATE TABLE [dbo].[question_test_answer_variant] (
  [answer_variant_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [question_id] [uniqueidentifier] NOT NULL,
  [answer_id] [uniqueidentifier] NOT NULL,
  [test_id] [uniqueidentifier] NOT NULL,
  [is_right] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_question_test_answer_variant_answer_variant_id] PRIMARY KEY NONCLUSTERED ([answer_variant_id])
)
ON [Head_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_question_test_answer_variant]
  ON [dbo].[question_test_answer_variant] ([question_id], [answer_id], [test_id])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[question_test_answer_variant]
  ADD CONSTRAINT [FK_question_test_answer_variant_answer_id] FOREIGN KEY ([answer_id]) REFERENCES [dbo].[answer] ([answer_id])
GO

ALTER TABLE [dbo].[question_test_answer_variant]
  ADD CONSTRAINT [FK_question_test_answer_variant_question_id] FOREIGN KEY ([question_id]) REFERENCES [dbo].[question] ([quest_id])
GO

ALTER TABLE [dbo].[question_test_answer_variant]
  ADD CONSTRAINT [FK_question_test_answer_variant_test_id] FOREIGN KEY ([test_id]) REFERENCES [dbo].[test] ([test_id])
GO