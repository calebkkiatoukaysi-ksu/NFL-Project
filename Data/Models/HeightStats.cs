using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class HeightStats : PhysicalStats
    {
        public int Height { get; }

        public HeightStats(int height, int playerCount, int totalTDs, double averageTDs, int totalYDs, double averageYDs,
                           int passingYDS, int receivingYDS, int rushingYDS)
            : base(playerCount, totalTDs, averageTDs, totalYDs, averageYDs, passingYDS, receivingYDS, rushingYDS)
        {
            Height = height;
        }
    }
}
