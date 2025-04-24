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

