using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class TeamStats
    {
        public string TeamName { get; }

        public int TotalTDs { get; }

        public int TotalYDs { get; }

        public int PassingYDs { get; }

        public int ReceivingYDs { get; }

        public int RushingYDs { get; }

        public TeamStats(string teamName, int totalTds, int totalYds, int passingYds, int receivingYds, int rushingYds)
        {
            TeamName = teamName;
            TotalTDs = totalTds;
            TotalYDs = totalYds;
            PassingYDs = passingYds;
            ReceivingYDs = receivingYds;
            RushingYDs = rushingYds;
        }
    }
}
