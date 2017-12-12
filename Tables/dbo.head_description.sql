CREATE TABLE [dbo].[head_description] (
  [name] [varchar](50) NULL,
  [entity_id] [uniqueidentifier] NOT NULL,
  [attachment_id] [uniqueidentifier] NOT NULL,
  [creation_datettime] [datetime] NOT NULL DEFAULT (getdate())
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_descriptions_entity_id]
  ON [dbo].[head_description] ([entity_id])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[head_description] WITH NOCHECK
  ADD CONSTRAINT [FK_head_descriptions_attachment_id] FOREIGN KEY ([attachment_id]) REFERENCES [dbo].[head_attachment] ([attachment_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO