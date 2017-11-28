CREATE TABLE [dbo].[department] (
  [dep_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [region_id] [uniqueidentifier] NOT NULL,
  [name] [varchar](300) NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_department_dep_id] PRIMARY KEY NONCLUSTERED ([dep_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_department_name]
  ON [dbo].[department] ([name], [creation_datetime] DESC, [region_id])
  ON [Department_Filegroup]
GO

ALTER TABLE [dbo].[department] WITH NOCHECK
  ADD CONSTRAINT [FK_department_region_id] FOREIGN KEY ([region_id]) REFERENCES [dbo].[region] ([region_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO