CREATE DATABASE NFL_PROJECT_REVISED;

USE NFL_PROJECT_REVISED

IF SCHEMA_ID(N'NFL') IS NULL 
    EXEC(N'Create SCHEMA NFL');
GO

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

-- create player team
CREATE TABLE NFL.PlayerTeam (
    PlayerTeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    PlayerID INT NOT NULL,
    TeamID INT NOT NULL
);

-- create Offensive Stats
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

-- create team table
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

-- create division
CREATE TABLE NFL.Division (
    DivisionID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ConferenceID INT NOT NULL,
    DivisionName NVARCHAR(50) NOT NULL
);

-- create conference
CREATE TABLE NFL.Conference (
    ConferenceID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    ConferenceName NVARCHAR(50) NOT NULL
);

