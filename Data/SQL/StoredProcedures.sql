-- Stored Procedures for NFL Project

-- =====================================
-- Insert a New Player
-- =====================================

CREATE OR ALTER PROCEDURE NFL.InsertPlayer
    @FIRSTNAME NVARCHAR(50),
    @LASTNAME NVARCHAR(50),
    @HEIGHT INT,
    @WEIGHT INT,
    @MAINPOSITION NVARCHAR(10),
    @TEAMID INT,
    @PLAYERID INT OUTPUT
AS
BEGIN
    -- insert into Player table
    INSERT INTO NFL.Player (FirstName, LastName, Height, Weight, MainPosition)
    VALUES (@FIRSTNAME, @LASTNAME, @HEIGHT, @WEIGHT, @MAINPOSITION);

    -- get the new PlayerID
    SET @PLAYERID = SCOPE_IDENTITY();

    -- assign the player to the given team
    INSERT INTO NFL.PlayerTeam (PlayerID, TeamID)
    VALUES (@PLAYERID, @TEAMID);
END;
GO


-- =====================================
-- Insert a New Team
-- =====================================

-- Same idea
CREATE PROCEDURE NFL.InsertTeam
    @DIVISIONID INT,
    @CONFERENCEID INT,
    @CITY NVARCHAR(50),
    @STATE NVARCHAR(50),
    @NAME NVARCHAR(50),
    @STADIUMNAME NVARCHAR(50),
    @TEAMID INT OUTPUT
AS
BEGIN
    INSERT INTO NFL.Team (DivisionID, ConferenceID, City, State, Name, StadiumName)
    VALUES (@DIVISIONID, @CONFERENCEID, @CITY, @STATE, @NAME, @STADIUMNAME);

    SET @TEAMID = SCOPE_IDENTITY();
END;
GO



-- =====================================
-- Update/Merge Offensive Stats (All Stats)
-- =====================================
CREATE OR ALTER PROCEDURE NFL.UpsertOffensiveStats
    @FIRSTNAME NVARCHAR(50),
    @LASTNAME NVARCHAR(50),
    @TEAMID INT,
    @PASSINGYDS INT = 0,
    @PASSINGTDS INT = 0,
    @RECEIVINGYDS INT = 0,
    @RECEIVINGTDS INT = 0,
    @RUSHINGYDS INT = 0,
    @RUSHINGTDS INT = 0,
    @RECEPTIONS INT = 0,
    @CARRIES INT = 0,
    @RUSHINGFUMS INT = 0,
    @PASSINGINTS INT = 0
AS
BEGIN

    DECLARE @PlayerID INT;
    DECLARE @PlayerTeamID INT;

    -- added so created player can update stats as well
    SELECT @PlayerID = PlayerID
    FROM NFL.Player
    WHERE FirstName = @FIRSTNAME AND LastName = @LASTNAME;
    -- get or create PlayerTeamID
    SELECT @PlayerTeamID = PlayerTeamID
    FROM NFL.PlayerTeam
    WHERE PlayerID = @PlayerID AND TeamID = @TEAMID;

    IF @PlayerTeamID IS NULL
    BEGIN
        INSERT INTO NFL.PlayerTeam (PlayerID, TeamID)
        VALUES (@PlayerID, @TEAMID);

        SET @PlayerTeamID = SCOPE_IDENTITY();
    END

    -- Upsert offensive stats (is that whtat they call it? LOL)
    MERGE NFL.OffensiveStats AS OS
    USING (SELECT @PlayerTeamID AS PlayerTeamID) AS S
    ON OS.PlayerTeamID = S.PlayerTeamID
    WHEN MATCHED THEN
        UPDATE SET
            PassingYds   = OS.PassingYds + @PASSINGYDS,
            PassingTDs   = OS.PassingTDs + @PASSINGTDS,
            ReceivingYds = OS.ReceivingYds + @RECEIVINGYDS,
            ReceivingTDs = OS.ReceivingTDs + @RECEIVINGTDS,
            RushingYds   = OS.RushingYds + @RUSHINGYDS,
            RushingTDs   = OS.RushingTDs + @RUSHINGTDS,
            Receptions   = OS.Receptions + @RECEPTIONS,
            Carries      = OS.Carries + @CARRIES,
            RushingFUMs  = OS.RushingFUMs + @RUSHINGFUMS,
            PassingINTs  = OS.PassingINTs + @PASSINGINTS
    WHEN NOT MATCHED THEN
        INSERT (PlayerTeamID, PassingYds, PassingTDs, ReceivingYds, ReceivingTDs,
                RushingYds, RushingTDs, Receptions, Carries, RushingFUMs, PassingINTs)
        VALUES (@PlayerTeamID, @PASSINGYDS, @PASSINGTDS, @RECEIVINGYDS, @RECEIVINGTDS,
                @RUSHINGYDS, @RUSHINGTDS, @RECEPTIONS, @CARRIES, @RUSHINGFUMS, @PASSINGINTS);
END;
GO -- tl:dr the first Update/Merge didnt account for created players, so this method utilized multiple select statements to make that happen. (took about 30 ish minutes?)


-- =====================================
-- Insert a New Conference
-- =====================================
CREATE OR ALTER PROCEDURE NFL.InsertConference
    @CONFERENCENAME NVARCHAR(50),
    @CONFERENCEID INT OUTPUT
AS
BEGIN
    INSERT INTO NFL.Conference (ConferenceName)
    VALUES (@CONFERENCENAME);

    SET @CONFERENCEID = SCOPE_IDENTITY(); 
END;
GO -- straight forward


-- =====================================
-- Insert a New Division
-- =====================================
CREATE OR ALTER PROCEDURE NFL.InsertDivision
    @DIVISIONNAME NVARCHAR(50),
    @CONFERENCEID INT,
    @DIVISIONID INT OUTPUT
AS
BEGIN
    INSERT INTO NFL.Division (DivisionName, ConferenceID)
    VALUES (@DIVISIONNAME, @CONFERENCEID);

    SET @DIVISIONID = SCOPE_IDENTITY();
END;
GO --  straight forward
