-- =============================================
-- Create Rules Table
-- =============================================
USE DMDB;
GO

-- Create Rules table to store game rules
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Rules' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Rules
    (
        RuleId INT IDENTITY(1,1) PRIMARY KEY,
        RuleName NVARCHAR(100) NOT NULL,
        Category NVARCHAR(50) NOT NULL,  -- e.g., 'Combat', 'Spellcasting', 'Movement', etc.
        Description NVARCHAR(MAX) NOT NULL,
        ShortDescription NVARCHAR(500) NULL,
        PageReference NVARCHAR(50) NULL,  -- e.g., 'PHB 189-190'
        GameEdition NVARCHAR(20) NOT NULL DEFAULT '5e',
        IsHouseRule BIT NOT NULL DEFAULT 0,
        CampaignId INT NULL,              -- NULL for standard rules, non-NULL for campaign-specific house rules
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        
        -- Foreign key for campaign-specific house rules
        CONSTRAINT FK_Rules_Campaign FOREIGN KEY (CampaignId) 
            REFERENCES dnd.Campaigns (CampaignId)
    );
    
    PRINT 'Table dnd.Rules created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Rules_RuleName ON dnd.Rules(RuleName);
    CREATE INDEX IX_Rules_Category ON dnd.Rules(Category);
    CREATE INDEX IX_Rules_GameEdition ON dnd.Rules(GameEdition);
    CREATE INDEX IX_Rules_CampaignId ON dnd.Rules(CampaignId);
    CREATE INDEX IX_Rules_IsHouseRule ON dnd.Rules(IsHouseRule);
    
    PRINT 'Indexes on dnd.Rules created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Rules already exists.';
END
GO