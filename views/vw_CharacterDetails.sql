-- =============================================
-- View: vw_CharacterDetails
-- Description: Provides a consolidated view of character information
-- =============================================
USE DMDB;
GO

-- Check if the view exists and drop it if it does
IF EXISTS (SELECT * FROM sys.views WHERE name = 'vw_CharacterDetails' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    DROP VIEW dnd.vw_CharacterDetails;
    PRINT 'View dnd.vw_CharacterDetails dropped.';
END
GO

-- Create the view
CREATE VIEW dnd.vw_CharacterDetails
AS
SELECT 
    c.CharacterId,
    c.CharacterName,
    c.PlayerId,
    u.Username AS PlayerName,
    c.CampaignId,
    camp.CampaignName,
    c.Race,
    c.Background,
    c.Alignment,
    c.Level,
    c.ExperiencePoints,
    c.Strength,
    c.Dexterity,
    c.Constitution,
    c.Intelligence,
    c.Wisdom,
    c.Charisma,
    c.HitPoints,
    c.MaxHitPoints,
    c.ArmorClass,
    c.Speed,
    c.Biography,
    c.Appearance,
    c.Personality,
    c.Ideals,
    c.Bonds,
    c.Flaws,
    c.IsActive,
    c.CreatedDate,
    c.LastUpdatedDate,
    -- Calculate ability modifiers
    (c.Strength - 10) / 2 AS StrengthModifier,
    (c.Dexterity - 10) / 2 AS DexterityModifier,
    (c.Constitution - 10) / 2 AS ConstitutionModifier,
    (c.Intelligence - 10) / 2 AS IntelligenceModifier,
    (c.Wisdom - 10) / 2 AS WisdomModifier,
    (c.Charisma - 10) / 2 AS CharismaModifier,
    -- Concatenate classes and levels
    STUFF(
        (SELECT 
            ', ' + cl.ClassName + ' (' + CAST(cc.ClassLevel AS NVARCHAR) + 
            CASE WHEN cc.Subclass IS NOT NULL THEN ' - ' + cc.Subclass ELSE '' END + ')'
         FROM 
            dnd.CharacterClasses cc
         INNER JOIN 
            dnd.Classes cl ON cc.ClassId = cl.ClassId
         WHERE 
            cc.CharacterId = c.CharacterId
         FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 2, '') AS ClassInformation
FROM 
    dnd.Characters c
INNER JOIN 
    dnd.Users u ON c.PlayerId = u.UserId
LEFT JOIN 
    dnd.Campaigns camp ON c.CampaignId = camp.CampaignId;
GO

PRINT 'View dnd.vw_CharacterDetails created successfully.';
GO