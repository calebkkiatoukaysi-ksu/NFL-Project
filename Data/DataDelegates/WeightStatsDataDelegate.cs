using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class WeightStatsDataDelegate() : DataReaderDelegate<IReadOnlyList<WeightStats>>("NFL.GetWeightStats")
    {
        public override IReadOnlyList<WeightStats> Translate(Command command, IDataRowReader reader)
        {
            var weightStats = new List<WeightStats>();

            while (reader.Read())
            {
                weightStats.Add(new WeightStats(
                    reader.GetInt32("Weight"),
                    reader.GetInt32("PlayerCount"),
                    reader.GetInt32("TotalTDs"),
                    reader.GetInt32("AverageTDs"),
                    reader.GetInt32("TotalYDs"),
                    reader.GetInt32("AverageYDs"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("ReceivingYDs"),
                    reader.GetInt32("RushingYDs")));
            }

            return weightStats;
        }
    }
}
