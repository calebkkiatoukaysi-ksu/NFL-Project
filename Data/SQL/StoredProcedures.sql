-- Stored Procedures for NFL Project

-- =====================================
-- Insert a New Player
-- =====================================
CREATE PROCEDURE NFL.InsertPlayer
    @FIRSTNAME NVARCHAR(50),
    @LASTNAME NVARCHAR(50),
    @HEIGHT INT,
    @WEIGHT INT,
    @MAINPOSITION NVARCHAR(10)
AS
BEGIN
    INSERT INTO NFL.Player (FirstName, LastName, Height, Weight, MainPosition)
    VALUES (@FIRSTNAME, @LASTNAME, @HEIGHT, @WEIGHT, @MAINPOSITION);
END;
GO

-- =====================================
-- Insert a New Team
-- =====================================
CREATE PROCEDURE NFL.InsertTeam
    @DIVISIONID INT,
    @CONFERENCEID INT,
    @CITY NVARCHAR(50),
    @STATE NVARCHAR(50),
    @NAME NVARCHAR(50),
    @STADIUMNAME NVARCHAR(50)
AS
BEGIN
    INSERT INTO NFL.Team (DivisionID, ConferenceID, City, State, Name, StadiumName)
    VALUES (@DIVISIONID, @CONFERENCEID, @CITY, @STATE, @NAME, @STADIUMNAME);
END;
GO

-- =====================================
-- Update Player Weight
-- =====================================
CREATE PROCEDURE NFL.UpdatePlayerWeight
    @FIRSTNAME NVARCHAR(50),
    @LASTNAME NVARCHAR(50),
    @NEWWEIGHT INT
AS
BEGIN
    UPDATE NFL.Player
    SET Weight = @NEWWEIGHT
    WHERE FirstName = @FIRSTNAME AND LastName = @LASTNAME;
END;
GO

-- =====================================
-- Update Offensive Stats (All Stats)
-- =====================================
CREATE PROCEDURE NFL.UpdateOffensiveStats
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
    UPDATE OS
    SET 
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
    FROM NFL.OffensiveStats OS
    JOIN NFL.PlayerTeam PT ON OS.PlayerTeamID = PT.PlayerTeamID
    JOIN NFL.Player P ON PT.PlayerID = P.PlayerID
    WHERE P.FirstName = @FIRSTNAME 
      AND P.LastName = @LASTNAME
      AND PT.TeamID = @TEAMID;
END;
GO




-- =====================================
-- Merge Insert/Update a Player
-- =====================================
CREATE PROCEDURE NFL.MergePlayer
    @FIRSTNAME NVARCHAR(50),
    @LASTNAME NVARCHAR(50),
    @HEIGHT INT,
    @WEIGHT INT,
    @MAINPOSITION NVARCHAR(10)
AS
BEGIN
    MERGE INTO NFL.Player AS Target
    USING (SELECT @FIRSTNAME AS FirstName, @LASTNAME AS LastName) AS Source
    ON Target.FirstName = Source.FirstName AND Target.LastName = Source.LastName
    WHEN MATCHED THEN
        UPDATE SET Height = @HEIGHT, Weight = @WEIGHT, MainPosition = @MAINPOSITION
    WHEN NOT MATCHED THEN
        INSERT (FirstName, LastName, Height, Weight, MainPosition)
        VALUES (@FIRSTNAME, @LASTNAME, @HEIGHT, @WEIGHT, @MAINPOSITION);
END;
GO
