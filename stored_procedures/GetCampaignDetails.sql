-- =============================================
-- Stored Procedure: GetCampaignDetails
-- Description: Retrieves detailed information about a campaign
-- =============================================
USE DMDB;
GO

-- Check if the stored procedure exists and drop it if it does
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCampaignDetails' AND schema_id = SCHEMA_ID('dnd'))
BEGIN
    DROP PROCEDURE dnd.GetCampaignDetails;
    PRINT 'Procedure dnd.GetCampaignDetails dropped.';
END
GO

-- Create the stored procedure
CREATE PROCEDURE dnd.GetCampaignDetails
    @CampaignId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get campaign details
    SELECT 
        c.CampaignId,
        c.CampaignName,
        c.Description,
        c.GameEdition,
        c.StartDate,
        c.EndDate,
        c.IsActive,
        c.MaxPlayers,
        c.CampaignSetting,
        c.CampaignLevel,
        c.MeetingSchedule,
        c.MeetingLocation,
        c.CampaignNotes,
        c.CreatedDate,
        c.LastUpdatedDate,
        u.UserId AS DungeonMasterId,
        u.Username AS DungeonMasterName,
        u.Email AS DungeonMasterEmail,
        u.ProfilePictureUrl AS DungeonMasterProfilePic
    FROM 
        dnd.Campaigns c
    INNER JOIN 
        dnd.Users u ON c.DungeonMasterId = u.UserId
    WHERE 
        c.CampaignId = @CampaignId;
    
    -- Get players in the campaign
    SELECT 
        cp.CampaignPlayerId,
        cp.PlayerId,
        u.Username AS PlayerName,
        u.Email AS PlayerEmail,
        u.ProfilePictureUrl AS PlayerProfilePic,
        cp.JoinDate,
        cp.LeaveDate,
        cp.IsActive,
        cp.PlayerNotes
    FROM 
        dnd.CampaignPlayers cp
    INNER JOIN 
        dnd.Users u ON cp.PlayerId = u.UserId
    WHERE 
        cp.CampaignId = @CampaignId;
    
    -- Get characters in the campaign
    SELECT 
        ch.CharacterId,
        ch.CharacterName,
        ch.PlayerId,
        u.Username AS PlayerName,
        ch.Race,
        ch.Background,
        ch.Alignment,
        ch.Level,
        ch.ExperiencePoints,
        ch.HitPoints,
        ch.MaxHitPoints,
        ch.Biography,
        ch.IsActive
    FROM 
        dnd.Characters ch
    INNER JOIN 
        dnd.Users u ON ch.PlayerId = u.UserId
    WHERE 
        ch.CampaignId = @CampaignId;
    
    -- Get character classes
    SELECT 
        cc.CharacterId,
        c.CharacterName,
        cl.ClassName,
        cc.ClassLevel,
        cc.Subclass
    FROM 
        dnd.CharacterClasses cc
    INNER JOIN 
        dnd.Characters c ON cc.CharacterId = c.CharacterId
    INNER JOIN 
        dnd.Classes cl ON cc.ClassId = cl.ClassId
    WHERE 
        c.CampaignId = @CampaignId;
    
    -- Get campaign locations
    SELECT 
        l.LocationId,
        l.LocationName,
        l.ParentLocationId,
        l.LocationType,
        l.Description,
        l.IsSecret
    FROM 
        dnd.Locations l
    WHERE 
        l.CampaignId = @CampaignId;
    
    -- Get campaign house rules
    SELECT 
        r.RuleId,
        r.RuleName,
        r.Category,
        r.ShortDescription,
        r.Description,
        r.IsHouseRule
    FROM 
        dnd.Rules r
    WHERE 
        r.CampaignId = @CampaignId;
END
GO

PRINT 'Procedure dnd.GetCampaignDetails created successfully.';
GO