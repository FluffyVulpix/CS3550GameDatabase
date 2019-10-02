IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'GameDatabase')
BEGIN
    EXEC('CREATE SCHEMA GameDatabase')
END

--Drop all tables if they exist in the database already
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesConsoles')
    DROP TABLE GameDatabase.GamesConsoles;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamesEditions')
    DROP TABLE GameDatabase.GamesEditions;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Platforms')
    DROP TABLE GameDatabase.Platforms;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Consoles')
    DROP TABLE GameDatabase.Consoles;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameGenres')
    DROP TABLE GameDatabase.GameGenres;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Genres')
    DROP TABLE GameDatabase.Genres;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GamePublishers')
    DROP TABLE GameDatabase.GamePublishers;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Publishers')
    DROP TABLE GameDatabase.Publishers;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'GameDevelopers')
    DROP TABLE GameDatabase.GameDevelopers;
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Developers')
    DROP TABLE GameDatabase.Developers
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Games')
    DROP TABLE GameDatabase.Games
;

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Regions')
    DROP TABLE GameDatabase.Regions
;


--Regions Table Creation
CREATE TABLE GameDatabase.Regions
(
    RegionID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    RegionName nvarchar(20) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--Games Table Creation
CREATE TABLE GameDatabase.Games
(
    GameID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameName nvarchar(200) NOT NULL,
    isFavorite bit DEFAULT(0) NOT NULL,
    ESRB nvarchar(4) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GamesEditions Table Creation
CREATE TABLE GameDatabase.GamesEditions
(
    GameEditionID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GameID int NOT NULL,
    GameEdition nvarchar(200) NOT NULL,
    Cost decimal(2) NOT NULL,
    CopiesOwned int NOT NULL,
    RegionID int DEFAULT(NULL), --Region Free if null
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GamesEditions
    ADD CONSTRAINT fk_GamesEditions_RegionID FOREIGN KEY (RegionID)
        REFERENCES GameDatabase.Regions (RegionID),
    CONSTRAINT fk_GamesEditions_GameID FOREIGN KEY (GameID)
        REFERENCES GameDatabase.Games (GameID);
;

--Platforms Table Creation
CREATE TABLE GameDatabase.Platforms
(
    PlatformID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleName nvarchar(200) NOT NULL,
    RegionID int DEFAULT(NULL), --Region Free if null
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.Platforms
    ADD CONSTRAINT fk_Platforms_RegionID FOREIGN KEY (RegionID)
        REFERENCES GameDatabase.Regions (RegionID);
;

--Consoles Table Creation
CREATE TABLE GameDatabase.Consoles
(
    ConsoleID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ConsoleEdition nvarchar(200) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GamesConsoles Table Creation
CREATE TABLE GameDatabase.GamesConsoles
(
    GameEditionID int NOT NULL,
    PlatformID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GamesConsoles
    ADD CONSTRAINT pk_GamesConsoles_GameEditionIDPlatformID PRIMARY KEY (GameEditionID,PlatformID),
    CONSTRAINT fk_GamesConsoles_GameEditionID FOREIGN KEY (GameEditionID)
        REFERENCES GameDatabase.GamesEditions (GameEditionID),
    CONSTRAINT fk_GamesConsoles_PlatformID FOREIGN KEY (PlatformID)
        REFERENCES GameDatabase.Platforms (PlatformID);
;

--Developers Table Creation
CREATE TABLE GameDatabase.Developers
(
    DeveloperID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    DeveloperName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GameDevelopers Table Creation
CREATE TABLE GameDatabase.GameDevelopers
(
    GameID int NOT NULL,
    DeveloperID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GameDevelopers
    ADD CONSTRAINT pk_GameDevelopers_GameIDDeveloperID PRIMARY KEY (GameID,DeveloperID),
    CONSTRAINT fk_GameDevelopers_GameID FOREIGN KEY (GameID)
        REFERENCES GameDatabase.Games (GameID),
    CONSTRAINT fk_GameDevelopers_DeveloperID FOREIGN KEY (DeveloperID)
        REFERENCES GameDatabase.Developers (DeveloperID)
;

----Modify
--Publishers Table Creation
CREATE TABLE GameDatabase.Publishers
(
    PublisherID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    PublisherName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GamePublishers Table Creation
CREATE TABLE GameDatabase.GamePublishers
(
    GameID int NOT NULL,
    PublisherID int NOT NULL,
    PublishingYear date NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GamePublishers
    ADD CONSTRAINT pk_GamePublishers_GameIDPublisherD PRIMARY KEY (GameID,PublisherID),
        CONSTRAINT fk_GamePublishers_GameID FOREIGN KEY (GameID)
            REFERENCES GameDatabase.Games (GameID),
        CONSTRAINT fk_GamePublishers_PublisherID FOREIGN KEY (PublisherID)
            REFERENCES GameDatabase.Publishers (PublisherID)
;

--Genres Table Creation
CREATE TABLE GameDatabase.Genres
(
    GenreID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
    GenreName nvarchar(100) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)

--GameGenres Table Creation
CREATE TABLE GameDatabase.GameGenres
(
    GameID int NOT NULL,
    GenreID int NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.GameGenres
    ADD CONSTRAINT pk_GameGenres_GameIDGenreID PRIMARY KEY (GameID,GenreID),
        CONSTRAINT fk_GameGenres_GameID FOREIGN KEY (GameID)
            REFERENCES GameDatabase.Games (GameID),
        CONSTRAINT fk_GameGenres_GenreID FOREIGN KEY (GenreID)
            REFERENCES GameDatabase.Genres (GenreID)
;
