IF NOT EXISTS
   (
      SELECT *
      FROM sys.schemas s
      WHERE s.[name] = N'NFL'
   )
BEGIN
   EXEC(N'CREATE SCHEMA [NFL] AUTHORIZATION [dbo]');
END;

IF NOT EXISTS
   (
      SELECT * FROM sys.schemas s 
      WHERE s.[name] = N'RAW'
   )
BEGIN
   EXEC(N'CREATE SCHEMA [RAW] AUTHORIZATION [dbo]');
END;

