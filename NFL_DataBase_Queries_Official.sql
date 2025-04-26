--This File will house all of the aggregating queries

Create View NFL.Aggregation
AS
Select (p.FirstName +" " + p.LastName) as PlayerName
From NFL.Player p
