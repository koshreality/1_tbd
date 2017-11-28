CREATE TABLE [dbo].[cert_type] (
  [cert_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [something] [varchar](200) NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_cert_type_cert_type_id] PRIMARY KEY NONCLUSTERED ([cert_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_cert_type_creation_datetime]
  ON [dbo].[cert_type] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger9]
ON [dbo].[cert_type]
AFTER DELETE
AS
DELETE FROM head_descriptions
WHERE entity_id IN
      (SELECT cert_type_id FROM DELETED WHERE has_description = 1)
GO

SET QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
CREATE TRIGGER [trigger5]
ON [dbo].[cert_type]
AFTER INSERT, UPDATE
AS
IF EXISTS (SELECT * FROM INSERTED LEFT HASH JOIN head_descriptions hd ON cert_type_id = hd.entity_id WHERE has_description = 1 AND hd.entity_id IS NULL)
  BEGIN
    ROLLBACK TRAN
      PRINT 'no description exists but has_description is 1'
  END
DELETE FROM head_descriptions
WHERE entity_id IN
      (SELECT cert_type_id FROM INSERTED WHERE has_description = 0)
GO