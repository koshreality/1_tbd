CREATE TABLE [dbo].[section_type] (
  [sec_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](100) NOT NULL,
  [has_description] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [something] [varchar](300) NULL,
  CONSTRAINT [PK_section_type_sec_type_id] PRIMARY KEY NONCLUSTERED ([sec_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_section_type_creation_datetime]
  ON [dbo].[section_type] ([name])
  ON [Head_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger13]
ON [dbo].[section_type]
AFTER DELETE
AS
DELETE FROM head_descriptions
WHERE entity_id IN
      (SELECT sec_type_id FROM DELETED WHERE has_description = 1)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger1]
ON [dbo].[section_type]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN head_descriptions hd ON sec_type_id = hd.entity_id WHERE has_description = 1 AND hd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
DELETE FROM head_descriptions
WHERE entity_id IN
      (SELECT sec_type_id FROM INSERTED WHERE has_description = 0)
GO