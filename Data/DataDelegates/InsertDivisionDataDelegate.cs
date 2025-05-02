using DataAccess;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Globalization;
using System.Runtime.CompilerServices;

namespace Data.DataDelegates
{
    internal class InsertDivisionDataDelegate(string divisionName, int conferenceID) : NonQueryDataDelegate<Division>("NFL.InsertDivision")
    {
        private readonly string divisionName = divisionName;

        private readonly int conferenceID = conferenceID;

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("DIVISIONNAME", divisionName);
            command.Parameters.AddWithValue("CONFERENCEID", conferenceID);

            var p = command.Parameters.Add("DIVISIONID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Division Translate(Command command)
        {
            return new Division(command.GetParameterValue<int>("DivisionID"), conferenceID, divisionName);
        }
    }
}
