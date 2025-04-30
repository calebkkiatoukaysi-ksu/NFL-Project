using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class Conference
    {
        public int ConferenceID { get; }

        public string ConferenceName { get; }

        public Conference(int conferenceID, string conferenceName)
        {
            ConferenceID = conferenceID;
            ConferenceName = conferenceName;
        }
    }
}
