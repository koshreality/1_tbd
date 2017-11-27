CREATE TABLE [dbo].[grade_criteria] (
  [grade_crit_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [max_grade] [float] NULL DEFAULT (1),
  [something] [varchar](300) NULL,
  CONSTRAINT [PK_grade_crit_grade_crit_id] PRIMARY KEY NONCLUSTERED ([grade_crit_id]) ON [PRIMARY]
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_grade_criteria_creation_datetime]
  ON [dbo].[grade_criteria] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger2]
ON [dbo].[grade_criteria]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN head_descriptions hd ON grade_crit_id = hd.entity_id WHERE has_description = 1 AND hd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
GO