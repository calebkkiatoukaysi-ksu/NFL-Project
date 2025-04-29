/*
HEY! I will be making a PowerShell Script to create the database to run our program! So that means
DANIEL and BARAK: please please please please finish the queries, with that, i can script them with the database set up :)


For now, this is temporary... and will work.
*/



/*
HEY! This is Caleb speaking...

We are going to handcraft our RAW Tables (staging) so that the script can also create it for the grader's sanity. 

NO EXTENSIONS NEEDED :))
*/
CREATE TABLE RAW.Seasonal_Stats(
    player_id NVARCHAR(50) NOT NULL PRIMARY KEY, -- temporary PK
    player_first_name NVARCHAR(50) NULL,
    player_last_name NVARCHAR(50) NULL,
    position NVARCHAR(50) NULL,
    passing_yards INT NOT NULL,
    passing_td INT NOT NULL,
    interceptions INT NOT NULL,
    carries INT NOT NULL,
    rushing_yards INT NOT NULL,
    rushing_tds INT NOT NULL,
    rushing_fumbles INT NOT NULL,
    receptions INT NOT NULL,
    receiving_yards INT NOT NULL,
    receiving_tds INT NOT NULL,
    PlayerID INT NULL, -- Real PlayerID
)

CREATE TABLE RAW.StagingRoster(
    team NVARCHAR(50) NOT NULL,
    position NVARCHAR(50) NOT NULL,
    depth_chart_position NVARCHAR(50) NOT NULL,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    height INT NULL,
    [weight] INT NULL
)
--------------------------------------------------------------------------------

--Create Tables (Will alter them to have their constraints later)--
CREATE TABLE NFL.Player (
    PlayerID INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
    TeamID INT,
    PlayerTeamID INT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Height INT NULL, -- Note: Height will be displayed as 6' 3 " (Some players dont have height listed)
    [Weight] INT NOT NULL,
    MainPosition NVARCHAR(50)
);


-- create player team --
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


--------------Alter Tables for Constraints----------------
--Altering NFL.Player--
ALTER TABLE NFL.Player
ADD CONSTRAINT FK_Player FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID);


--Altering NFL.PlayerTeam--
ALTER TABLE NFL.PlayerTeam
ADD CONSTRAINT FK1_PlayerTeam FOREIGN KEY (PlayerID) REFERENCES NFL.Player(PlayerID)

ALTER TABLE NFL.PlayerTeam
ADD CONSTRAINT FK2_PlayerTeam  FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID)


--Altering NFL.OffensiveStats--
ALTER TABLE NFL.OffensiveStats
ADD CONSTRAINT FK1_OffensiveStats FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID)


--Altering NFL.Team--
ALTER TABLE NFL.Team
ADD CONSTRAINT U1_Team UNIQUE (DivisionID, DivisionSeeding)

ALTER TABLE NFL.Team
ADD CONSTRAINT U2_Team UNIQUE(ConferenceID, ConferenceSeeding)

ALTER TABLE NFL.Team
ADD CONSTRAINT FK1_Team FOREIGN KEY (DivisionID) REFERENCES NFL.Division(DivisionID)


--Altering NFL.Division--
ALTER TABLE NFL.Division
ADD CONSTRAINT U1_Division UNIQUE(DivisionName)

ALTER TABLE NFL.Division
ADD CONSTRAINT FK1_Division FOREIGN KEY (ConferenceID) REFERENCES NFL.Conference(ConferenceID)


--Altering NFL.Conference--
ALTER TABLE NFL.Conference 
ADD CONSTRAINT U_Conference UNIQUE (ConferenceName)
