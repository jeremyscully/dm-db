-- =============================================
-- Create Locations Table
-- =============================================
USE DMDB;
GO

-- Create Locations table to store campaign locations
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Locations' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Locations
    (
        LocationId INT IDENTITY(1,1) PRIMARY KEY,
        LocationName NVARCHAR(100) NOT NULL,
        CampaignId INT NULL,                -- Can be NULL for generic locations
        ParentLocationId INT NULL,          -- For hierarchical locations (e.g., a tavern within a city)
        LocationType NVARCHAR(50) NOT NULL, -- e.g., 'Continent', 'Country', 'City', 'Dungeon', 'Tavern', etc.
        Description NVARCHAR(2000) NULL,
        Climate NVARCHAR(50) NULL,
        Terrain NVARCHAR(50) NULL,
        Population NVARCHAR(50) NULL,       -- e.g., 'Sparse', '~1,000', '10,000+', etc.
        Government NVARCHAR(100) NULL,
        NotableNPCs NVARCHAR(500) NULL,
        Economy NVARCHAR(200) NULL,
        Religion NVARCHAR(200) NULL,
        Dangers NVARCHAR(500) NULL,
        History NVARCHAR(1000) NULL,
        PointsOfInterest NVARCHAR(1000) NULL,
        Shops NVARCHAR(500) NULL,
        Hooks NVARCHAR(1000) NULL,          -- Adventure hooks related to this location
        MapUrl NVARCHAR(255) NULL,          -- URL to a map image
        IsSecret BIT NOT NULL DEFAULT 0,    -- Whether this location is secret from players
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        
        -- Foreign keys
        CONSTRAINT FK_Locations_Campaign FOREIGN KEY (CampaignId) 
            REFERENCES dnd.Campaigns (CampaignId),
        CONSTRAINT FK_Locations_ParentLocation FOREIGN KEY (ParentLocationId) 
            REFERENCES dnd.Locations (LocationId)
    );
    
    PRINT 'Table dnd.Locations created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Locations_LocationName ON dnd.Locations(LocationName);
    CREATE INDEX IX_Locations_CampaignId ON dnd.Locations(CampaignId);
    CREATE INDEX IX_Locations_ParentLocationId ON dnd.Locations(ParentLocationId);
    CREATE INDEX IX_Locations_LocationType ON dnd.Locations(LocationType);
    
    PRINT 'Indexes on dnd.Locations created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Locations already exists.';
END
GO