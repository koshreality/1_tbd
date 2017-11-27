CREATE TABLE [dbo].[user_role] (
  [role_id] [uniqueidentifier] NOT NULL,
  [user_id] [uniqueidentifier] NOT NULL,
  [department_id] [uniqueidentifier] NOT NULL,
  [from_date] [date] NOT NULL DEFAULT (getdate()),
  [to_date] [date] NULL
)
ON [Department_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_user_role_from_date]
  ON [dbo].[user_role] ([from_date] DESC)
  ON [Department_Filegroup]
GO

ALTER TABLE [dbo].[user_role]
  ADD CONSTRAINT [FK_user_role_role_id] FOREIGN KEY ([role_id]) REFERENCES [dbo].[roles] ([role_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO

ALTER TABLE [dbo].[user_role]
  ADD CONSTRAINT [FK_user_role_user_id] FOREIGN KEY ([user_id]) REFERENCES [dbo].[user] ([user_id]) ON DELETE CASCADE ON UPDATE CASCADE
GO