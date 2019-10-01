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
    GameID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameName nvarchar(200) NOT NULL,
    isFavorite bit DEFAULT(0) NOT NULL,
    ESRB nvarchar(4) NOT NULL,
    isPAL bit DEFAULT(0) NOT NULL,
    isNTSC bit DEFAULT(0) NOT NULL,
    isNTSCJ bit DEFAULT(0) NOT NULL,
    isNTSCK bit DEFAULT(0) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)


--GamesEditions Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesEditions')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesEditions')
END
CREATE TABLE GameDatabase.GamesEditions
(
    GameEditionID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameID int NOT NULL,
    GameEdition nvarchar(200) NOT NULL,
    Cost decimal(2) NOT NULL,
    CopiesOwned int NOT NULL,
    CreationDate datetime2 NOT NULL
)


--Platforms Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Platforms')
BEGIN
    EXEC('DROP TABLE GameDatabase.Platforms')
END
CREATE TABLE GameDatabase.Platforms
(
    PlatformID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleID int NOT NULL,
    ConsoleName nvarchar(200) NOT NULL,
    CreationDate datetime2 NOT NULL
)

--Consoles Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Consoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.Consoles')
END
CREATE TABLE GameDatabase.Consoles
(
    ConsoleID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleEdition nvarchar(200) NOT NULL,
    CreationDate datetime2 NOT NULL
)

--GamesConsoles Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesConsoles')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamesConsoles')
END
CREATE TABLE GameDatabase.GamesConsoles
(
    GameEditionID int NOT NULL,
    ConsoleID int NOT NULL,
    CreationDate datetime2 NOT NULL
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Developers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Developers')
END
CREATE TABLE GameDatabase.Developers
(
    DeveloperID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DeveloperName nvarchar(100) NOT NULL,
    CreationDate datetime2 NOT NULL
)

--GameDevelopers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameDevelopers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameDevelopers')
END
CREATE TABLE GameDatabase.GameDevelopers
(
    GameID int NOT NULL,
    DeveloperID int NOT NULL,
    CreationDate datetime2 NOT NULL
)

----Modify
--Publishers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Publishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.Publishers')
END
CREATE TABLE GameDatabase.Publishers
(
    PublisherID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    PublisherName nvarchar(100) NOT NULL,
    CreationDate datetime2 NOT NULL
)

--GamePublishers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamePublishers')
BEGIN
    EXEC('DROP TABLE GameDatabase.GamePublishers')
END
CREATE TABLE GameDatabase.GamePublishers
(
    GameID int NOT NULL,
    PublisherID int NOT NULL,
    PublishingYear date NOT NULL,
    CreationDate datetime2 NOT NULL
)

--Genres Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Genres')
BEGIN
    EXEC('DROP TABLE GameDatabase.Genres')
END
CREATE TABLE GameDatabase.Genres
(
    GenreID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GenreName nvarchar(100) NOT NULL,
    CreationDate datetime2 NOT NULL
)

--Developers Table Creation
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameGenres')
BEGIN
    EXEC('DROP TABLE GameDatabase.GameGenres')
END
CREATE TABLE GameDatabase.GameGenres
(
    GameID int NOT NULL,
    GenreID int NOT NULL,
    CreationDate datetime2 NOT NULL
)