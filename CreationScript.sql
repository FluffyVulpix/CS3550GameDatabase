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

IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Consoles')
    DROP TABLE GameDatabase.Consoles;
;
IF EXISTS (SELECT 1 FROM sys.tables WHERE Name = 'Platforms')
    DROP TABLE GameDatabase.Platforms;
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
    PlatformID int NOT NULL,
    ConsoleEdition nvarchar(200) NOT NULL,
    CreationDate datetime2 DEFAULT(getdate()) NOT NULL
)
ALTER TABLE GameDatabase.Consoles
    ADD CONSTRAINT fk_Consoles_PlatformID FOREIGN KEY (PlatformID)
        REFERENCES GameDatabase.Platforms (PlatformID)
;

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


INSERT INTO GameDatabase.Games
(
    GameName,
    isFavorite,
    ESRB
)
VALUES
('Gears 5',0,'M')
,('Super Mario Odyssey',1,'E')
,('Horizon Zero Dawn',1,'T')
,('Donkey Kong Country',0,'E')
,('Halo 5: Guardians',1,'M')
,('The Last of Us',0,'M')
,('Super Mario 64',1,'E')
,('God of War',0,'M')
,('Overwatch',1,'T')
,('Titanfall 2',0,'M')
,('Marvel`s Spider-Man',0,'T')
,('FIFA 19',0,'E')
,('NHL 19',0,'E')
,('Cuphead',0,'E')
,('Halo Wars 2',0,'T')

INSERT INTO GameDatabase.Platforms
(
    ConsoleName,
    RegionID
)
VALUES
('PlayStation 4',NULL) --Region Free
,('Xbox One',NULL) --Region Free
,('Nintendo Switch',NULL) --Region Free
,('Nintendo 64', (SELECT RegionID FROM GameDatabase.Regions WHERE RegionName = 'NTSC'))
,('Super Nintendo Entertainment System (SNES)', (SELECT RegionID FROM GameDatabase.Regions WHERE RegionName = 'NTSC'))
;

INSERT INTO GameDatabase.Consoles
(
    ConsoleEdition,
    PlatformID
)
VALUES
('Xbox One X', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Xbox One'))
,('Xbox One S', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Xbox One'))
,('PlayStation 4', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'PlayStation 4'))
,('PlayStation 4 Pro', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'PlayStation 4'))
,('Nintendo Switch', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Nintendo Switch'))
,('Nintendo Switch Lite', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Nintendo Switch'))
,('Super Nintendo Entertainment System (SNES)', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Super Nintendo Entertainment System (SNES)'))
,('Nintendo 64', (SELECT PlatformID FROM GameDatabase.Platforms WHERE ConsoleName = 'Nintendo 64'))
;

INSERT INTO Gamedatabase.Regions
(
    RegionName
)
VALUES 
('NTSC-J')
,('NTSC')
,('PAL')
;

INSERT INTO GameDatabase.GamesEditions
(
    GameID,
    GameEdition,
    Cost,
    CopiesOwned,
    RegionID
)
VALUES 
((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Gears 5'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario Odyssey'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Horizon Zero Dawn'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Donkey Kong Country'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo 5: Guardians'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'The Last of Us'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario 64'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'God Of War'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Overwatch'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Titanfall 2'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Marvel`s Spider-Man'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'FIFA 19'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'NHL 19'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Cuphead'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo Wars 2'),'Basic',59.99,1,(SELECT RegionID FROM Gamedatabase.Regions WHERE RegionName = 'NTSC'))

--Adding a GamesConsoles link to the database
--TODO: Region linking to make sure a console isn't linked to a game it can't play.
IF EXISTS
	(SELECT * FROM INFORMATION_SCHEMA.ROUTINES
		WHERE SPECIFIC_NAME = 'usp_addGamesConsoles')
	DROP PROCEDURE dbo.usp_addGamesConsoles
GO
CREATE PROCEDURE dbo.usp_addGamesConsoles
    @GameName nvarchar(200),
    @PlatformName nvarchar(200)
AS
BEGIN
    DECLARE @GameEditionID int;
        SELECT @GameEditionID = gdge.GameEditionID
            FROM GameDatabase.GamesEditions gdge
                INNER JOIN GameDatabase.Games gdg ON gdge.GameID = gdg.GameID
            WHERE gdg.GameName = @GameName
    ;
    
    DECLARE @PlatformID int;
        SELECT @PlatformID = gdp.PlatformID
            FROM GameDatabase.Platforms gdp
            WHERE gdp.ConsoleName = @PlatformName
    ;

	BEGIN TRY
		INSERT INTO GameDatabase.GamesConsoles
			(
				GameEditionID,
                PlatformID
			)
			VALUES
			(
				@GameEditionID,
                @PlatformID
			)
	END TRY
	BEGIN CATCH
		PRINT('INSERT INTO pbUser FAILED');
	END CATCH
END
GO

EXEC usp_addGamesConsoles 'Gears 5','Xbox One';
EXEC usp_addGamesConsoles 'Super Mario Odyssey','Nintendo Switch';
EXEC usp_addGamesConsoles 'Horizon Zero Dawn','PlayStation 4';
EXEC usp_addGamesConsoles 'Donkey Kong Country','Super Nintendo Entertainment System (SNES)';
EXEC usp_addGamesConsoles 'Halo 5: Guardians','Xbox One';
EXEC usp_addGamesConsoles 'The Last of Us','Playstation 4';
EXEC usp_addGamesConsoles 'Super Mario 64','Nintendo 64';
EXEC usp_addGamesConsoles 'God of War','PlayStation 4';
EXEC usp_addGamesConsoles 'Overwatch','Xbox One';
EXEC usp_addGamesConsoles 'Titanfall 2','Xbox One';
EXEC usp_addGamesConsoles 'Marvel`s Spider-Man','PlayStation 4';
EXEC usp_addGamesConsoles 'FIFA 19','Xbox One';
EXEC usp_addGamesConsoles 'NHL 19','Xbox One';
EXEC usp_addGamesConsoles 'Cuphead','Xbox One';
EXEC usp_addGamesConsoles 'Halo Wars 2','Xbox One';

INSERT INTO GameDatabase.Genres
(
    GenreName
)
VALUES
('Shooter')
,('Platformer')
,('Strategy')
,('Sports')
,('Role Playing')


INSERT INTO GameDatabase.GameGenres
(
    GameID,
    GenreID
)
VALUES
((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Gears 5'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario Odyssey'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Platformer'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Horizon Zero Dawn'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Donkey Kong Country'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Platformer'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo 5: Guardians'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'The Last of Us'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario 64'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Platformer'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'God Of War'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Role Playing'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Overwatch'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Titanfall 2'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Shooter'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Marvel`s Spider-Man'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Role Playing'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'FIFA 19'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Sports'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'NHL 19'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Sports'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Cuphead'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Platformer'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo Wars 2'),(SELECT GenreID FROM Gamedatabase.Genres WHERE GenreName = 'Strategy'))


INSERT INTO GameDatabase.Publishers
VALUES 
('Microsoft Studios',GETDATE()) -- Halos, Gears
,('EA Sports',GETDATE()) --FIFA NHL
,('Sony Interactive Entertainment',GETDATE())--SpiderMan, GOd
,('Blizzard Entertainment',GETDATE())--Overwatch
,('Nintendo',GETDATE())--Super Mario 64, Odyssey, Kong Country
,('Sony Computer Entertainment, Inc. (SCEI)',GETDATE())--The Last of us, II Horizon
,('Studio MDHR',GETDATE())--Cuphead
,('Electronic Arts',GETDATE()) -- Titanfall


INSERT INTO GameDatabase.GamePublishers
(
    GameID,
    PublisherID,
    PublishingYear
)
VALUES
((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Gears 5'),(SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Microsoft Studios'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario Odyssey'),(SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Nintendo'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Horizon Zero Dawn'),	 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Sony Computer Entertainment, Inc. (SCEI)'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Donkey Kong Country'),(SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Nintendo'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo 5: Guardians'),	 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Microsoft Studios'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'The Last of Us'),	 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Sony Computer Entertainment, Inc. (SCEI)'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario 64'),	 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Nintendo'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'God Of War'),		 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Sony Interactive Entertainment'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Overwatch'),			 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Blizzard Entertainment'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Titanfall 2'),		 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Electronic Arts'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Marvel`s Spider-Man'),(SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Sony Interactive Entertainment'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'FIFA 19'),			 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'EA Sports'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'NHL 19'),			 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'EA Sports'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Cuphead'),			 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Studio MDHR'),'2019/09/06')
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo Wars 2'),		 (SELECT PublisherID FROM Gamedatabase.Publishers WHERE PublisherName = 'Microsoft Studios'),'2019/09/06')




INSERT INTO GameDatabase.Developers
VALUES
('343 Industries',GETDATE())-- Halos, Gears
,('EA Canada',GETDATE())--FIFA NHL
,('Insomniac Games',GETDATE())--SpiderMan
,('Blizzard Entertainment',GETDATE())--Overwatch
,('Nintendo EAD',GETDATE())--Super Mario 64
,('Naughty Dog',GETDATE())--The Last of us, II
,('Nintendo EPD',GETDATE())-- Odyssey
,('Guerrilla Games',GETDATE()) --Horizon
,('Studio MDHR',GETDATE())--Cuphead
,('Respawn Entertainment',GETDATE()) -- Titanfall
,('Rare',GETDATE()) --KongCountry
,('SIE Santa Monica Studio',GETDATE()) --GOD


INSERT INTO GameDatabase.GameDevelopers
(
    GameID,
    DeveloperID
)
VALUES
((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Gears 5'),(SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = '343 Industries'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario Odyssey'),(SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Nintendo EPD'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Horizon Zero Dawn'),	 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Guerrilla Games'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Donkey Kong Country'),(SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Rare'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo 5: Guardians'),	 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = '343 Industries'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'The Last of Us'),	 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Naughty Dog'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Super Mario 64'),	 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Nintendo EAD'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'God Of War'),		 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'SIE Santa Monica Studio'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Overwatch'),			 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Blizzard Entertainment'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Titanfall 2'),		 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Respawn Entertainment'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Marvel`s Spider-Man'),(SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Insomniac Games'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'FIFA 19'),			 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'EA Canada'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'NHL 19'),			 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'EA Canada'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Cuphead'),			 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = 'Studio MDHR'))
,((SELECT GameID FROM Gamedatabase.Games WHERE GameName = 'Halo Wars 2'),		 (SELECT DeveloperID FROM Gamedatabase.Developers WHERE DeveloperName = '343 Industries'))

--Generate a list of consoles
SELECT 
P.ConsoleName, 
C.ConsoleEdition

FROM 
    GameDatabase.Consoles C 
    JOIN GameDatabase.Platforms P ON C.PlatformID = P.PlatformID;


--Returns all games in the collection
SELECT
	G.GameName,
    E.GameEdition

FROM
	GameDatabase.Games G 
    JOIN GameDatabase.GamesEditions E ON G.GameID = E.GameID;


--Returns all Xbox One games
SELECT
	G.GameName

FROM
	GameDatabase.Games G 
    JOIN GameDatabase.GamesEditions GE ON G.GameID = GE.GameID
    JOIN GameDatabase.GamesConsoles GC ON GC.GameEditionID = GE.GameEditionID
    JOIN GameDatabase.Platforms P ON P.PlatformID = GC.PlatformID

WHERE
    P.ConsoleName = 'Xbox One';
	

--Returns all games with multiple copies (With the platform they are on)
SELECT
	G.GameName,
	GE.GameEdition,
	P.ConsoleName
	
FROM
    GameDatabase.GamesEditions GE 
    JOIN GameDatabase.Games G ON GE.GameID = G.GameID
    JOIN GameDatabase.GamesConsoles GC ON GC.GameEditionID = GE.GameEditionID
    JOIN GameDatabase.Platforms P ON GC.PlatformID = P.PlatformID

WHERE
    GE.CopiesOwned > 1;


--Returns all Role Playing games, including the platform they are on
SELECT
	G.GameName,
	P.ConsoleName

FROM
	GameDatabase.GamesEditions GE JOIN GameDatabase.Games G ON GE.GameID = G.GameID
    JOIN GameDatabase.GamesConsoles GC ON GC.GameEditionID = GE.GameEditionID
    JOIN GameDatabase.Platforms P ON GC.PlatformID = P.PlatformID
    JOIN GameDatabase.GameGenres GG ON GG.GameID = GE.GameID
    JOIN GameDatabase.Genres GEN ON GEN.GenreID = GG.GenreID

WHERE
	GEN.GenreName = 'Role Playing';