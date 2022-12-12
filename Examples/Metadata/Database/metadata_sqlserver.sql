-- SQL Manager Lite for SQL Server 4.3.0.47914
-- ---------------------------------------
-- Host      : 127.0.0.1\SQLExpress,1433
-- Database  : metadata
-- Version   : Microsoft SQL Server 2014 (RTM 12.0.2569.0


CREATE DATABASE metadata
ON PRIMARY
  ( NAME = metadata,
    FILENAME = N'D:\ORMBr\Demo\Metadata\Database\metadata.mdf',
    SIZE = 5 MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1 MB )
LOG ON
  ( NAME = metadata_log,
    FILENAME = N'D:\ORMBr\Demo\Metadata\Database\metadata_log.ldf',
    SIZE = 1 MB,
    MAXSIZE = 2097152 MB,
    FILEGROWTH = 10 % )
COLLATE SQL_Latin1_General_CP1_CI_AI
GO

USE metadata
GO

