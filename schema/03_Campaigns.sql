-- =============================================
-- Create Campaigns Table
-- =============================================
USE DMDB;
GO

-- Create Campaigns table to store information about D&D campaigns
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Campaigns' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Campaigns
    (
        CampaignId INT IDENTITY(1,1) PRIMARY KEY,
        CampaignName NVARCHAR(100) NOT NULL,
        DungeonMasterId INT NOT NULL,
        Description NVARCHAR(2000) NULL,
        GameEdition NVARCHAR(20) NOT NULL,  -- e.g., '5e', '3.5e', 'Pathfinder', etc.
        StartDate DATETIME NULL,
        EndDate DATETIME NULL,
        IsActive BIT NOT NULL DEFAULT 1,
        MaxPlayers INT NULL,
        CampaignSetting NVARCHAR(100) NULL, -- e.g., 'Forgotten Realms', 'Homebrew', etc.
        CampaignLevel NVARCHAR(20) NULL,    -- e.g., '1-5', '5-10', '1-20', etc.
        MeetingSchedule NVARCHAR(200) NULL, -- e.g., 'Weekly on Fridays', 'Bi-weekly', etc.
        MeetingLocation NVARCHAR(200) NULL, -- e.g., 'Online - Roll20', 'Bob's House', etc.
        CampaignNotes NVARCHAR(MAX) NULL,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        
        -- Foreign key to Users table
        CONSTRAINT FK_Campaigns_DungeonMaster FOREIGN KEY (DungeonMasterId) 
            REFERENCES dnd.Users (UserId)
    );
    
    PRINT 'Table dnd.Campaigns created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Campaigns_DungeonMasterId ON dnd.Campaigns(DungeonMasterId);
    CREATE INDEX IX_Campaigns_IsActive ON dnd.Campaigns(IsActive);
    CREATE INDEX IX_Campaigns_GameEdition ON dnd.Campaigns(GameEdition);
    
    PRINT 'Indexes on dnd.Campaigns created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Campaigns already exists.';
END
GO