CREATE TABLE [dbo].[exam] (
  [exam_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [test_id] [uniqueidentifier] NOT NULL,
  [dep_id] [uniqueidentifier] NOT NULL,
  [beginning] [datetime] NULL,
  [ending] [datetime] NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [conducted_by] [uniqueidentifier] NULL,
  [something] [varchar](100) NULL,
  [price] [money] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_exam_exam_id] PRIMARY KEY NONCLUSTERED ([exam_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_exam_creation_datetime]
  ON [dbo].[exam] ([creation_datetime] DESC)
  ON [Department_Filegroup]
GO

ALTER TABLE [dbo].[exam]
  ADD CONSTRAINT [FK_exam_conducted_by] FOREIGN KEY ([conducted_by]) REFERENCES [dbo].[user] ([user_id])
GO

ALTER TABLE [dbo].[exam]
  ADD CONSTRAINT [FK_exam_dep_id] FOREIGN KEY ([dep_id]) REFERENCES [dbo].[department] ([dep_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[exam]
  ADD CONSTRAINT [FK_exam_test_id] FOREIGN KEY ([test_id]) REFERENCES [dbo].[test] ([test_id])
GO