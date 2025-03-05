-- =============================================
-- Create Characters Table
-- =============================================
USE DMDB;
GO

-- Create Characters table to store player characters
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Characters' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Characters
    (
        CharacterId INT IDENTITY(1,1) PRIMARY KEY,
        CharacterName NVARCHAR(100) NOT NULL,
        PlayerId INT NOT NULL,                    -- The user who owns this character
        CampaignId INT NULL,                      -- The campaign this character belongs to (can be NULL if not assigned)
        Race NVARCHAR(50) NOT NULL,
        Background NVARCHAR(50) NULL,
        Alignment NVARCHAR(20) NULL,
        Level INT NOT NULL DEFAULT 1,
        ExperiencePoints INT NOT NULL DEFAULT 0,
        Strength INT NOT NULL DEFAULT 10,
        Dexterity INT NOT NULL DEFAULT 10,
        Constitution INT NOT NULL DEFAULT 10,
        Intelligence INT NOT NULL DEFAULT 10,
        Wisdom INT NOT NULL DEFAULT 10,
        Charisma INT NOT NULL DEFAULT 10,
        HitPoints INT NOT NULL DEFAULT 0,
        MaxHitPoints INT NOT NULL DEFAULT 0,
        ArmorClass INT NOT NULL DEFAULT 10,
        Speed INT NOT NULL DEFAULT 30,
        Biography NVARCHAR(2000) NULL,
        Appearance NVARCHAR(1000) NULL,
        Personality NVARCHAR(1000) NULL,
        Ideals NVARCHAR(500) NULL,
        Bonds NVARCHAR(500) NULL,
        Flaws NVARCHAR(500) NULL,
        CharacterNotes NVARCHAR(MAX) NULL,
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        
        -- Foreign keys
        CONSTRAINT FK_Characters_Player FOREIGN KEY (PlayerId) 
            REFERENCES dnd.Users (UserId),
        CONSTRAINT FK_Characters_Campaign FOREIGN KEY (CampaignId) 
            REFERENCES dnd.Campaigns (CampaignId)
    );
    
    PRINT 'Table dnd.Characters created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Characters_PlayerId ON dnd.Characters(PlayerId);
    CREATE INDEX IX_Characters_CampaignId ON dnd.Characters(CampaignId);
    CREATE INDEX IX_Characters_IsActive ON dnd.Characters(IsActive);
    CREATE INDEX IX_Characters_Level ON dnd.Characters(Level);
    
    PRINT 'Indexes on dnd.Characters created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Characters already exists.';
END
GO