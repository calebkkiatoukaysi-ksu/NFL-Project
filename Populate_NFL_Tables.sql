-- this file is to populate the tables.

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

-- NFC West (best div)
(4, 1, 1, 4, N'False', N'Los Angeles', N'CA', N'Rams', N'SoFi Stadium'),
(4, 1, 2, 8, N'False', N'Seattle', N'WA', N'Seahawks', N'Lumen Field'),
(4, 1, 3, 10, N'False', N'Arizona', N'AZ', N'Cardinals', N'State Farm Stadium'),
(4, 1, 4, 12, N'False', N'San Francisco', N'CA', N'49ers', N'Levi’s Stadium'),

-- AFC North
(5, 2, 1, 3, N'False', N'Baltimore', N'MD', N'Ravens', N'M&T Bank Stadium'),
(5, 2, 2, 6, N'False', N'Pittsburgh', N'PA', N'Steelers', N'Acrisure Stadium'),
(5, 2, 3, 8, N'False', N'Cincinnati', N'OH', N'Bengals', N'Paycor Stadium'),
(5, 2, 4, 15, N'False', N'Cleveland', N'OH', N'Browns', N'Huntington Bank Field'),

-- AFC East
(6, 2, 1, 2, N'False', N'Buffalo', N'NY', N'Bills', N'Highmark Stadium'),
(6, 2, 2, 10, N'False', N'Miami', N'FL', N'Dolphins', N'Hard Rock Stadium'),
(6, 2, 3, 11, N'False', N'New York', N'NY', N'Jets', N'MetLife Stadium'),
(6, 2, 4, 13, N'False', N'New England', N'MA', N'Patriots', N'Gillette Stadium'),

-- AFC South (the worst division LOL)
(7, 2, 3, 4, N'False', N'Houston', N'TX', N'Texans', N'NRG Stadium'),
(7, 2, 4, 9, N'False', N'Indianapolis', N'IN', N'Colts', N'Lucas Oil Stadium'),
(7, 2, 1, 12, N'False', N'Jacksonville', N'FL', N'Jaguars', N'EverBank Stadium'),
(7, 2, 2, 16, N'False', N'Tennessee', N'TN', N'Titans', N'Nissan Stadium'),

-- AFC West (1, 5, 7, 14 is crazy. Best division in football)
(8, 2, 1, 1, N'True', N'Kansas City', N'MO', N'Chiefs', N'Arrowhead Stadium'),
(8, 2, 2, 5, N'False', N'Los Angeles', N'CA', N'Chargers', N'SoFi Stadium'),
(8, 2, 3, 7, N'False', N'Denver', N'CO', N'Broncos', N'Empower Field at Mile High'),
(8, 2, 4, 14, N'False', N'Las Vegas', N'NV', N'Raiders', N'Allegiant Stadium');

-- Populate NFL.Player table
ALTER TABLE NFL.Player
ALTER COLUMN PlayerTeamID INT NULL; -- will have to reset back to NOT NULL

INSERT INTO NFL.Player(TeamID, FirstName, LastName, Height, [Weight], MainPosition)
SELECT t.TeamID, r.first_name, r.last_name, r.height, r.[weight], r.[position]
FROM dbo.StagingRoster r
INNER JOIN NFL.Team t ON t.Name = r.team

-- Populate PlayerTeam table 
INSERT INTO NFL.PlayerTeam (PlayerID, TeamID)
SELECT DISTINCT p.PlayerID, t.TeamID
FROM dbo.StagingRoster r
INNER JOIN NFL.Team t ON t.Name = r.team
INNER JOIN NFL.Player p ON p.TeamID = t.TeamID;

-- Populate NFL.Player PlayerTeamID
UPDATE P
SET P.PlayerTeamID = PT.PlayerTeamID
FROM NFL.Player P
INNER JOIN NFL.PlayerTeam PT ON P.PlayerID = PT.PlayerID
WHERE P.PlayerTeamID IS NULL;

/*
-- Uh oh, our raw table doesn't have a player id
-- caleb to the rescue
ALTER TABLE dbo.Seasonal_Stats
ADD PlayerID INT; 

UPDATE ss
SET ss.PlayerID = P.PlayerID
FROM dbo.Seasonal_Stats ss
INNER JOIN NFL.Player P 
  ON P.FirstName = ss.player_first_name
 AND P.LastName = ss.player_last_name

-- some first names are not matching so match via last names for those who are null.
UPDATE ss
SET ss.PlayerID = P.PlayerID
FROM dbo.Seasonal_Stats AS ss
JOIN NFL.Player AS P
  ON P.LastName = ss.player_last_name
 AND P.MainPosition = ss.position  -- Ensuring the position matches
WHERE ss.PlayerID IS NULL;

-- manually input edgecases :) (Big one, Amon-Ra St. Brown, if you cant seem to find a player, search their name up, it'll give their government name. (ie. Matthew Stafford is actually John Stafford LOL))
Caleb fixed this, dont worry pookie
*/  


INSERT INTO NFL.OffensiveStats (PlayerTeamID, TeamID, PassingYds, PassingTDs, PassingINTs, Carries, RushingYDs, RushingTDs, RushingFUMs, Receptions, ReceivingYDs, ReceivingTDs)
SELECT 
    pt.PlayerTeamID,
    pt.TeamID,
    ss.passing_yards,
    ss.passing_td,
    ss.interceptions,
    ss.carries,
    ss.rushing_yards,
    ss.rushing_tds,
    ss.rushing_fumbles,
    ss.receptions,
    ss.receiving_yards,
    ss.receiving_tds
FROM dbo.Seasonal_Stats ss
INNER JOIN NFL.PlayerTeam pt ON pt.PlayerID = ss.PlayerID;

-- Now define the constraints

-- NFL.Player table
ALTER TABLE NFL.Player
DROP COLUMN TeamID -- Drop team id as we do not need it.

ALTER TABLE NFL.OffensiveStats
DROP COLUMN TeamID -- drop team id as we do not need it.

ALTER TABLE NFL.Player
ADD CONSTRAINT FK_Player FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID);

-- NFL.PlayerTeam 

ALTER TABLE NFL.PlayerTeam
ADD CONSTRAINT FK1_PlayerTeam FOREIGN KEY (PlayerID) REFERENCES NFL.Player(PlayerID)

ALTER TABLE NFL.PlayerTeam
ADD CONSTRAINT FK2_PlayerTeam  FOREIGN KEY (TeamID) REFERENCES NFL.Team(TeamID)




-- Offensive Stats
ALTER TABLE NFL.OffensiveStats
ADD CONSTRAINT FK1_OffensiveStats FOREIGN KEY (PlayerTeamID) REFERENCES NFL.PlayerTeam(PlayerTeamID)

-- Conference
ALTER TABLE NFL.Conference 
ADD CONSTRAINT U_Conference UNIQUE (ConferenceName)

-- Division
ALTER TABLE NFL.Division
ADD CONSTRAINT U1_Division UNIQUE(DivisionName)

ALTER TABLE NFL.Division
ADD CONSTRAINT FK1_Division FOREIGN KEY (ConferenceID) REFERENCES NFL.Conference(ConferenceID)



-- NFL.Team 
ALTER TABLE NFL.Team
ADD CONSTRAINT U1_Team UNIQUE (DivisionID, DivisionSeeding)

ALTER TABLE NFL.Team
ADD CONSTRAINT U2_Team UNIQUE(ConferenceID, ConferenceSeeding)

ALTER TABLE NFL.Team
ADD CONSTRAINT FK1_Team FOREIGN KEY (DivisionID) REFERENCES NFL.Division(DivisionID)

SELECT P.FirstName, P.LastName, T.Name AS TeamName, OS.RushingYds, OS.RushingTDs, OS.Carries
FROM NFL.Team T
JOIN NFL.PlayerTeam PT ON PT.TeamID = T.TeamID
JOIN NFL.Player P ON P.PlayerID = PT.PlayerID
JOIN NFL.OffensiveStats OS ON PT.PlayerTeamID = OS.PlayerTeamID
WHERE P.FirstName = 'Ezekiel'
ORDER BY OS.RushingYds DESC;

