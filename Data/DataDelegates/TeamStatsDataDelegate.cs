using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class TeamStatsDataDelegate() : DataReaderDelegate<IReadOnlyList<TeamStats>>("NFL.GetTeamStats")
    {
        public override IReadOnlyList<TeamStats> Translate(Command command, IDataRowReader reader)
        {
            var teamStats = new List<TeamStats>();

            while (reader.Read())
            {
                teamStats.Add(new TeamStats(
                    reader.GetString("Name"),
                    reader.GetInt32("TotalTDs"),
                    reader.GetInt32("TotalYDs"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("ReceivingYDs"),
                    reader.GetInt32("RushingYDs")));
            }

            return teamStats;
        }
    }
}
