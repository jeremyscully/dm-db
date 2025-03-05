-- =============================================
-- Create Monsters Table
-- =============================================
USE DMDB;
GO

-- Create Monsters table to store monster information
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Monsters' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Monsters
    (
        MonsterId INT IDENTITY(1,1) PRIMARY KEY,
        MonsterName NVARCHAR(100) NOT NULL,
        Type NVARCHAR(50) NOT NULL,  -- e.g., 'Aberration', 'Beast', 'Celestial', etc.
        Size NVARCHAR(20) NOT NULL,  -- e.g., 'Tiny', 'Small', 'Medium', 'Large', 'Huge', 'Gargantuan'
        Alignment NVARCHAR(50) NULL,
        ArmorClass INT NOT NULL,
        ArmorType NVARCHAR(100) NULL,
        HitPoints INT NOT NULL,
        HitDice NVARCHAR(20) NOT NULL,  -- e.g., '3d8+6'
        Speed NVARCHAR(100) NOT NULL,   -- e.g., '30 ft., fly 60 ft.'
        Strength INT NOT NULL DEFAULT 10,
        Dexterity INT NOT NULL DEFAULT 10,
        Constitution INT NOT NULL DEFAULT 10,
        Intelligence INT NOT NULL DEFAULT 10,
        Wisdom INT NOT NULL DEFAULT 10,
        Charisma INT NOT NULL DEFAULT 10,
        SavingThrows NVARCHAR(200) NULL,
        Skills NVARCHAR(300) NULL,
        DamageVulnerabilities NVARCHAR(200) NULL,
        DamageResistances NVARCHAR(200) NULL,
        DamageImmunities NVARCHAR(200) NULL,
        ConditionImmunities NVARCHAR(200) NULL,
        Senses NVARCHAR(200) NULL,
        Languages NVARCHAR(200) NULL,
        ChallengeRating NVARCHAR(10) NOT NULL,  -- e.g., '1/4', '1', '10', etc.
        ExperiencePoints INT NOT NULL,
        Abilities NVARCHAR(MAX) NULL,
        Actions NVARCHAR(MAX) NULL,
        LegendaryActions NVARCHAR(MAX) NULL,
        ReactionActions NVARCHAR(MAX) NULL,
        LairActions NVARCHAR(MAX) NULL,
        RegionalEffects NVARCHAR(MAX) NULL,
        Environment NVARCHAR(100) NULL,
        Source NVARCHAR(100) NULL,  -- e.g., 'Monster Manual', 'Volo's Guide to Monsters', etc.
        SourcePage INT NULL,
        GameEdition NVARCHAR(20) NOT NULL DEFAULT '5e',
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE()
    );
    
    PRINT 'Table dnd.Monsters created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Monsters_MonsterName ON dnd.Monsters(MonsterName);
    CREATE INDEX IX_Monsters_Type ON dnd.Monsters(Type);
    CREATE INDEX IX_Monsters_ChallengeRating ON dnd.Monsters(ChallengeRating);
    CREATE INDEX IX_Monsters_GameEdition ON dnd.Monsters(GameEdition);
    
    PRINT 'Indexes on dnd.Monsters created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Monsters already exists.';
END
GO