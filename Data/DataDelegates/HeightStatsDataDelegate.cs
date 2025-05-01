using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class HeightStatsDataDelegate() : DataReaderDelegate<IReadOnlyList<HeightStats>>("NFL.GetHeightStats")
    {
        public override IReadOnlyList<HeightStats> Translate(Command command, IDataRowReader reader)
        {
            var heightStats = new List<HeightStats>();

            while (reader.Read())
            {
                heightStats.Add(new HeightStats(
                    reader.GetInt32("Height"),
                    reader.GetInt32("PlayerCount"),
                    reader.GetInt32("TotalTDs"),
                    reader.GetInt32("AverageTDs"),
                    reader.GetInt32("TotalYDs"),
                    reader.GetInt32("AverageYDs"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("ReceivingYDs"),
                     reader.GetInt32("RushingYDs")));
            }

            return heightStats;
        }
    }
}
