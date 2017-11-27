CREATE TABLE [dbo].[question_type] (
  [quest_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [quest_type] [varchar](200) NOT NULL,
  [sec_type_id] [uniqueidentifier] NOT NULL,
  [grade_criteria] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [manual_grading] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_question_type_quest_type_id] PRIMARY KEY NONCLUSTERED ([quest_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_question_type_quest_type]
  ON [dbo].[question_type] ([quest_type])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[question_type]
  ADD CONSTRAINT [FK_question_type_grade_criteria] FOREIGN KEY ([grade_criteria]) REFERENCES [dbo].[grade_criteria] ([grade_crit_id])
GO

ALTER TABLE [dbo].[question_type]
  ADD CONSTRAINT [FK_question_type_sec_type_id] FOREIGN KEY ([sec_type_id]) REFERENCES [dbo].[section_type] ([sec_type_id])
GO