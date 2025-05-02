Param(
   [string] $Server = "(localdb)\MSSQLLocalDb",
   [string] $Database = "NFL_PROJECT"
)

# This script requires the SQL Server module for PowerShell.
# The below commands may be required.

# To check whether the module is installed.
# Get-Module -ListAvailable -Name SqlServer;

# Install the SQL Server Module
# Install-Module -Name SqlServer -Scope CurrentUser

$CurrentDrive = (Get-Location).Drive.Name + ":"
Set-Location $CurrentDrive

Write-Host ""
Write-Host "Rebuilding database $Database on $Server..."

<#
   If on your local machine, you can drop and re-create the database.
#>
& ".\Scripts\DropDatabase.ps1" -Database $Database
& ".\Scripts\CreateDatabase.ps1" -Database $Database

Write-Host "Creating schema..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\Schemas\Schema.sql"

Write-Host "Creating tables..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Tables.sql"


Write-Host "Stored procedures..."
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile ".\Data\SQL\Queries.sql"
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile ".\Data\SQL\StoredProcedures.sql"


Write-Host "Inserting data..."
python Data\InsertBCPRAW.py
Invoke-SqlCmd -ServerInstance $Server -Database $Database -InputFile "Data\SQL\Insertion.sql"

Write-Host "Rebuild completed."
Write-Host ""
