CREATE TABLE [dbo].[section_type] (
  [sec_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](100) NOT NULL,
  [has_description] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_section_type_sec_type_id] PRIMARY KEY NONCLUSTERED ([sec_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_section_type_creation_datetime]
  ON [dbo].[section_type] ([name])
  ON [Head_Filegroup]
GO