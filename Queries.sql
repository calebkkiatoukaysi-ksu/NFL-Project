--This File will house all of the aggregating queries

CREATE VIEW NFL.Aggregation AS
SELECT 
    (P.FirstName + ' ' + P.LastName) AS PlayerName,
    SUM(OS.PassingYds) AS TotalPassingYards,
    SUM(OS.RushingYds) AS TotalRushingYards,
    SUM(OS.ReceivingYds) AS TotalReceivingYards,
    SUM(OS.PassingTDs + OS.RushingTDs + OS.ReceivingTDs) AS TotalTouchdowns,
    SUM(OS.Snaps) AS TotalSnaps
FROM NFL.Player P
JOIN NFL.PlayerTeam PT ON P.PlayerID = PT.PlayerID
JOIN NFL.OffensiveStats OS ON PT.PlayerTeamID = OS.PlayerTeamID
GROUP BY P.FirstName, P.LastName;


-- Merge for demo

MERGE INTO NFL.Player AS Target
USING (VALUES ('Joe', 'Burrow', 76, 220, 'QB')) 
      AS Source (FirstName, LastName, Height, Weight, MainPosition)
ON Target.FirstName = Source.FirstName AND Target.LastName = Source.LastName
WHEN MATCHED THEN
    UPDATE SET Height = Source.Height, Weight = Source.Weight, MainPosition = Source.MainPosition
WHEN NOT MATCHED THEN
    INSERT (FirstName, LastName, Height, Weight, MainPosition)
    VALUES (Source.FirstName, Source.LastName, Source.Height, Source.Weight, Source.MainPosition);
