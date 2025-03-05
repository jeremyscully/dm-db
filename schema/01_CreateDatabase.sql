-- =============================================
-- Create Database Script for DM-DB
-- =============================================

-- Check if database exists and create if it doesn't
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DMDB')
BEGIN
    CREATE DATABASE DMDB;
    PRINT 'Database DMDB created successfully.';
END
ELSE
BEGIN
    PRINT 'Database DMDB already exists.';
END

-- Use the DMDB database for subsequent operations
USE DMDB;
GO

-- Create a schema for the application
IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'dnd')
BEGIN
    EXEC('CREATE SCHEMA dnd');
    PRINT 'Schema dnd created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema dnd already exists.';
END
GO

PRINT 'Database setup completed successfully.';
GO