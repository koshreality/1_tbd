CREATE TABLE [dbo].[user] (
  [user_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](50) NOT NULL,
  [surname] [varchar](50) NULL,
  [patronymic] [varchar](50) NULL,
  [date_of_birth] [date] NULL,
  [nationality_region_id] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_user_user_id] PRIMARY KEY NONCLUSTERED ([user_id]) ON [Department_Filegroup]
)
ON [Department_Filegroup]
GO

CREATE UNIQUE CLUSTERED INDEX [UK_user]
  ON [dbo].[user] ([name], [surname], [patronymic], [date_of_birth], [nationality_region_id], [creation_datetime] DESC)
  ON [Department_Filegroup]
GO

ALTER TABLE [dbo].[user]
  ADD CONSTRAINT [FK_user_nationality_region_id] FOREIGN KEY ([nationality_region_id]) REFERENCES [dbo].[region] ([region_id])
GO