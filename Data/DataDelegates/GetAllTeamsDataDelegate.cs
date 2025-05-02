using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetAllTeamsDataDelegate() : DataReaderDelegate<IReadOnlyList<ConferenceTeams>>("NFL.GetAllTeams")
    {
        public override IReadOnlyList<ConferenceTeams> Translate(Command command, IDataRowReader reader)
        {
            var allTeams = new List<ConferenceTeams>();

            while (reader.Read())
            {
                allTeams.Add(new ConferenceTeams(
                    reader.GetNullableInt32("ConferenceSeeding"),
                    reader.GetString("IsConferenceChamp"),
                    reader.GetString("City"),
                    reader.GetString("State"),
                    reader.GetString("Name"),
                    reader.GetString("StadiumName")));
            }

            return allTeams;
        }
    }
}
