# NFL-Project

How to run this project:


1. Use PowerShell, CD to the project directory.

2.   .\RebuildDatabase (if this doesn't work, follow the instructions in the actual script document.)

3. The script that you ran involves building the database, creating the tables, and inserting the database. (in short, it essentially resets the database, any changes that you have made locally through the application WILL be lost.

4. Once you have ran the script, you can now run the Razor page through Visual Studios.


OTHER NOTES:

To find the all SQL code, it is located in NFL-Project\Data\SQL here you will find the Insertion, Tables (name as required by the project code submission), Queries, and StoredProcedures (all .SQL)

The aforementioned Queries (contains our aggregating queries and functional queries (needed to run the app and to display additional data)) and StoredProcedures (adding a team, adding a player, adding a conference, adding a division) are probably the most of interest for the grader.

You will also find a python script that utilizes bulk copy for our staging (RAW) tables. It essentially writes into the command for you, allowing an easy way to run our program.


Also included in the files is everything that we have used to gain our information or help build our project, .csv files, sql files, and fmt files. 


- Caleb, Barak, Daniel


