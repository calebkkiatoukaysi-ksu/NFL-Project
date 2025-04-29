import os

# Insert Data into the RAW.Seasonal_Stats table
seasonal_stats_file_path = 'Data\CSV\Seasonal_Stats.csv'

insert_seasonal_stats = f'bcp NFL_PROJECT.RAW.Seasonal_Stats in "{seasonal_stats_file_path}" -S "(localdb)\MSSQLLocalDb" -T -f Data\FMT\Seasonal_Stats.fmt'

try:
    os.system(insert_seasonal_stats)
except Exception as e:
    print(e)


# Insert Data into the Raw.StagingRoster
roster_file_path = 'Data\CSV\Roster.csv'
insert_roster = f'bcp NFL_PROJECT.RAW.StagingRoster in "{roster_file_path}" -S "(localdb)\MSSQLLocalDb" -T -f Data\FMT\StagingRoster.fmt'

try:
    os.system(insert_roster)
except Exception as e:
    print(e)

