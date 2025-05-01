using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class HeightStats
    {
        public int Height { get; }

        public int PlayerCount { get; }

        public int TotalTDs { get; }

        public double AverageTDs { get; }

        public int TotalYDs { get; }

        public double AverageYDs { get; }

        public int PassingYDS { get; }

        public int ReceivingYDS { get; }

        public int RushingYDS { get; }

        public HeightStats(int height, int playerCount, int totalTDs, double averageTDs, int totalYDs, double averageYDs, int passingYDS, int receivingYDS, int rushingYDS)
        {
            Height = height;
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
