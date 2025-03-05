-- =============================================
-- Create Users Table
-- =============================================
USE DMDB;
GO

-- Create Users table to store information about Dungeon Masters and Players
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Users
    (
        UserId INT IDENTITY(1,1) PRIMARY KEY,
        Username NVARCHAR(50) NOT NULL UNIQUE,
        Email NVARCHAR(100) NOT NULL UNIQUE,
        PasswordHash NVARCHAR(128) NOT NULL,  -- Store hashed passwords only
        FirstName NVARCHAR(50),
        LastName NVARCHAR(50),
        IsDungeonMaster BIT NOT NULL DEFAULT 0,  -- Flag to identify Dungeon Masters
        IsPlayer BIT NOT NULL DEFAULT 1,         -- Flag to identify Players (a user can be both)
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastLoginDate DATETIME NULL,
        ProfilePictureUrl NVARCHAR(255) NULL,
        Bio NVARCHAR(1000) NULL,
        PreferredGameEdition NVARCHAR(20) NULL,  -- e.g., '5e', '3.5e', etc.
        IsActive BIT NOT NULL DEFAULT 1
    );
    
    PRINT 'Table dnd.Users created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Users_Username ON dnd.Users(Username);
    CREATE INDEX IX_Users_Email ON dnd.Users(Email);
    CREATE INDEX IX_Users_IsDungeonMaster ON dnd.Users(IsDungeonMaster);
    
    PRINT 'Indexes on dnd.Users created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Users already exists.';
END
GO