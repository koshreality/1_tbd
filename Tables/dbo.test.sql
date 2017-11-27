CREATE TABLE [dbo].[test] (
  [test_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](200) NOT NULL,
  [cert_type_id] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  CONSTRAINT [PK_test_id] PRIMARY KEY NONCLUSTERED ([test_id]) ON [PRIMARY]
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_test_creation_datetime]
  ON [dbo].[test] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[test]
  ADD CONSTRAINT [FK_test_cert_type_id] FOREIGN KEY ([cert_type_id]) REFERENCES [dbo].[cert_type] ([cert_type_id])
GO