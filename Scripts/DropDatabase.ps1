[CmdletBinding()]
Param(
    [string] $Server   = "(localdb)\MSSQLLocalDB",
    [string] $Database = (Throw 'You must specify -Database')
)

# Determine script directory
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "Dropping database '$Database' on server '$Server'..."

# Build the DROP DATABASE SQL, checking existence first
$Sql = @"
IF EXISTS (
    SELECT 1 FROM sys.databases WHERE name = N'$Database'
)
BEGIN
    ALTER DATABASE [$Database]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE [$Database];
END;
"@

# Execute against master database
Invoke-Sqlcmd \
    -ServerInstance $Server \
    -Database master \
    -Query $Sql \
    -ErrorAction Stop

Write-Host "Database '$Database' dropped (if it existed)."
