-- =============================================
-- Sample Data Script for DM-DB
-- =============================================
USE DMDB;
GO

-- Insert sample users (DMs and Players)
INSERT INTO dnd.Users (Username, Email, PasswordHash, FirstName, LastName, IsDungeonMaster, IsPlayer, PreferredGameEdition, Bio)
VALUES 
    ('dmmaster', 'dm@example.com', 'HASHED_PASSWORD_1', 'John', 'Smith', 1, 1, '5e', 'Experienced DM with 10 years of running campaigns.'),
    ('player1', 'player1@example.com', 'HASHED_PASSWORD_2', 'Alice', 'Johnson', 0, 1, '5e', 'New to D&D but enthusiastic!'),
    ('player2', 'player2@example.com', 'HASHED_PASSWORD_3', 'Bob', 'Williams', 0, 1, '5e', 'Played since 3.5 edition.'),
    ('player3', 'player3@example.com', 'HASHED_PASSWORD_4', 'Charlie', 'Brown', 0, 1, '5e', 'Love playing spellcasters.'),
    ('dmanddm', 'dm2@example.com', 'HASHED_PASSWORD_5', 'Diana', 'Miller', 1, 1, '5e', 'Specializes in homebrew campaigns.');
GO

-- Insert sample campaigns
INSERT INTO dnd.Campaigns (CampaignName, DungeonMasterId, Description, GameEdition, StartDate, IsActive, MaxPlayers, CampaignSetting, CampaignLevel, MeetingSchedule)
VALUES 
    ('The Lost Mines of Phandelver', 1, 'A starter campaign for new players.', '5e', DATEADD(month, -3, GETDATE()), 1, 5, 'Forgotten Realms', '1-5', 'Weekly on Fridays'),
    ('Curse of Strahd', 1, 'Gothic horror campaign in Barovia.', '5e', DATEADD(month, -1, GETDATE()), 1, 4, 'Ravenloft', '3-10', 'Bi-weekly on Saturdays'),
    ('Homebrew: The Crystal Kingdoms', 5, 'A custom campaign in a world of floating islands and crystal magic.', '5e', DATEADD(month, -6, GETDATE()), 1, 6, 'Homebrew', '1-20', 'Weekly on Wednesdays');
GO

-- Insert campaign players
INSERT INTO dnd.CampaignPlayers (CampaignId, PlayerId, JoinDate, IsActive)
VALUES 
    (1, 2, DATEADD(month, -3, GETDATE()), 1),
    (1, 3, DATEADD(month, -3, GETDATE()), 1),
    (1, 4, DATEADD(month, -3, GETDATE()), 1),
    (2, 2, DATEADD(month, -1, GETDATE()), 1),
    (2, 4, DATEADD(month, -1, GETDATE()), 1),
    (3, 3, DATEADD(month, -6, GETDATE()), 1),
    (3, 4, DATEADD(month, -6, GETDATE()), 1);
GO

-- Insert sample classes
INSERT INTO dnd.Classes (ClassName, Description, HitDie, PrimaryAbility, SavingThrowProficiencies, ArmorProficiencies, WeaponProficiencies, SpellCastingAbility, SubclassLevel, SubclassTitle)
VALUES 
    ('Fighter', 'Masters of martial combat, skilled with a variety of weapons and armor.', 'd10', 'Strength or Dexterity', 'Strength, Constitution', 'All armor, shields', 'Simple weapons, martial weapons', NULL, 3, 'Martial Archetype'),
    ('Wizard', 'Scholarly magic-users capable of manipulating the structures of reality.', 'd6', 'Intelligence', 'Intelligence, Wisdom', 'None', 'Daggers, darts, slings, quarterstaffs, light crossbows', 'Intelligence', 2, 'Arcane Tradition'),
    ('Cleric', 'Priestly champions who wield divine magic in service of a higher power.', 'd8', 'Wisdom', 'Wisdom, Charisma', 'Light armor, medium armor, shields', 'Simple weapons', 'Wisdom', 1, 'Divine Domain'),
    ('Rogue', 'Stealthy adventurers skilled at finding and disarming traps, picking locks, and sneaking.', 'd8', 'Dexterity', 'Dexterity, Intelligence', 'Light armor', 'Simple weapons, hand crossbows, longswords, rapiers, shortswords', NULL, 3, 'Roguish Archetype'),
    ('Bard', 'Inspiring magicians whose power echoes the music of creation.', 'd8', 'Charisma', 'Dexterity, Charisma', 'Light armor', 'Simple weapons, hand crossbows, longswords, rapiers, shortswords', 'Charisma', 3, 'Bard College');
GO

-- Insert sample characters
INSERT INTO dnd.Characters (CharacterName, PlayerId, CampaignId, Race, Background, Alignment, Level, ExperiencePoints, 
                          Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma, 
                          HitPoints, MaxHitPoints, ArmorClass, Biography)
VALUES 
    ('Thorin Ironhelm', 2, 1, 'Dwarf', 'Soldier', 'Lawful Good', 3, 900, 16, 12, 16, 10, 13, 8, 28, 28, 16, 'A stout dwarf fighter who served in the militia of his mountain home before seeking adventure.'),
    ('Elaria Moonshadow', 3, 1, 'Elf', 'Sage', 'Neutral Good', 3, 900, 8, 16, 12, 17, 14, 10, 18, 18, 13, 'An elven wizard fascinated by ancient magic and forgotten lore.'),
    ('Brother Lucius', 4, 1, 'Human', 'Acolyte', 'Lawful Good', 3, 900, 14, 10, 14, 12, 16, 13, 24, 24, 18, 'A devoted cleric of Pelor who seeks to bring light to dark places.'),
    ('Varis Darkblade', 2, 2, 'Half-Elf', 'Criminal', 'Chaotic Neutral', 5, 6500, 12, 18, 14, 14, 10, 16, 38, 38, 15, 'A roguish half-elf with a mysterious past and questionable morals.'),
    ('Melody Silverstring', 4, 2, 'Halfling', 'Entertainer', 'Chaotic Good', 5, 6500, 8, 16, 12, 10, 12, 18, 33, 33, 13, 'A halfling bard who uses her music to inspire her allies and confound her enemies.'),
    ('Grimjaw the Mighty', 3, 3, 'Half-Orc', 'Outlander', 'Neutral', 8, 34000, 18, 14, 16, 8, 12, 10, 76, 76, 16, 'A fearsome half-orc barbarian known for his incredible strength and battle prowess.');
GO

-- Insert character classes
INSERT INTO dnd.CharacterClasses (CharacterId, ClassId, ClassLevel, Subclass)
VALUES 
    (1, 1, 3, 'Champion'),       -- Thorin is a Fighter (Champion)
    (2, 2, 3, 'Evocation'),      -- Elaria is a Wizard (Evocation)
    (3, 3, 3, 'Life Domain'),    -- Brother Lucius is a Cleric (Life Domain)
    (4, 4, 5, 'Assassin'),       -- Varis is a Rogue (Assassin)
    (5, 5, 5, 'College of Lore'), -- Melody is a Bard (College of Lore)
    (6, 1, 8, 'Berserker');      -- Grimjaw is a Barbarian (Berserker)
GO

-- Insert sample locations
INSERT INTO dnd.Locations (LocationName, CampaignId, LocationType, Description, Population, Government)
VALUES 
    ('Phandalin', 1, 'Town', 'A small frontier town east of Neverwinter.', '~100', 'Town Master'),
    ('Cragmaw Castle', 1, 'Dungeon', 'An old castle now occupied by goblins.', 'Unknown', 'Tribal Chief'),
    ('Barovia', 2, 'Region', 'A land shrouded in mist and ruled by Count Strahd von Zarovich.', 'Several thousand', 'Feudal Lord'),
    ('Castle Ravenloft', 2, 'Castle', 'The ancient castle home of Strahd von Zarovich.', 'Unknown', 'Count Strahd'),
    ('Crystal City', 3, 'City', 'A magnificent city built on a floating island of crystal.', '~10,000', 'Crystal Council'),
    ('The Shattered Peaks', 3, 'Mountain Range', 'A dangerous mountain range with jagged crystal formations.', 'Sparse', 'None');
GO

-- Insert sample rules
INSERT INTO dnd.Rules (RuleName, Category, Description, ShortDescription, PageReference, GameEdition, IsHouseRule, CampaignId)
VALUES 
    ('Attack Rolls', 'Combat', 'When you make an attack, your attack roll determines whether the attack hits or misses. To make an attack roll, roll a d20 and add the appropriate modifiers. If the total of the roll plus modifiers equals or exceeds the target''s Armor Class (AC), the attack hits.', 'Roll d20 + modifiers vs target AC', 'PHB 193-194', '5e', 0, NULL),
    ('Advantage and Disadvantage', 'Core Mechanics', 'Sometimes a special ability or spell tells you that you have advantage or disadvantage on an ability check, a saving throw, or an attack roll. When that happens, you roll a second d20 when you make the roll. Use the higher of the two rolls if you have advantage, and use the lower roll if you have disadvantage.', 'Roll 2d20 and take higher (advantage) or lower (disadvantage)', 'PHB 173', '5e', 0, NULL),
    ('Critical Success on Skill Checks', 'House Rules', 'When a player rolls a natural 20 on a skill check, they achieve an exceptional success beyond what would normally be possible.', 'Natural 20 on skill checks grants exceptional success', NULL, '5e', 1, 3);
GO

-- Insert sample monsters
INSERT INTO dnd.Monsters (MonsterName, Type, Size, Alignment, ArmorClass, ArmorType, HitPoints, HitDice, Speed,
                        Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma,
                        SavingThrows, Skills, Senses, Languages, ChallengeRating, ExperiencePoints, Source)
VALUES 
    ('Goblin', 'Humanoid', 'Small', 'Neutral Evil', 15, 'Leather armor, shield', 7, '2d6', '30 ft.',
     8, 14, 10, 10, 8, 8, NULL, 'Stealth +6', 'Darkvision 60 ft., passive Perception 9', 'Common, Goblin', '1/4', 50, 'Monster Manual'),
    ('Owlbear', 'Monstrosity', 'Large', 'Unaligned', 13, 'Natural armor', 59, '7d10+21', '40 ft.',
     20, 12, 17, 3, 12, 7, NULL, 'Perception +3', 'Darkvision 60 ft., passive Perception 13', NULL, '3', 700, 'Monster Manual'),
    ('Adult Red Dragon', 'Dragon', 'Huge', 'Chaotic Evil', 19, 'Natural armor', 256, '19d12+133', '40 ft., fly 80 ft.',
     27, 10, 25, 16, 13, 21, 'Dex +6, Con +13, Wis +7, Cha +11', 'Perception +13, Stealth +6', 'Blindsight 60 ft., Darkvision 120 ft., passive Perception 23', 'Common, Draconic', '17', 18000, 'Monster Manual');
GO

PRINT 'Sample data inserted successfully.';
GO