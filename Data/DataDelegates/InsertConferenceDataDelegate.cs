using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class InsertConferenceDataDelegate(string conferenceName) : NonQueryDataDelegate<Conference>("NFL.InsertConference")
    {
        private readonly string conferenceName = conferenceName;
        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("CONFERENCENAME", conferenceName);

            var p = command.Parameters.Add("CONFERENCEID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Conference Translate(Command command)
        {
            return new Conference(command.GetParameterValue<int>("ConferenceID"), conferenceName);
        }

    }
}
