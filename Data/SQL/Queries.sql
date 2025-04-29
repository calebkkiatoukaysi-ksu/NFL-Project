Create or Alter PROCEDURE NFL.GetPositionStats
@Position NVARCHAR(50)
AS
Select (p.FirstName + ' ' + p.LastName) AS Name, p.MainPosition, t.Name, (o.PassingTDs + o.ReceivingTDs + o.RushingTDs) AS TotalTDs, o.PassingTDs, o.ReceivingTDs, o.RushingTDs, o.PassingYDs, o.ReceivingYDs, o.RushingYDs, o.Receptions, o.Carries, o.RushingFUMs
From NFL.Player p
Inner Join NFL.PlayerTeam pt on p.PlayerId = pt.PlayerId
Inner Join NFL.Team t on pt.TeamId = t.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Where p.MainPosition = @Position
Order By Rank() Over
(Order by Case When @Position = N'WR' THEN o.ReceivingYDs When @Position = N'QB' THEN o.PassingYDs When @Position = N'RB' THEN o.RushingYDs ELSE (o.PassingTDs + o.ReceivingTDs + o.RushingTDs) END DESC)
GO

CREATE or Alter PROCEDURE NFL.GetTeamStats
AS
Select t.Name, SUM(o.PassingTDs + o.RushingTDs + o.ReceivingTDs) AS TotalTDs, SUM(o.PassingYDs + o.RushingYDs + o.ReceivingYDs) AS TotalYDs, SUM(o.PassingYDs) AS PassingYDS, SUM(o.ReceivingYDs) AS ReceivingYDS, SUM(o.RushingYDS) AS RushingYDS
From NFL.Team t
Inner Join NFL.PlayerTeam pt on t.TeamId = pt.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Group By t.Name
Order By TotalTDs DESC, TotalYDs DESC
GO

Create or Alter PROCEDURE NFL.GetFantasyPoints
AS
Select (p.FirstName + ' ' + p.LastName) AS Name, p.MainPosition, t.Name, (o.PassingTDs * 4 + o.PassingYDS * 0.04 + (o.RushingYDS + o.ReceivingYDS) *.1 +  o.Receptions + (o.RushingTDS + o.ReceivingTDS) * 6 + o.RushingFUMs * -2) AS FantasyPoints, Rank() Over(Partition by p.MainPosition Order by 
(o.PassingTDs * 4 + o.PassingYDS * 0.04 + (o.RushingYDS + o.ReceivingYDS) *.1 +  o.Receptions + (o.RushingTDS + o.ReceivingTDS) * 6 + o.RushingFUMs * -2) DESC) AS PositionRank
From NFL.Player p
Inner Join NFL.PlayerTeam pt on p.PlayerId = pt.PlayerId
Inner Join NFL.Team t on pt.TeamId = t.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Order By FantasyPoints DESC
GO

Create or Alter PROCEDURE NFL.GetHeightWeightStats
    @HeightMin INT,
    @HeightMax INT,
    @WeightMin INT,
    @WeightMax INT
AS
Select (p.FirstName + ' ' + p.LastName) AS Name, p.Height, p.Weight, p.MainPosition, t.Name, (o.PassingTDs + o.ReceivingTDs + o.RushingTDs) AS TotalTDs, o.PassingTDs, o.ReceivingTDs, o.RushingTDs, o.PassingYDs, o.ReceivingYDs, o.RushingYDs, o.Receptions, o.Carries, o.RushingFUMs
From NFL.Player p
Inner Join NFL.PlayerTeam pt on p.PlayerId = pt.PlayerId
Inner Join NFL.Team t on pt.TeamId = t.TeamId
Inner Join NFL.OffensiveStats o on pt.PlayerTeamId = o.PlayerTeamId
Where p.Height BETWEEN @HeightMin and @HeightMax and p.Weight BETWEEN @WeightMin and @WeightMax
Order By Rank() Over(Order by (o.PassingTDs + o.ReceivingTDs + o.RushingTDs) DESC,  (o.PassingYDs + o.RushingYDs + o.ReceivingYDs) DESC)
GO

Exec NFL.GetPositionStats
    @Position = N'QB'

EXEC NFL.GetTeamStats

EXEC NFL.GetFantasyPoints

Select p.Height
From NFL.Player p

EXEC NFL.GetHeightWeightStats
    @HeightMin = 72,
    @HeightMax = 88,
    @WeightMin = 200,
    @WeightMax = 220