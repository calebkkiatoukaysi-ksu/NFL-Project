--FIRST TRY SHOULD BE MOVED TO PROCEDURES IF DESIRED FOR FUNCTIONALITY

CREATE OR ALTER PROCEDURE NFL.GetNFCTeams
AS
    SELECT 
        ConferenceSeeding, 
        IsConferenceChamp, 
        City, 
        [State], 
        [Name], 
        StadiumName
    FROM NFL.Team
    WHERE ConferenceID = 1
    ORDER BY 
        ConferenceID ASC, 
        IsConferenceChamp DESC, 
        ConferenceSeeding ASC;
GO

CREATE OR ALTER PROCEDURE NFL.GetAFCTeams
AS
    SELECT 
        ConferenceSeeding, 
        IsConferenceChamp, 
        City, 
        [State], 
        [Name], 
        StadiumName
    FROM NFL.Team
    WHERE ConferenceID = 2
    ORDER BY 
        ConferenceID ASC, 
        IsConferenceChamp DESC, 
        ConferenceSeeding ASC;
GO


-- Default Query
CREATE OR ALTER PROCEDURE NFL.GetPositionStats
    @Position NVARCHAR(50)
AS
BEGIN
    SELECT 
        (p.FirstName + ' ' + p.LastName) AS PlayerName,
        p.MainPosition,
        t.Name AS TeamName,
        o.PassingYDs,
        o.PassingTDs,
        o.PassingINTs,
        o.Carries,
        o.RushingYDs,
        o.RushingTDs,
        o.RushingFUMs,
        o.Receptions,
        o.ReceivingYDs,
        o.ReceivingTDs,
        RANK() OVER (
            ORDER BY 
                CASE 
                    WHEN @Position = N'WR' THEN o.ReceivingYDs
                    WHEN @Position = N'QB' THEN o.PassingYDs
                    WHEN @Position = N'RB' THEN o.RushingYDs
                    WHEN @Position = N'TE' THEN o.ReceivingYDs
                    ELSE (o.PassingTDs + o.ReceivingTDs + o.RushingTDs)
                END DESC
        ) AS PlayerRank
    FROM NFL.Player p
    INNER JOIN NFL.PlayerTeam pt ON p.PlayerId = pt.PlayerId
    INNER JOIN NFL.Team t ON pt.TeamId = t.TeamId
    INNER JOIN NFL.OffensiveStats o ON pt.PlayerTeamId = o.PlayerTeamId
    WHERE 
        (@Position IN (N'QB', N'RB', N'WR', N'TE') AND p.MainPosition = @Position)
        OR (@Position = N'Other' AND p.MainPosition NOT IN (N'QB', N'RB', N'WR', N'TE'));
END
GO


--Actual Aggregating Queries

CREATE or Alter PROCEDURE NFL.GetTeamStats
AS
Select t.Name, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs) AS PassingYDs, SUM(o.ReceivingYDs) AS ReceivingYDs, SUM(o.RushingYDS) AS RushingYDs
From NFL.Team t
Inner Join NFL.PlayerTeam pt on t.TeamId = pt.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Group By t.Name
Order By TotalTDs DESC, TotalYDs DESC
GO

CREATE or Alter PROCEDURE NFL.GetDivisionStats
AS
Select d.DivisionName, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs) AS PassingYDS, SUM(o.ReceivingYDs) AS ReceivingYDS, SUM(o.RushingYDS) AS RushingYDS
From NFL.Team t
Inner Join NFL.PlayerTeam pt on t.TeamId = pt.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Inner Join NFL.Division d on t.DivisionId = d.DivisionId
Group By d.DivisionName
Order By TotalTDs DESC, TotalYDs DESC
GO

CREATE or Alter PROCEDURE NFL.GetConferenceStats
AS
Select c.ConferenceName, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs) AS PassingYDs, SUM(o.ReceivingYDs) AS ReceivingYDs, SUM(o.RushingYDS) AS RushingYDs
From NFL.Team t
Inner Join NFL.PlayerTeam pt on t.TeamId = pt.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Inner Join NFL.Conference c on t.ConferenceID = c.ConferenceID
Group By c.ConferenceName
Order By TotalTDs DESC, TotalYDs DESC
GO

Create or Alter PROCEDURE NFL.GetHeightStats
AS
Select p.Height, COUNT(p.PlayerId) AS PlayerCount, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs)/ COUNT(p.PlayerId)AS AverageTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs)/ COUNT(p.PlayerId) AS AverageYDs, SUM(o.PassingYDs) AS PassingYDs, SUM(o.ReceivingYDs) AS ReceivingYDs, SUM(o.RushingYDS) AS RushingYDs
From NFL.Player p
Inner Join NFL.PlayerTeam pt on p.PlayerId = pt.PlayerId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Group By p.Height
Order By PlayerCount DESC, AverageYDs DESC
GO

Create or Alter PROCEDURE NFL.GetWeightStats
AS
Select p.Weight, COUNT(p.PlayerId) AS PlayerCount, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs)/ COUNT(p.PlayerId)AS AverageTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs)/ COUNT(p.PlayerId) AS AverageYDs, SUM(o.PassingYDs) AS PassingYDS, SUM(o.ReceivingYDs) AS ReceivingYDS, SUM(o.RushingYDS) AS RushingYDS
From NFL.Player p
Inner Join NFL.PlayerTeam pt on p.PlayerId = pt.PlayerId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Group By p.Weight
Order By PlayerCount DESC, AverageYDs DESC
GO

--Gets the fantasy points of a given player
CREATE OR ALTER PROCEDURE NFL.GetFantasyPoints
AS
    SELECT 
        p.FirstName,
        p.LastName,
        p.MainPosition,
        SUM(
            (o.PassingTDs * 4.0) +
            (o.RushingTDs * 6.0) +
            (o.ReceivingTDs * 6.0) +
            (o.PassingYDs * 0.04) +
            ((o.RushingYDs + o.ReceivingYDs) / 10.0) +
            (o.Receptions * 1.0) -
            (o.PassingINTs * 2.0) -
            (o.RushingFUMs * 2.0)
        ) AS TotalFantasyPoints,
        RANK() Over(PARTITION BY p.MainPosition Order By SUM(
            (o.PassingTDs * 4.0) +
            (o.RushingTDs * 6.0) +
            (o.ReceivingTDs * 6.0) +
            (o.PassingYDs * 0.04) +
            ((o.RushingYDs + o.ReceivingYDs) / 10.0) +
            (o.Receptions * 1.0) -
            (o.PassingINTs * 2.0) -
            (o.RushingFUMs * 2.0)
        )) AS PositionRank
    FROM NFL.Player p
    INNER JOIN NFL.PlayerTeam pt ON p.PlayerId = pt.PlayerId
    INNER JOIN NFL.OffensiveStats o ON pt.PlayerTeamId = o.PlayerTeamId
    GROUP BY p.FirstName, p.LastName, p.MainPosition
    ORDER BY TotalFantasyPoints DESC
GO


-- Execution for Default Query
Exec NFL.GetPositionStats
    @Position = N'QB'

EXEC NFL.GetNFCTeams

EXEC NFL.GetAFCTeams

---EXECUTIONS FOR AGGREGATING QUERIES
EXEC NFL.GetTeamStats

EXEC NFL.GetDivisionStats

EXEC NFL.GetConferenceStats

EXEC NFL.GetHeightStats

EXEC NFL.GetWeightStats

EXEC NFL.GetFantasyPoints