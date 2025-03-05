-- =============================================
-- Create Classes and CharacterClasses Tables
-- =============================================
USE DMDB;
GO

-- Create Classes table to store character classes
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Classes' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.Classes
    (
        ClassId INT IDENTITY(1,1) PRIMARY KEY,
        ClassName NVARCHAR(50) NOT NULL UNIQUE,
        Description NVARCHAR(2000) NULL,
        HitDie NVARCHAR(10) NOT NULL,  -- e.g., 'd6', 'd8', 'd10', 'd12'
        PrimaryAbility NVARCHAR(50) NOT NULL,
        SavingThrowProficiencies NVARCHAR(100) NOT NULL,
        ArmorProficiencies NVARCHAR(200) NULL,
        WeaponProficiencies NVARCHAR(200) NULL,
        ToolProficiencies NVARCHAR(200) NULL,
        SpellCastingAbility NVARCHAR(20) NULL,
        SubclassLevel INT NULL,
        SubclassTitle NVARCHAR(50) NULL,  -- e.g., 'Arcane Tradition', 'Divine Domain', etc.
        GameEdition NVARCHAR(20) NOT NULL DEFAULT '5e',
        IsActive BIT NOT NULL DEFAULT 1,
        CreatedDate DATETIME NOT NULL DEFAULT GETDATE(),
        LastUpdatedDate DATETIME NOT NULL DEFAULT GETDATE()
    );
    
    PRINT 'Table dnd.Classes created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_Classes_ClassName ON dnd.Classes(ClassName);
    CREATE INDEX IX_Classes_GameEdition ON dnd.Classes(GameEdition);
    
    PRINT 'Indexes on dnd.Classes created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.Classes already exists.';
END
GO

-- Create CharacterClasses junction table to establish many-to-many relationship between Characters and Classes
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CharacterClasses' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    CREATE TABLE dnd.CharacterClasses
    (
        CharacterClassId INT IDENTITY(1,1) PRIMARY KEY,
        CharacterId INT NOT NULL,
        ClassId INT NOT NULL,
        ClassLevel INT NOT NULL DEFAULT 1,
        Subclass NVARCHAR(50) NULL,
        IsActive BIT NOT NULL DEFAULT 1,
        
        -- Foreign keys
        CONSTRAINT FK_CharacterClasses_Character FOREIGN KEY (CharacterId) 
            REFERENCES dnd.Characters (CharacterId),
        CONSTRAINT FK_CharacterClasses_Class FOREIGN KEY (ClassId) 
            REFERENCES dnd.Classes (ClassId),
            
        -- Ensure a character can only have a specific class once
        CONSTRAINT UQ_CharacterClasses_CharacterClass UNIQUE (CharacterId, ClassId)
    );
    
    PRINT 'Table dnd.CharacterClasses created successfully.';
    
    -- Add indexes for performance
    CREATE INDEX IX_CharacterClasses_CharacterId ON dnd.CharacterClasses(CharacterId);
    CREATE INDEX IX_CharacterClasses_ClassId ON dnd.CharacterClasses(ClassId);
    
    PRINT 'Indexes on dnd.CharacterClasses created successfully.';
END
ELSE
BEGIN
    PRINT 'Table dnd.CharacterClasses already exists.';
END
GO