using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class GetDivisionsAndConferencesDataDelegate() : DataReaderDelegate<IReadOnlyList<GetDivisionsAndConferences>>("NFL.GetDivisionsAndConferences")
    {
        public override IReadOnlyList<GetDivisionsAndConferences> Translate(Command command, IDataRowReader reader)
        {
            var divAndCon = new List<GetDivisionsAndConferences>();

            while (reader.Read())
            {
                divAndCon.Add(new GetDivisionsAndConferences(
                    reader.GetString("DivisionName"),
                    reader.GetString("ConferenceName")));
            }

            return divAndCon;
        }
    }
}
