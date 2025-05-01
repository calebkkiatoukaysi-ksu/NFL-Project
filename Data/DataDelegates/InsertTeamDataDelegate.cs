using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class InsertTeamDataDelegate(int divisionID, int conferenceID, string city, string state, string name, string stadiumName)
            : NonQueryDataDelegate<Team>("NFL.InsertTeam")
    {
        private readonly int divisionID = divisionID;
        private readonly int conferenceID = conferenceID;
        private readonly string city = city;
        private readonly string state = state;
        private readonly string name = name;
        private readonly string stadiumName = stadiumName;

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("DivisionID", divisionID);
            command.Parameters.AddWithValue("ConferenceID", conferenceID);
            command.Parameters.AddWithValue("City", city);
            command.Parameters.AddWithValue("State", state);
            command.Parameters.AddWithValue("Name", name);
            command.Parameters.AddWithValue("StadiumName", stadiumName);

            var p = command.Parameters.Add("TeamID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Team Translate(Command command)
        {
            return new Team(command.GetParameterValue<int>("TeamID"), divisionID, conferenceID, city, state, name, stadiumName);
        }
    }
}
