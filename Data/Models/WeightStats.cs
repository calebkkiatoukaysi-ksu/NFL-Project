using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class WeightStats : PhysicalStats
    {
        public int Weight { get; }
        public WeightStats(int weight, int playerCount, int totalTDs, double averageTDs, int totalYDs, double averageYDs,
                           int passingYDS, int receivingYDS, int rushingYDS)
            : base(playerCount, totalTDs, averageTDs, totalYDs, averageYDs, passingYDS, receivingYDS, rushingYDS)
        {
            Weight = weight;
        }
    }
}
