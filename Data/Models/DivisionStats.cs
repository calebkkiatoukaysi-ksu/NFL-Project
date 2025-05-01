using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class DivisionStats
    {
        public string DivisionName { get; }

        public int TotalTDs { get; }

        public int TotalYDs { get; }

        public int PassingYDS { get; }

        public int ReceivingYDS { get; }

        public int RushingYDS { get; }

        public DivisionStats(string divisionName, int totalTDs, int totalYDs, int passingYDS, int receivingYDS, int rushingYDS)
        {
            DivisionName = divisionName;
            TotalTDs = totalTDs;
            TotalYDs = totalYDs;
            PassingYDS = passingYDS;
            ReceivingYDS = receivingYDS;
            RushingYDS = rushingYDS;
        }
    }
}
