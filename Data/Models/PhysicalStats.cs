using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public abstract class PhysicalStats
    {
        public int PlayerCount { get; }
        public int TotalTDs { get; }
        public double AverageTDs { get; }
        public int TotalYDs { get; }
        public double AverageYDs { get; }
        public int PassingYDS { get; }
        public int ReceivingYDS { get; }
        public int RushingYDS { get; }

        protected PhysicalStats(int playerCount, int totalTDs, double averageTDs, int totalYDs, double averageYDs,
                                int passingYDS, int receivingYDS, int rushingYDS)
        {
            PlayerCount = playerCount;
            TotalTDs = totalTDs;
            AverageTDs = averageTDs;
            TotalYDs = totalYDs;
            AverageYDs = averageYDs;
            PassingYDS = passingYDS;
            ReceivingYDS = receivingYDS;
            RushingYDS = rushingYDS;
        }
    }
}
