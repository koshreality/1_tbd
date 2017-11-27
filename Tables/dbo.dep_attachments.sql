CREATE TABLE [dbo].[dep_attachments] (
  [attach_id] [uniqueidentifier] NOT NULL DEFAULT (newid()) ROWGUIDCOL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [data] [varbinary](max) FILESTREAM NULL,
  [attach_type_id] [uniqueidentifier] NOT NULL,
  [name] [varchar](100) NULL,
  CONSTRAINT [PK_dep_attachments_attach_id2] PRIMARY KEY NONCLUSTERED ([attach_id]) ON [Department_Filegroup],
  UNIQUE ([attach_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
FILESTREAM_ON Department_Filestream_group
GO

CREATE CLUSTERED INDEX [IDX_dep_attachments_creation_datetime]
  ON [dbo].[dep_attachments] ([creation_datetime] DESC)
  ON [Department_Filegroup]
  FILESTREAM_ON Department_Filestream_group
GO

ALTER TABLE [dbo].[dep_attachments]
  ADD CONSTRAINT [FK_dep_attachments_attach_type_id] FOREIGN KEY ([attach_type_id]) REFERENCES [dbo].[attachment_type] ([att_type_id])
GO