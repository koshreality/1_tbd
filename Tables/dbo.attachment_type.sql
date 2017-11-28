CREATE TABLE [dbo].[attachment_type] (
  [att_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](50) NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_attachment_type_att_type_id] PRIMARY KEY NONCLUSTERED ([att_type_id]) ON [PRIMARY]
)
ON [Head_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_attachment_type_name]
  ON [dbo].[attachment_type] ([name])
  ON [Head_Filegroup]
GO