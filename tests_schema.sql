DROP DATABASE IF EXISTS tdb_is;
CREATE DATABASE tdb_is;

USE tdb_is
GO

IF DB_NAME() <> N'tdb_is' SET NOEXEC ON
GO

--
-- Создать таблицу [dbo].[test]
--
PRINT (N'Создать таблицу [dbo].[test]')
GO
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
CREATE TABLE [dbo].[question_type] (
  [quest_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [quest_type] [varchar](200) NOT NULL,
  [sec_type_id] [uniqueidentifier] NOT NULL,
  [grade_criteria] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [manual_grading] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_question_type_quest_type_id] PRIMARY KEY NONCLUSTERED ([quest_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_question_type_quest_type]
  ON [dbo].[question_type] ([quest_type])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[question_type]
  ADD CONSTRAINT [FK_question_type_grade_criteria] FOREIGN KEY ([grade_criteria]) REFERENCES [dbo].[grade_criteria] ([grade_crit_id])
GO

ALTER TABLE [dbo].[question_type]
  ADD CONSTRAINT [FK_question_type_sec_type_id] FOREIGN KEY ([sec_type_id]) REFERENCES [dbo].[section_type] ([sec_type_id])
GOCREATE TABLE [dbo].[question] (
  [quest_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [name] [varchar](200) NOT NULL,
  [quest_type_id] [uniqueidentifier] NOT NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_question_quest_id] PRIMARY KEY NONCLUSTERED ([quest_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_question_creation_datetime]
  ON [dbo].[question] ([creation_datetime])
  ON [Head_Filegroup]
GO

ALTER TABLE [dbo].[question]
  ADD CONSTRAINT [FK_question_quest_type_id] FOREIGN KEY ([quest_type_id]) REFERENCES [dbo].[question_type] ([quest_type_id])
GO
CREATE TABLE [dbo].[grade_criteria] (
  [grade_crit_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [max_grade] [float] NULL DEFAULT (1),
  [something] [varchar](300) NULL,
  CONSTRAINT [PK_grade_crit_grade_crit_id] PRIMARY KEY NONCLUSTERED ([grade_crit_id]) ON [PRIMARY]
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_grade_criteria_creation_datetime]
  ON [dbo].[grade_criteria] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO
CREATE TABLE [dbo].[cert_type] (
  [cert_type_id] [uniqueidentifier] NOT NULL DEFAULT (newid()),
  [something] [varchar](200) NULL,
  [creation_datetime] [datetime] NOT NULL DEFAULT (getdate()),
  [has_description] [bit] NOT NULL DEFAULT (0),
  CONSTRAINT [PK_cert_type_cert_type_id] PRIMARY KEY NONCLUSTERED ([cert_type_id])
)
ON [Head_Filegroup]
GO

CREATE CLUSTERED INDEX [IDX_cert_type_creation_datetime]
  ON [dbo].[cert_type] ([creation_datetime] DESC)
  ON [Head_Filegroup]
GO

--
-- Добавить расширенное свойство [MS_Description] для [dbo].[attachment] (таблица)
--
PRINT (N'Добавить расширенное свойство [MS_Description] для [dbo].[attachment] (таблица)')
GO


--
-- Создать таблицу [dbo].[answer_variant]
--
PRINT (N'Создать таблицу [dbo].[answer_variant]')
GO

SET NOEXEC OFF
GO