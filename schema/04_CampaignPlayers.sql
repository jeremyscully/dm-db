-- =============================================
-- Create CampaignPlayers Junction Table
-- =============================================
USE DMDB;
GO

-- Create CampaignPlayers table to establish many-to-many relationship between Players and Campaigns
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CampaignPlayers' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.CampaignPlayers
    (
        CampaignPlayerId INT IDENTITY(1,1) PRIMARY KEY,
        CampaignId INT NOT NULL,
        PlayerId INT NOT NULL,
        JoinDate DATETIME NOT NULL DEFAULT GETDATE(),
        LeaveDate DATETIME NULL,
        IsActive BIT NOT NULL DEFAULT 1,
        PlayerNotes NVARCHAR(1000) NULL,
        
        -- Foreign keys
        CONSTRAINT FK_CampaignPlayers_Campaign FOREIGN KEY (CampaignId) 
            REFERENCES dnd.Campaigns (CampaignId),
        CONSTRAINT FK_CampaignPlayers_Player FOREIGN KEY (PlayerId) 
            REFERENCES dnd.Users (UserId),
            
        -- Ensure a player can only be active in a campaign once
        CONSTRAINT UQ_CampaignPlayers_CampaignPlayer UNIQUE (CampaignId, PlayerId, IsActive)
    );
    
    PRINT 'Table dnd.CampaignPlayers created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_CampaignPlayers_CampaignId ON dnd.CampaignPlayers(CampaignId);
    CREATE INDEX IX_CampaignPlayers_PlayerId ON dnd.CampaignPlayers(PlayerId);
    CREATE INDEX IX_CampaignPlayers_IsActive ON dnd.CampaignPlayers(IsActive);
    
    PRINT 'Indexes on dnd.CampaignPlayers created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.CampaignPlayers already exists.';
END
GO