/*
Okay! I don't know if you're reading this, but you should...

So, we need to populate our tables now. So I will tend to my tables.

~ Caleb 

bcp NFL_PROJECT.RAW.Seasonal_Stats format nul -f Seasonal_Stats.fmt -S "(localdb)\MSSQLLocalDb" -c -T
bcp NFL_PROJECT.RAW.Seasonal_Stats in "C:\Users\KONGM\source\repos\nfl-project-560\CSV\Seasonal_Stats.csv" -S "(localdb)\MSSQLLocalDb" -T -f Seasonal_Stats.fmt -h "CHECK_CONSTRAINTS"

bcp NFL_PROJECT.RAW.StagingRoster format nul -f StagingRoster.fmt -S "(localdb)\MSSQLLocalDb" -c -T
bcp NFL_PROJECT.RAW.StagingRoster in "C:\Users\KONGM\source\repos\nfl-project-560\CSV\Roster.csv" -S "(localdb)\MSSQLLocalDb" -T -f StagingRoster.fmt -h "CHECK_CONSTRAINTS"

*/

/*
-- Start with the RAW (Staging) tables. 
BULK INSERT RAW.Seasonal_Stats
FROM 'CSV\\Seasonal_Stats.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, -- Skip header
    FIELDTERMINATOR = ',', -- Adjust if delimiter is different
    ROWTERMINATOR = '\n',
    TABLOCK
);
BULK INSERT RAW.StagingRoster
FROM 'CSV\\Roster.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, -- Skip header row if needed
    FIELDTERMINATOR = ',', -- Adjust based on CSV delimiter
    ROWTERMINATOR = '\n',
    TABLOCK
);
*/

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
FROM RAW.StagingRoster r
INNER JOIN NFL.Team t ON t.Name = r.team

-- Populate PlayerTeam table 
INSERT INTO NFL.PlayerTeam (PlayerID, TeamID)
SELECT DISTINCT p.PlayerID, t.TeamID
FROM RAW.StagingRoster r
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
ALTER TABLE RAW.Seasonal_Stats
ADD PlayerID INT; 

UPDATE ss
SET ss.PlayerID = P.PlayerID
FROM RAW.Seasonal_Stats ss
INNER JOIN NFL.Player P 
  ON P.FirstName = ss.player_first_name
 AND P.LastName = ss.player_last_name

-- some first names are not matching so match via last names for those who are null.
UPDATE ss
SET ss.PlayerID = P.PlayerID
FROM RAW.Seasonal_Stats AS ss
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
FROM RAW.Seasonal_Stats ss
INNER JOIN NFL.PlayerTeam pt ON pt.PlayerID = ss.PlayerID;

-- Now define the constraints

-- NFL.Player table
ALTER TABLE NFL.Player
DROP COLUMN TeamID -- Drop team id as we do not need it.

ALTER TABLE NFL.OffensiveStats
DROP COLUMN TeamID -- drop team id as we do not need it.
