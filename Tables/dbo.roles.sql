CREATE TABLE [dbo].[roles] (
  [role_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](200) NOT NULL,
  CONSTRAINT [PK_roles_role_id] PRIMARY KEY NONCLUSTERED ([role_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_roles_name]
  ON [dbo].[roles] ([name])
  ON [Department_Filegroup]
GO