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




Exec NFL.GetPositionStats
    @Position = N'WR'

EXEC NFL.GetTeamStats
