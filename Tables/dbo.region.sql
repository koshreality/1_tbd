CREATE TABLE [dbo].[region] (
  [region_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [country] [varchar](100) NOT NULL,
  [region] [varchar](100) NULL,
  [city] [varchar](100) NULL,
  [town] [varchar](100) NULL,
  [village] [varchar](100) NULL,
  [street] [varchar](100) NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_region_region_id] PRIMARY KEY NONCLUSTERED ([region_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE CLUSTERED INDEX [UK_region]
  ON [dbo].[region] ([country], [region])
  ON [Department_Filegroup]
GO