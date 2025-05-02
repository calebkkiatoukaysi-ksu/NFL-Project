using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetNFCTeamsDataDelegate() : DataReaderDelegate<IReadOnlyList<ConferenceTeams>>("NFL.GetNFCTeams")
    {
        public override IReadOnlyList<ConferenceTeams> Translate(Command command, IDataRowReader reader)
        {
            var nfcTeams = new List<ConferenceTeams>();

            while (reader.Read())
            {
                nfcTeams.Add(new ConferenceTeams(
                    reader.GetNullableInt32("ConferenceSeeding"),
                    reader.GetString("IsConferenceChamp"),
                    reader.GetString("City"),
                    reader.GetString("State"),
                    reader.GetString("Name"),
                    reader.GetString("StadiumName")));
            }

            return nfcTeams;
        }
    }
}
