CREATE TABLE [dbo].[answer] (
  [answer_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [something] [varchar](300) NULL,
  [has_description] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [varchar](50) NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_answer_variant_ans_var_id] PRIMARY KEY NONCLUSTERED ([answer_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_answer_variant_creation_datetime]
  ON [dbo].[answer] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO