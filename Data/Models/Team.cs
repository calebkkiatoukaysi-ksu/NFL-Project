using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class Team
    {
        public int TeamID { get; }

        public int DivisionID { get; }

        public int ConferenceID { get; }

        /* 
        public int DivisionSeeding { get; }

        public int ConferenceSeeding { get; }
        */
        public string City { get; }

        public string State { get; }

        public string Name { get; }

        public string StadiumName { get; }

        public Team(int teamID, int divisionID, int conferenceID,
            string city, string state, string name, string stadiumName)
        {
            TeamID = teamID;
            DivisionID = divisionID;
            ConferenceID = conferenceID;
            City = city;
            State = state;
            Name = name;
            StadiumName = stadiumName;
        }
    }
}
