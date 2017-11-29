﻿USE master
GO

EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'tdb_is'
GO


USE master
GO

DROP DATABASE IF EXISTS tdb_is
GO

IF DB_ID('tdb_is') IS NULL
  CREATE DATABASE tdb_is
	  ON PRIMARY (
	  NAME = N'tdb_is',
	  FILENAME = N'D:\tdb_is.mdf',
	  SIZE = 136896 KB,
	  MAXSIZE = UNLIMITED,
	  FILEGROWTH = 10 %
  )
  LOG ON (
	  NAME = N'tdb_is_log',
	  FILENAME = N'D:\tdb_is_log.ldf',
	  SIZE = 1341184 KB,
	  MAXSIZE = UNLIMITED,
	  FILEGROWTH = 10 %
  )
GO

ALTER DATABASE tdb_is
	ADD FILEGROUP Head_Filegroup
GO

ALTER DATABASE tdb_is
	ADD FILEGROUP Department_Filegroup
GO

ALTER DATABASE tdb_is
	ADD FILEGROUP Head_Filestream_group
CONTAINS FILESTREAM
GO

ALTER DATABASE tdb_is
	ADD FILEGROUP Department_Filestream_group
CONTAINS FILESTREAM
GO

ALTER DATABASE tdb_is
ADD FILE
(
	NAME = N'tdb_is_tests',
	FILENAME = N'D:\tdb_is_head.ndf',
	SIZE = 572608 KB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10 %
)
TO FILEGROUP Head_Filegroup
GO

ALTER DATABASE tdb_is
ADD FILE
(
	NAME = N'tdb_is_persons',
	FILENAME = N'D:\tdb_is_department.ndf',
	SIZE = 473152 KB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10 %
)
TO FILEGROUP Department_Filegroup
GO

ALTER DATABASE tdb_is
ADD FILE
(
	NAME = N'tdb_is_head_fs',
	FILENAME = N'D:\tdb_is_head_fs.ndf',
	MAXSIZE = UNLIMITED
)
TO FILEGROUP Head_Filestream_group
GO

ALTER DATABASE tdb_is
ADD FILE
(
	NAME = N'tdb_is_department_fs',
	FILENAME = N'D:\tdb_is_department_fs.ndf',
	MAXSIZE = UNLIMITED
)
TO FILEGROUP Department_Filestream_group
GO

ALTER DATABASE tdb_is
	MODIFY FILEGROUP Head_Filegroup
	DEFAULT
GO

ALTER DATABASE [tdb_is]
  SET
    ANSI_NULL_DEFAULT OFF,
	ANSI_NULLS OFF,
	ANSI_PADDING OFF,
	ANSI_WARNINGS OFF,
	ARITHABORT OFF,
	AUTO_CLOSE OFF,
	AUTO_CREATE_STATISTICS ON,
	AUTO_SHRINK OFF,
	AUTO_UPDATE_STATISTICS ON,
	AUTO_UPDATE_STATISTICS_ASYNC OFF,
	COMPATIBILITY_LEVEL = 140,
	CONCAT_NULL_YIELDS_NULL OFF,
	CURSOR_CLOSE_ON_COMMIT OFF,
	CURSOR_DEFAULT GLOBAL,
	DATE_CORRELATION_OPTIMIZATION OFF,
	DB_CHAINING OFF,
	HONOR_BROKER_PRIORITY OFF,
	MULTI_USER,
	NESTED_TRIGGERS = ON,
	NUMERIC_ROUNDABORT OFF,
	PAGE_VERIFY CHECKSUM,
	PARAMETERIZATION SIMPLE,
	QUOTED_IDENTIFIER OFF,
	READ_COMMITTED_SNAPSHOT OFF,
	RECOVERY FULL,
	RECURSIVE_TRIGGERS OFF,
	TRANSFORM_NOISE_WORDS = OFF,
	TRUSTWORTHY OFF
	WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE [tdb_is]
  COLLATE Cyrillic_General_CI_AS
GO

ALTER DATABASE [tdb_is]
  SET DISABLE_BROKER
GO

ALTER DATABASE [tdb_is]
  SET ALLOW_SNAPSHOT_ISOLATION OFF
GO

ALTER DATABASE [tdb_is]
  SET FILESTREAM (NON_TRANSACTED_ACCESS = FULL, DIRECTORY_NAME = 'FS')
GO

ALTER DATABASE [tdb_is]
  SET QUERY_STORE = OFF
GO

USE [tdb_is]
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO

ALTER AUTHORIZATION ON DATABASE :: [tdb_is] TO [DESKTOP-94IST1V\Roman]
GO

IF DB_ID('tdb_is') IS NOT NULL
  ALTER AUTHORIZATION ON DATABASE::tdb_is TO [DESKTOP-94IST1V\Roman]
GO

IF DB_ID('tdb_is') IS NOT NULL

  AND DATABASE_PRINCIPAL_ID(N'dbo') IS NOT NULL
  GRANT CONNECT TO dbo
GO

IF DB_ID('tdb_is') IS NOT NULL

  AND DATABASE_PRINCIPAL_ID(N'public') IS NOT NULL
  GRANT
  VIEW ANY COLUMN ENCRYPTION KEY DEFINITION,
  VIEW ANY COLUMN MASTER KEY DEFINITION TO [public]
GO