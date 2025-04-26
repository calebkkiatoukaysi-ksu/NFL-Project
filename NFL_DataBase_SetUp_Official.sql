/*
This will be our set up for our database.
*/

DROP DATABASE IF EXISTS NFL_PROJECT;

CREATE DATABASE NFL_PROJECT;

USE NFL_PROJECT

-- It has begun... 

/*
TO DO: We will have to alter the tables, remove the foreign key contraints I left it ere because it was nice. 
*/

IF SCHEMA_ID(N'NFL') IS NULL 
    EXEC(N'Create SCHEMA NFL');
GO

/*
CREATE TABLE NFL.Player
(
    PlayerID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    TeamID INT,
    PlayerTeamID INT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Height NVARCHAR(50) NOT NULL, -- Note: Height will be displayed as 6' 3 "
    [Weight] INT NOT NULL,
    MainPosition NVARCHAR(50),
    FOREIGN KEY (TeamID) REFERENCES NFL.PlayerTeam(TeamID),
    FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID)
);

CREATE TABLE NFL.PlayerTeam 
(
    PlayerTeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    PlayerID INT NOT NULl,
    TeamID INT NOT NULL,
    ContractFirstYear DATE,
    ContractLastYear DATE,
    FOREIGN KEY (PlayerID) REFERENCES NFL.Player(PlayerID),
    FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT [U1_PlayerTeam] UNIQUE (ContractFirstYear, PlayerID),
    CONSTRAINT [U2_PlayerTeam] UNIQUE (PlayerTeamID, TeamID)
);

CREATE TABLE NFL.OffensiveStats (
    OffensiveStatsID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    PlayerTeamID INT,
    TeamID INT,
    TeamGameID INT,
    PassingYDs INT NULL,
    PassingTDs INT NULL,
    PassingINTs INT NULL,
    Carries INT NULL,
    RushingYDs INT NULL,
    RushingTDs INT NULL,
    RushingFUMs INT NULL,
    Receptions INT NULL,
    ReceivingYDs INT NULL,
    ReceivingTDs INT NULL,
    CONSTRAINT OffensiveStats_FK_1 FOREIGN KEY (PlayerTeamID, TeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID, TeamID),
    CONSTRAINT OffensiveStats_FK_2 FOREIGN KEY (TeamID, TeamGameID) REFERENCES NFL.TeamGame(TeamID, TeamGameID)
);

CREATE TABLE NFL.TeamGame
(
    TeamGameID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GameID INT NOT NULL,
    TeamTypeID INT NOT NULL,
    TeamID INT NOT NULL,
    CONSTRAINT TeamGame_FK_1 FOREIGN KEY (GameID) REFERENCES NFL.Game(GameID),
    CONSTRAINT TeamGame_FK_2 FOREIGN KEY (TeamTypeID) REFERENCES NFL.TeamType(TeamTypeID),
    CONSTRAINT TeamGame_FK_3 FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT TeamGame_U_1 UNIQUE (GameID, TeamTypeID),
    CONSTRAINT TeamGame_U_2 UNIQUE (TeamGameID, TeamID),
    CONSTRAINT TeamGame_U_3 UNIQUE (GameID, TeamID)
)

CREATE TABLE NFL.Game
(
    GameID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Location] NVARCHAR(50) NOT NULL,
    GameDate  NVARCHAR(50) NOT NULL -- can we do SYSDATE? Raw table has it as NVARCHAR(50)
    CONSTRAINT Game_U_1 UNIQUE ([Location], GameDate) 
)

CREATE TABLE NFL.TeamType
(
    TeamTypeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50),
    CONSTRAINT TeamType_U_1 UNIQUE([Name])
)

CREATE TABLE NFL.Team 
(
    TeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    DivisionID INT NOT NULl,
    ConferenceID INT NOT NULL,
    TeamGameID INT NOT NULL,
    DivisionSeeding INT NOT NULL,
    ConferenceSeeding INT NOT NULL,
    IsConferenceChamp BIT, -- 0 for false, 1 for true.
    City NVARCHAR(50),
    [State] NVARCHAR(50),
    StadiumName NVARCHAR(50),
    CONSTRAINT Team_FK_1 FOREIGN KEY(DivisionID, ConferenceID) REFERENCES NFL.Division(DivisionID, ConferenceID),
    CONSTRAINT Team_FK_2 FOREIGN KEY(TeamGameID) REFERENCES NFL.TeamGame(TeamGameID),
    CONSTRAINT Team_U_1 UNIQUE(DivisionID, DivisionSeeding),
    CONSTRAINT Team_U_2 UNIQUE(ConferenceID, ConferenceSeeding)
)

CREATE TABLE NFL.Division
(
    DivisionID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    TeamID INT NOT NULL,
    ConferenceID INT NOT NULL,
    DivisionName NVARCHAR(50) NOT NULL,
    CONSTRAINT Division_FK_1 FOREIGN KEY(TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT Division_FK_2 FOREIGN KEY(ConferenceID) REFERENCES NFL.Conference(ConferenceID),
    CONSTRAINT Division_U_1 UNIQUE(DivisionID, ConferenceID),
    CONSTRAINT Division_U_2 UNIQUE(DivisionName)
)

CREATE TABLE NFL.Conference
(
    ConferenceID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    ConferenceName NVARCHAR(50) NOT NULL,
    CONSTRAINT Conference_U_1 UNIQUE (ConferenceName),
)
*/

/* NOTES:
FOR NOW:
WE SET 
NFL.Team: TeamGameID NULL
NFL.Player: PlayerTeamID NULL
reset these after population.
*/

--Create Tables (Will alter them to have their constraints later)--
CREATE TABLE NFL.Player (
    PlayerID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    TeamID INT,
    PlayerTeamID INT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Height NVARCHAR(50) NULL, -- Note: Height will be displayed as 6' 3 " (Some players dont have height listed)
    [Weight] INT NOT NULL,
    MainPosition NVARCHAR(50)
);

CREATE TABLE NFL.PlayerTeam (
    PlayerTeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    PlayerID INT NOT NULL,
    TeamID INT NOT NULL,
    ContractFirstYear INT,
    ContractLastYear INT
);

CREATE TABLE NFL.OffensiveStats (
    OffensiveStatsID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    PlayerTeamID INT,
    TeamID INT,
    TeamGameID INT,
    PassingYDs INT NULL,
    PassingTDs INT NULL,
    PassingINTs INT NULL,
    Carries INT NULL,
    RushingYDs INT NULL,
    RushingTDs INT NULL,
    RushingFUMs INT NULL,
    Receptions INT NULL,
    ReceivingYDs INT NULL,
    ReceivingTDs INT NULL
);

CREATE TABLE NFL.TeamGame (
    TeamGameID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    GameID INT NOT NULL,
    TeamTypeID INT NOT NULL,
    TeamID INT NOT NULL
);

CREATE TABLE NFL.Game (
    GameID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Location] NVARCHAR(50) NOT NULL,
    GameDate NVARCHAR(50) NOT NULL -- FIX? FIND A WAY TO MAKE THIS A DATE
);


CREATE TABLE NFL.TeamType (
    TeamTypeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(50)
);

CREATE TABLE NFL.Team (
    TeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    DivisionID INT NOT NULL,
    ConferenceID INT NOT NULL,
    TeamGameID INT NOT NULL,
    DivisionSeeding INT NOT NULL,
    ConferenceSeeding INT NOT NULL,
    IsConferenceChamp NVARCHAR(50) NOT NULL, --True or False
    City NVARCHAR(50),
    [State] NVARCHAR(50),
    [Name] NVARCHAR(50),
    StadiumName NVARCHAR(50)
);

CREATE TABLE NFL.Division (
    DivisionID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ConferenceID INT NOT NULL,
    DivisionName NVARCHAR(50) NOT NULL
);

CREATE TABLE NFL.Conference (
    ConferenceID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    ConferenceName NVARCHAR(50) NOT NULL
);

-- Populate the tables--


-- Starting from easiest (plz work)--
INSERT INTO NFL.Conference (ConferenceName)
VALUES 
    ('NFC'), 
    ('AFC');

-- 1 is NFC, 2 is AFC --
INSERT INTO NFL.Division(ConferenceID, DivisionName)
VALUES
    (1, N'NFC North'),
    (1, N'NFC East'),
    (1, N'NFC South'),
    (1, N'NFC West'),
    (2, N'AFC North'),
    (2, N'AFC East'),
    (2, N'AFC South'),
    (2, N'AFC West');

-- 1 is home, 2 is away. This will help us identify home and away teams.
INSERT INTO NFL.TeamType([Name])
VALUES 
    (N'Home'),
    (N'Away');

INSERT INTO NFL.Game ([Location], [GameDate])
SELECT s.Location, s.Date
FROM dbo.NFL_SCHEDULE_RAW s; -- i love the raw tables

-- Manually doing it since its only 32 teams + more confidence lol (will order divisions for better readability)
ALTER TABLE NFL.Team
ALTER COLUMN TeamGameID INT NULL; -- will have to make it not null once we populate teamgame

-- all data is accurate, thanks espn --  (took 30 mins)
INSERT INTO NFL.Team (DivisionID, ConferenceID, DivisionSeeding, ConferenceSeeding, IsConferenceChamp, City, State, [Name], StadiumName)
VALUES
-- NFC North
(1, 1, 1, 1, N'False', N'Detroit', N'MI', N'Lions', N'Ford Field'),
(1, 1, 2, 5, N'False', N'Minnesota', N'MN', N'Vikings', N'U.S. Bank Stadium'),
(1, 1, 3, 7, N'False', N'Green Bay', N'WI', N'Packers', N'Lambeau Field'),
(1, 1, 4, 13, N'False', N'Chicago', N'IL', N'Bears', N'Soldier Field'),

-- NFC East
(2, 1, 1, 2, N'True', N'Philadelphia', N'PA', N'Eagles', N'Lincoln Financial Field'),
(2, 1, 2, 6, N'False', N'Washington', N'DC', N'Commanders', N'FedEx Field'),
(2, 1, 3, 11, N'False', N'Dallas', N'TX', N'Cowboys', N'AT&T Stadium'),
(2, 1, 4, 16, N'False', N'New York', N'NY', N'Giants', N'MetLife Stadium'),

-- NFC South
(3, 1, 1, 3, N'False', N'Tampa Bay', N'FL', N'Buccaneers', N'Raymond James Stadium'),
(3, 1, 2, 9, N'False', N'Atlanta', N'GA', N'Falcons', N'Mercedes-Benz Stadium'),
(3, 1, 3, 14, N'False', N'Carolina', N'NC', N'Panthers', N'Bank of America Stadium'),
(3, 1, 4, 15, N'False', N'New Orleans', N'LA', N'Saints', N'Caesars Superdome'),

-- NFC West
(4, 1, 1, 4, N'False', N'Los Angeles', N'CA', N'Rams', N'SoFi Stadium'),
(4, 1, 2, 8, N'False', N'Seattle', N'WA', N'Seahawks', N'Lumen Field'),
(4, 1, 3, 10, N'False', N'Arizona', N'AZ', N'Cardinals', N'State Farm Stadium'),
(4, 1, 4, 12, N'False', N'San Francisco', N'CA', N'49ers', N'Levi’s Stadium'),

-- AFC North
(5, 2, 1, 3, N'False', N'Baltimore', N'MD', N'Ravens', N'M&T Bank Stadium'),
(5, 2, 2, 6, N'False', N'Pittsburgh', N'PA', N'Steelers', N'Acrisure Stadium'),
(5, 2, 3, 8, N'False', N'Cincinnati', N'OH', N'Bengals', N'Paycor Stadium'),
(5, 2, 4, 15, N'False', N'Cleveland', N'OH', N'Browns', N'Cleveland Browns Stadium'),

-- AFC East
(6, 2, 1, 2, N'False', N'Buffalo', N'NY', N'Bills', N'Highmark Stadium'),
(6, 2, 2, 10, N'False', N'Miami', N'FL', N'Dolphins', N'Hard Rock Stadium'),
(6, 2, 3, 11, N'False', N'New York', N'NY', N'Jets', N'MetLife Stadium'),
(6, 2, 4, 13, N'False', N'New England', N'MA', N'Patriots', N'Gillette Stadium'),

-- AFC South
(7, 2, 3, 4, N'False', N'Houston', N'TX', N'Texans', N'NRG Stadium'),
(7, 2, 4, 9, N'False', N'Indianapolis', N'IN', N'Colts', N'Lucas Oil Stadium'),
(7, 2, 1, 12, N'False', N'Jacksonville', N'FL', N'Jaguars', N'EverBank Stadium'),
(7, 2, 2, 16, N'False', N'Tennessee', N'TN', N'Titans', N'Nissan Stadium'),

-- AFC West
(8, 2, 1, 1, N'True', N'Kansas City', N'MO', N'Chiefs', N'Arrowhead Stadium'),
(8, 2, 2, 5, N'False', N'Los Angeles', N'CA', N'Chargers', N'SoFi Stadium'),
(8, 2, 3, 7, N'False', N'Denver', N'CO', N'Broncos', N'Empower Field at Mile High'),
(8, 2, 4, 14, N'False', N'Las Vegas', N'NV', N'Raiders', N'Allegiant Stadium');

-- Make TeamGame -- (geez)

INSERT INTO NFL.TeamGame (GameID, TeamTypeID, TeamID)
SELECT GameID, 1, HomeTeamID FROM (
    SELECT haf.game_id AS GameID, t1.TeamID AS HomeTeamID FROM dbo.home_away_fixed haf
    INNER JOIN NFL.Team t1 ON t1.[Name] = haf.Home_Team  -- compare the names of the home teams 
) AS HomeTeams
UNION ALL
SELECT GameID, 2, AwayTeamID FROM (
    SELECT haf.game_id AS GameID, t2.TeamID AS AwayTeamID FROM dbo.home_away_fixed haf
    JOIN NFL.Team t2 ON t2.[Name] = haf.Home_Team -- compare the names of the away teams
) AS AwayTeams;

-- Make Player Table -- 
ALTER TABLE NFL.Player
ALTER COLUMN PLayerTeamID INT NULL; -- will have to reset

INSERT INTO NFL.Player(TeamID, FirstName, LastName, Height, [Weight], MainPosition)
SELECT t.TeamID, r.first_name, r.last_name, r.height, r.[weight], r.[position]
FROM dbo.roster_fixed_raw r
INNER JOIN NFL.Team t ON t.Name = r.team



-- Make PlayerTeam
ALTER TABLE NFL.PlayerTeam
ALTER COLUMN ContractFirstYear INT NOT NULL;

ALTER TABLE NFL.PlayerTeam
ALTER COLUMN ContractLastYear INT NOT NULL;

drop table NFL.PlayerTeam



INSERT INTO NFL.PlayerTeam (PlayerID, TeamID, ContractFirstYear, ContractLastYear)
SELECT DISTINCT p.PlayerID, t.TeamID, c.year_signed, c.year_end
FROM dbo.NFL_CONTRACTS_RAW c
INNER JOIN NFL.Team t ON t.Name = c.team
INNER JOIN NFL.Player p ON p.PlayerID = c.PlayerID;

/*
CREATE TABLE NFL.PlayerTeam (
    PlayerTeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    PlayerID INT NOT NULL,
    TeamID INT NOT NULL,
    ContractFirstYear INT,
    ContractLastYear INT
);
*/
ALTER TABLE dbo.NFL_CONTRACTS_RAW
ADD PlayerID INT NULL;




select *
from dbo.roster_fixed_raw
select  *
from NFL.Player
select*
from NFL.Team
select *
from dbo.NFL_CONTRACTS_RAW
select * 
from NFL.TeamGame

SELECT *
FROM NFL.PlayerTeam;

-- Adding foreign keys and unique constraints

ALTER TABLE NFL.Player 
ADD CONSTRAINT FK_Player_Team FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT FK_Player_PlayerTeam FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID);

ALTER TABLE NFL.PlayerTeam 
ADD CONSTRAINT FK_PlayerTeam_Player FOREIGN KEY (PlayerID) REFERENCES NFL.Player(PlayerID),
    CONSTRAINT FK_PlayerTeam_Team FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT U1_PlayerTeam UNIQUE (ContractFirstYear, PlayerID),
    CONSTRAINT U2_PlayerTeam UNIQUE (PlayerTeamID, TeamID);

-- Check (works)
ALTER TABLE NFL.OffensiveStats 
ADD CONSTRAINT FK_OffensiveStats_PlayerTeam FOREIGN KEY (PlayerTeamID, TeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID, TeamID),
    CONSTRAINT FK_OffensiveStats_TeamGame FOREIGN KEY (TeamGameID) REFERENCES NFL.TeamGame(TeamGameID); -- had issues with trying to do TeamGameID, TeamID (trying this.)

ALTER TABLE NFL.TeamGame 
ADD CONSTRAINT FK_TeamGame_Game FOREIGN KEY (GameID) REFERENCES NFL.Game(GameID),
    CONSTRAINT FK_TeamGame_TeamType FOREIGN KEY (TeamTypeID) REFERENCES NFL.TeamType(TeamTypeID),
    CONSTRAINT FK_TeamGame_Team FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID),
    CONSTRAINT U1_TeamGame UNIQUE (GameID, TeamTypeID),
    CONSTRAINT U2_TeamGame UNIQUE (TeamGameID, TeamID),
    CONSTRAINT U3_TeamGame UNIQUE (GameID, TeamID);

ALTER TABLE NFL.Game 
ADD CONSTRAINT U1_Game UNIQUE ([Location], GameDate);

ALTER TABLE NFL.TeamType 
ADD CONSTRAINT U1_TeamType UNIQUE([Name]);

ALTER TABLE NFL.Team 
ADD CONSTRAINT FK_Team_Division FOREIGN KEY(DivisionID, ConferenceID) REFERENCES NFL.Division(DivisionID, ConferenceID),
    CONSTRAINT FK_Team_TeamGame FOREIGN KEY(TeamGameID) REFERENCES NFL.TeamGame(TeamGameID),
    CONSTRAINT U1_Team UNIQUE(DivisionID, DivisionSeeding),
    CONSTRAINT U2_Team UNIQUE(ConferenceID, ConferenceSeeding);

ALTER TABLE NFL.Division 
ADD CONSTRAINT FK_Division_Conference FOREIGN KEY(ConferenceID) REFERENCES NFL.Conference(ConferenceID),
    CONSTRAINT U1_Division UNIQUE(DivisionID, ConferenceID),
    CONSTRAINT U2_Division UNIQUE(DivisionName);

ALTER TABLE NFL.Conference 
ADD CONSTRAINT U1_Conference UNIQUE(ConferenceName);

