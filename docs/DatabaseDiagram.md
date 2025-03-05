# DM-DB Database Diagram

Below is a textual representation of the database schema relationships. This can be used to visualize how the tables are connected.

```
Users
  |
  |---- Campaigns (DungeonMasterId → UserId)
  |      |
  |      |---- CampaignPlayers (CampaignId → CampaignId)
  |      |      |
  |      |      |---- Users (PlayerId → UserId)
  |      |
  |      |---- Characters (CampaignId → CampaignId)
  |      |      |
  |      |      |---- Users (PlayerId → UserId)
  |      |      |
  |      |      |---- CharacterClasses (CharacterId → CharacterId)
  |      |             |
  |      |             |---- Classes (ClassId → ClassId)
  |      |
  |      |---- Locations (CampaignId → CampaignId)
  |      |      |
  |      |      |---- Locations (ParentLocationId → LocationId) [Self-referencing]
  |      |
  |      |---- Rules (CampaignId → CampaignId)
  |
  |---- Characters (PlayerId → UserId)
```

## Entity Relationship Diagram (ERD)

For a more visual representation, you can use a tool like [dbdiagram.io](https://dbdiagram.io), [Lucidchart](https://www.lucidchart.com), or [draw.io](https://draw.io) to create an ERD using the following relationships:

### Primary Entities
- Users (DMs and Players)
- Campaigns
- Characters
- Classes
- Monsters
- Locations
- Rules

### Relationships
- One User can be the DM for many Campaigns (1:N)
- One Campaign can have many Players through CampaignPlayers (N:M)
- One Campaign can have many Characters (1:N)
- One User (Player) can have many Characters (1:N)
- One Character can have many Classes through CharacterClasses (N:M)
- One Campaign can have many Locations (1:N)
- One Location can have many child Locations (1:N, self-referencing)
- One Campaign can have many custom Rules (1:N)

## Full Schema

The full database schema includes the following tables:

1. **Users** - Stores information about Dungeon Masters and Players
2. **Campaigns** - Stores information about D&D campaigns
3. **CampaignPlayers** - Junction table for the many-to-many relationship between Players and Campaigns
4. **Characters** - Stores player characters
5. **Classes** - Stores character classes
6. **CharacterClasses** - Junction table for the many-to-many relationship between Characters and Classes
7. **Monsters** - Stores monster information
8. **Locations** - Stores campaign locations
9. **Rules** - Stores game rules and house rules

## Views

1. **vw_CharacterDetails** - Provides a consolidated view of character information

## Stored Procedures

1. **GetCampaignDetails** - Retrieves detailed information about a campaign