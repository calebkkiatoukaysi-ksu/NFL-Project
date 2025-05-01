using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetFantasyPointsDataDelegate() : DataReaderDelegate<IReadOnlyList<GetFantasyPoints>>("NFL.GetFantasyPoints")
    {
        public override IReadOnlyList<GetFantasyPoints> Translate(Command command, IDataRowReader reader)
        {
            var fantasyPTS = new List<GetFantasyPoints>();

            while (reader.Read())
            {
                fantasyPTS.Add(new GetFantasyPoints(
                    reader.GetString("FirstName"),
                    reader.GetString("LastName"),
                    reader.GetString("MainPosition"),
                    reader.GetInt32("TotalFantasyPoints")));
            }

            return fantasyPTS;
        }
    }
}
