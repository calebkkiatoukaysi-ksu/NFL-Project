using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class ConferenceStats
    {
        public string ConferenceName { get; }

        public int TotalTDs { get; }

        public int TotalYDs { get; }

        public int PassingYDs { get; }

        public int ReceivingYDs { get; }

        public int RushingYDs { get; }

        public ConferenceStats(string conferenceName, int totalTDs, int totalYDs, int passingYDS, int receivingYDS, int rushingYDS)
        {
            ConferenceName = conferenceName;
            TotalTDs = totalTDs;
            TotalYDs = totalYDs;
            PassingYDs = passingYDS;
            ReceivingYDs = receivingYDS;
            RushingYDs = rushingYDS;
        }
    }
}
