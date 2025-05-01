using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class DivisionStatsDataDelegate () : DataReaderDelegate<IReadOnlyList<DivisionStats>>("NFL.GetDivisionStats")
    {
        public override IReadOnlyList<DivisionStats> Translate(Command command, IDataRowReader reader)
        {
            var divisionStats = new List<DivisionStats>();

            while (reader.Read())
            {
                divisionStats.Add(new DivisionStats(
                    reader.GetString("DivisionName"),
                    reader.GetInt32("TotalTDs"),
                    reader.GetInt32("TotalYDs"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("ReceivingYDs"),
                    reader.GetInt32("RushingYDs")));
            }

            return divisionStats;
        }
    }
}
