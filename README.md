# NFL-Project

NFL Project for CIS 560
NFL Stat Project Proposal

Barak, Caleb, Daniel
Project Summary
Football is a sport driven by statistics, with every play generating new data points. Our passion for football and software development has inspired us to create an NFL Stats Application—a tool that leverages a custom SQL database and our expertise in programming languages and frameworks to bring NFL statistics to life.
For the user interface (UI), we will utilize the WPF framework within Visual Studio, ensuring a user-friendly and visually appealing design. This will be developed using XAML and C#, enabling dynamic interactions and intuitive navigation for users to explore various NFL stats.


Technical Details
Tech Stack
Front End: WPF (C# / .NET Framework)


Back End: SQL Server


SQL IDE: Azure Data Studio (or any compatible SQL Server IDE)


Logical Database Model


Data Operations
Query Functionality
Our application will support a range of SQL operations. All tables will support SELECT, UPDATE, and INSERT ASIDE from TeamType table which is static (SELECT)


Aggregating Queries

Our system will utilize SQL aggregate functions to generate key insights, such as:

------------------------
[PersonStats](Defense or Offense)
Description: Show the offensive or defensive stats for a given player for a given time frame
Parameters
FirstDate: The first date of the desired date range to include in the analysis.
LastDate: The last date of the desired date range to include in the analysis.
StatType: Whether to query defensive stats or offensive stats
Person: The personId for the person who’s stats you’re looking at
Result Columns
FirstName
LastName
PassingYds(or Sacks)
RushingYds(or Interceptions)
RushingAttempts(or Fumble Recoveries)
ReceivingYds(or Blocks)
Receptions(Offense only)
Tds
Snaps
------------------------
[PositionStats](Defense or Offense)
Description: Show the offensive or defensive stats for a given position for a given time frame
Parameters
FirstDate: The first date of the desired date range to include in the analysis.
LastDate: The last date of the desired date range to include in the analysis.
StatType: Whether to query defensive stats or offensive stats
Position: The main position to get stats for
Result Columns
FirstName
LastName
PassingYds(or Sacks)
RushingYds(or Interceptions)
RushingAttempts(or Fumble Recoveries)
ReceivingYds(or Blocks)
Receptions(Offense only)
Tds
Snaps
--------------------------
[TeamStats](Defense or Offense)
Description: Show the offensive or defensive stats for a team for a given time frame
Parameters
FirstDate: The first date of the desired date range to include in the analysis.
LastDate: The last date of the desired date range to include in the analysis.
StatType: Whether to query defensive stats or offensive stats
Team: The team to get all offensive or defensive stats for
Result Columns
FirstName
LastName
MainPosition
PassingYds(or Sacks)
RushingYds(or Interceptions)
RushingAttempts(or Fumble Recoveries)
ReceivingYds(or Blocks)
Receptions(Offense only)
Tds
Snaps
--------------------------
[StartYearStats](Defense or Offense)
Description: Show the offensive or defensive stats for a given start year for a given time frame
Parameters
FirstDate: The first date of the desired date range to include in the analysis.
LastDate: The last date of the desired date range to include in the analysis.
StatType: Whether to query defensive stats or offensive stats
StartingYear: The starting year(Draft or signed year) of players to get stats for
Result Columns
FirstName
LastName
Position
PassingYds(or Sacks)
RushingYds(or Interceptions)
RushingAttempts(or Fumble Recoveries)
ReceivingYds(or Blocks)
Receptions(Offense only)
Tds
Snaps

[Conclusion]:
With this project, we aim to create an engaging and interactive NFL stats application that combines our love for football with our technical expertise. By using WPF for the front end and SQL Server for the backend, we will build a robust and scalable system that allows users to explore NFL statistics in an insightful and meaningful way, while also displaying what we have learned throughout this semester and overall, our time as a Computer Science Major. 


