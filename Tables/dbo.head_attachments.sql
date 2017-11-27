CREATE TABLE [dbo].[head_attachments] (
  [attachment_id] [uniqueidentifier] NOT NULL DEFAULT (newid()) ROWGUIDCOL,
  [data] [varbinary](max) FILESTREAM NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [attach_type_id] [uniqueidentifier] NOT NULL,
  [name] [varchar](100) NULL,
  CONSTRAINT [PK_head_attachments_attach_id] PRIMARY KEY NONCLUSTERED ([attachment_id]),
  UNIQUE ([attachment_id])
)
ON [Head_Filegroup]
FILESTREAM_ON Head_Filestream_group
GO

CREATE CLUSTERED INDEX [IDX_head_attachments_creation_datetime]
  ON [dbo].[head_attachments] ([creation_datetime])
  ON [Head_Filegroup]
  FILESTREAM_ON Head_Filestream_group
GO

ALTER TABLE [dbo].[head_attachments]
  ADD CONSTRAINT [FK_head_attachments_attach_type_id] FOREIGN KEY ([attach_type_id]) REFERENCES [dbo].[attachment_type] ([att_type_id])
GO