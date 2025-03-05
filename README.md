# DM-DB: Dungeon Master Database

A SQL Server database project for tracking Dungeons & Dragons campaigns, characters, and game elements.

## Purpose

This database is designed to help Dungeon Masters and players track:
- Users (DMs and Players)
- Campaigns
- Characters
- Character Classes
- Monsters
- Game Rules
- Locations
- Items
- Spells
- And more!

## Project Structure

- `/schema/` - Contains table definitions
- `/stored_procedures/` - Contains stored procedures
- `/views/` - Contains view definitions
- `/functions/` - Contains user-defined functions
- `/data/` - Contains seed data scripts

## Getting Started

1. Clone this repository
2. Use SQL Server Management Studio or Azure Data Studio to connect to your SQL Server instance
3. Execute the scripts in the following order:
   - First run all scripts in `/schema/` to create tables
   - Then run scripts in `/data/` to populate initial data (optional)
   - Finally run scripts in other folders as needed

## Database Diagram

A database diagram will be added soon to visualize the relationships between tables.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.