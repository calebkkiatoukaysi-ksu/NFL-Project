using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class Division
    {
        public int DivisionID { get; }

        public int ConferenceID { get; }

        public string DivisionName { get; }

        public Division(int divisionID, int conferenceID, string divisionName)
        {
            DivisionID = divisionID;
            ConferenceID = conferenceID;
            DivisionName = divisionName;
        }
    }
}
