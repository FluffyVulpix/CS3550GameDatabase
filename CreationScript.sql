IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'GameDatabase')
BEGIN
    EXEC('CREATE SCHEMA GameDatabase')
END

--Games Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Games')
BEGIN
    EXEC('DROP TABLE GameDatabase.Games')
END
CREATE TABLE GameDatabase.Games
(
    GameID int,
    GameName nvarchar(200),
    isFavorite bit,
    ESRB nvarchar(3),
    CreationDate datetime2
)


--GamesEditions Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesEditions')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesEditions')
END
CREATE TABLE GameDatabase.GamesEditions
(
    GameEditionID int,
    GameID int,
    Cost decimal(2),
    GameEdition nvarchar(200),
    CreationDate datetime2
)


--Platforms Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Platforms')
BEGIN
    EXEC('DROP TABLE GameDatabase.Platforms')
END
CREATE TABLE GameDatabase.Platforms
(
    PlatformID int,
    ConsoleID int,
    ConsoleName nvarchar(200),
    CreationDate datetime2
)

--Consoles Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Consoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.Consoles')
END
CREATE TABLE GameDatabase.Consoles
(
    ConsoleID int,
    ConsoleEdition nvarchar(200),
    CreationDate datetime2
)

--GamesConsoles Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesConsoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesConsoles')
END
CREATE TABLE GameDatabase.GamesConsoles
(
    GameEditionID int,
    ConsoleID int,
    CreationDate datetime2
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Developers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Developers')
END
CREATE TABLE GameDatabase.Developers
(
    DeveloperID int,
    DeveloperName nvarchar(100),
    CreationDate datetime2
)

--GameDevelopers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameDevelopers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameDevelopers')
END
CREATE TABLE GameDatabase.GameDevelopers
(
    GameID int,
    DeveloperID int,
    CreationDate datetime2
)

----Modify
--Publishers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Publishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Publishers')
END
CREATE TABLE GameDatabase.Publishers
(
    PublisherID int,
    PublisherName nvarchar(100),
    CreationDate datetime2
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamePublishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamePublishers')
END
CREATE TABLE GameDatabase.GamePublishers
(
    GameID int,
    PublisherID int,
    PublishingYear date,
    CreationDate datetime2
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Genres')
BEGIN
    EXEC('DROP TABLE GameDatabase.Genres')
END
CREATE TABLE GameDatabase.Genres
(
    GenreID int,
    GenreName nvarchar(100),
    CreationDate datetime2
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameGenres')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameGenres')
END
CREATE TABLE GameDatabase.GameGenres
(
    GameID int,
    GenreID int,
    CreationDate datetime2
)