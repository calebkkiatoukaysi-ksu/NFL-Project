using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class PositionStatsDataDelegate(string position) : DataReaderDelegate<IReadOnlyList<PositionStats>>("NFL.GetPositionStats") 
    {
        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("Position", position);
        }

        public override IReadOnlyList<PositionStats> Translate(Command command, IDataRowReader reader)
        {
            var positionStats = new List<PositionStats>();

            while (reader.Read())
            {
                positionStats.Add(new PositionStats(
                    reader.GetString("PlayerName"),
                    reader.GetString("MainPosition"),
                    reader.GetString("TeamName"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("PassingTDs"),
                    reader.GetInt32("PassingINTs"),
                    reader.GetInt32("Carries"),
                    reader.GetInt32("RushingYDs"),
                    reader.GetInt32("RushingTDs"),
                    reader.GetInt32("RushingFUMs"),
                    reader.GetInt32("Receptions"),
                    reader.GetInt32("ReceivingYDs"),
                    reader.GetInt32("ReceivingTDs")));
            }

            return positionStats;
        }
    }
}
