CREATE TABLE [dbo].[head_descriptions] (
  [name] [varchar](50) NULL,
  [entity_id] [uniqueidentifier] NOT NULL,
  [attachment_id] [uniqueidentifier] NOT NULL,
  [creation_datettime] [datetime] NOT NULL DEFAULT (getdate())
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_descriptions_entity_id]
  ON [dbo].[head_descriptions] ([entity_id])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[head_descriptions] WITH NOCHECK
  ADD CONSTRAINT [FK_head_descriptions_attachment_id] FOREIGN KEY ([attachment_id]) REFERENCES [dbo].[head_attachments] ([attachment_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO