using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class ConferenceStatsDataDelegate() : DataReaderDelegate<IReadOnlyList<ConferenceStats>>("NFL.GetConferenceStats")
    {
        public override IReadOnlyList<ConferenceStats> Translate(Command command, IDataRowReader reader)
        {
            var conferenceStats = new List<ConferenceStats>();

            while (reader.Read())
            {
                conferenceStats.Add(new ConferenceStats(
                    reader.GetString("ConferenceName"),
                    reader.GetInt32("TotalTDs"),
                    reader.GetInt32("TotalYDs"),
                    reader.GetInt32("PassingYDs"),
                    reader.GetInt32("ReceivingYDs"),
                    reader.GetInt32("RushingYDs")));
            }

            return conferenceStats;
        }
    }
}
