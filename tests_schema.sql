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
CREATE TABLE dbo.test (
  test_id uniqueidentifier NOT NULL,
  name varchar(200) NOT NULL,
  price decimal NULL DEFAULT (0),
  cert_type_id uniqueidentifier NOT NULL,
  CONSTRAINT PK_test_id PRIMARY KEY CLUSTERED (test_id)
)
ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[section]
--
PRINT (N'Создать таблицу [dbo].[section]')
GO
CREATE TABLE dbo.section (
  sec_id uniqueidentifier NOT NULL,
  name text NOT NULL,
  description text NULL,
  test_id uniqueidentifier NOT NULL,
  attach_id uniqueidentifier NULL,
  CONSTRAINT PK_section_sec_id PRIMARY KEY CLUSTERED (sec_id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[question_type]
--
PRINT (N'Создать таблицу [dbo].[question_type]')
GO
CREATE TABLE dbo.question_type (
  quest_type_id uniqueidentifier NOT NULL,
  quest_type varchar(200) NOT NULL,
  CONSTRAINT PK_question_type_quest_type_id PRIMARY KEY CLUSTERED (quest_type_id),
  CONSTRAINT KEY_question_type_quest_type UNIQUE (quest_type)
)
ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[question]
--
PRINT (N'Создать таблицу [dbo].[question]')
GO
CREATE TABLE dbo.question (
  quest_id uniqueidentifier NOT NULL,
  name varchar(200) NOT NULL,
  sec_id uniqueidentifier NOT NULL,
  attach_id uniqueidentifier NULL,
  max_grade float NOT NULL DEFAULT (1),
  grade_crit_id uniqueidentifier NOT NULL,
  quest_type_id uniqueidentifier NOT NULL,
  CONSTRAINT PK_question_quest_id PRIMARY KEY CLUSTERED (quest_id)
)
ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[grade_criteria]
--
PRINT (N'Создать таблицу [dbo].[grade_criteria]')
GO
CREATE TABLE dbo.grade_criteria (
  grade_crit_id uniqueidentifier NOT NULL,
  name varchar(200) NULL,
  description text NULL,
  attach_id uniqueidentifier NULL,
  CONSTRAINT PK_grade_crit_grade_crit_id PRIMARY KEY CLUSTERED (grade_crit_id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[cert_type]
--
PRINT (N'Создать таблицу [dbo].[cert_type]')
GO
CREATE TABLE dbo.cert_type (
  cert_type_id uniqueidentifier NOT NULL,
  type text NULL,
  CONSTRAINT PK_cert_type_cert_type_id PRIMARY KEY CLUSTERED (cert_type_id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Создать таблицу [dbo].[attachment]
--
PRINT (N'Создать таблицу [dbo].[attachment]')
GO
CREATE TABLE dbo.attachment (
  attach_id uniqueidentifier NOT NULL,
  data_filestream varbinary(max) FILESTREAM,
  name varchar(200) NULL,
  CONSTRAINT PK_attachment_attach_id PRIMARY KEY CLUSTERED (attach_id)
)
ON [PRIMARY]
TEXTIMAGE_ON [PRIMARY]
GO

--
-- Добавить расширенное свойство [MS_Description] для [dbo].[attachment] (таблица)
--
PRINT (N'Добавить расширенное свойство [MS_Description] для [dbo].[attachment] (таблица)')
GO
EXEC sys.sp_addextendedproperty N'MS_Description', 'data_filestream will be FILESTREAM in future', 'SCHEMA', N'dbo', 'TABLE', N'attachment'
GO

--
-- Создать таблицу [dbo].[answer_variant]
--
PRINT (N'Создать таблицу [dbo].[answer_variant]')
GO
CREATE TABLE dbo.answer_variant (
  ans_var_id uniqueidentifier NOT NULL,
  quest_id uniqueidentifier NOT NULL,
  variant varchar(300) NULL,
  is_right bit NOT NULL,
  attach_id uniqueidentifier NULL,
  CONSTRAINT PK_answer_variant_ans_var_id PRIMARY KEY CLUSTERED (ans_var_id)
)
ON [PRIMARY]
GO

USE tdb_is
GO

IF DB_NAME() <> N'tdb_is' SET NOEXEC ON
GO

--
-- Создать внешний ключ [FK_test_cert_type_id] для объекта типа таблица [dbo].[test]
--
PRINT (N'Создать внешний ключ [FK_test_cert_type_id] для объекта типа таблица [dbo].[test]')
GO
ALTER TABLE dbo.test
  ADD CONSTRAINT FK_test_cert_type_id FOREIGN KEY (cert_type_id) REFERENCES dbo.cert_type (cert_type_id)
GO

--
-- Создать внешний ключ [FK_section_attach_id] для объекта типа таблица [dbo].[section]
--
PRINT (N'Создать внешний ключ [FK_section_attach_id] для объекта типа таблица [dbo].[section]')
GO
ALTER TABLE dbo.section
  ADD CONSTRAINT FK_section_attach_id FOREIGN KEY (attach_id) REFERENCES dbo.attachment (attach_id)
GO

--
-- Создать внешний ключ [FK_section_test_id] для объекта типа таблица [dbo].[section]
--
PRINT (N'Создать внешний ключ [FK_section_test_id] для объекта типа таблица [dbo].[section]')
GO
ALTER TABLE dbo.section
  ADD CONSTRAINT FK_section_test_id FOREIGN KEY (test_id) REFERENCES dbo.test (test_id)
GO

--
-- Создать внешний ключ [FK_grade_crit_attach_id] для объекта типа таблица [dbo].[grade_criteria]
--
PRINT (N'Создать внешний ключ [FK_grade_crit_attach_id] для объекта типа таблица [dbo].[grade_criteria]')
GO
ALTER TABLE dbo.grade_criteria
  ADD CONSTRAINT FK_grade_crit_attach_id FOREIGN KEY (attach_id) REFERENCES dbo.attachment (attach_id)
GO

--
-- Создать внешний ключ [FK_question_attach_id] для объекта типа таблица [dbo].[question]
--
PRINT (N'Создать внешний ключ [FK_question_attach_id] для объекта типа таблица [dbo].[question]')
GO
ALTER TABLE dbo.question
  ADD CONSTRAINT FK_question_attach_id FOREIGN KEY (attach_id) REFERENCES dbo.attachment (attach_id)
GO

--
-- Создать внешний ключ [FK_question_grade_crit_id] для объекта типа таблица [dbo].[question]
--
PRINT (N'Создать внешний ключ [FK_question_grade_crit_id] для объекта типа таблица [dbo].[question]')
GO
ALTER TABLE dbo.question
  ADD CONSTRAINT FK_question_grade_crit_id FOREIGN KEY (grade_crit_id) REFERENCES dbo.grade_criteria (grade_crit_id)
GO

--
-- Создать внешний ключ [FK_question_quest_type_id] для объекта типа таблица [dbo].[question]
--
PRINT (N'Создать внешний ключ [FK_question_quest_type_id] для объекта типа таблица [dbo].[question]')
GO
ALTER TABLE dbo.question
  ADD CONSTRAINT FK_question_quest_type_id FOREIGN KEY (quest_type_id) REFERENCES dbo.question_type (quest_type_id)
GO

--
-- Создать внешний ключ [FK_question_sec_id] для объекта типа таблица [dbo].[question]
--
PRINT (N'Создать внешний ключ [FK_question_sec_id] для объекта типа таблица [dbo].[question]')
GO
ALTER TABLE dbo.question
  ADD CONSTRAINT FK_question_sec_id FOREIGN KEY (sec_id) REFERENCES dbo.section (sec_id)
GO

--
-- Создать внешний ключ [FK_answer_variant_attach_id] для объекта типа таблица [dbo].[answer_variant]
--
PRINT (N'Создать внешний ключ [FK_answer_variant_attach_id] для объекта типа таблица [dbo].[answer_variant]')
GO
ALTER TABLE dbo.answer_variant
  ADD CONSTRAINT FK_answer_variant_attach_id FOREIGN KEY (attach_id) REFERENCES dbo.attachment (attach_id)
GO

--
-- Создать внешний ключ [FK_answer_variant_quest_id] для объекта типа таблица [dbo].[answer_variant]
--
PRINT (N'Создать внешний ключ [FK_answer_variant_quest_id] для объекта типа таблица [dbo].[answer_variant]')
GO
ALTER TABLE dbo.answer_variant
  ADD CONSTRAINT FK_answer_variant_quest_id FOREIGN KEY (quest_id) REFERENCES dbo.question (quest_id)
GO
SET NOEXEC OFF
GO