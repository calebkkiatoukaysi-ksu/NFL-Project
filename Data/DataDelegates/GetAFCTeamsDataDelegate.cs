using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetAFCTeamsDataDelegate() : DataReaderDelegate<IReadOnlyList<ConferenceTeams>>("NFL.GetAFCTeams")
    {
        public override IReadOnlyList<ConferenceTeams> Translate(Command command, IDataRowReader reader)
        {
            var afcTeams = new List<ConferenceTeams>();

            while (reader.Read())
            {
                afcTeams.Add(new ConferenceTeams(
                    reader.GetInt32("ConferenceName"),
                    reader.GetString("IsConferenceChamp"),
                    reader.GetString("City"),
                    reader.GetString("State"),
                    reader.GetString("Name"),
                    reader.GetString("StadiumName")));
            }

            return afcTeams;
        }
    }
}
