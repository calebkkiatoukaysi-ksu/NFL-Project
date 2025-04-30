using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PositionStats
    {
        public string Name { get; }

        public string MainPosition { get; }

        public string TeamName { get; }

        public int TotalTDs { get; }

        public int PassingTDs { get; }

        public int ReceivingTDs { get; }

        public int RushingTDs { get; }

        public int PassingYDs { get; }

        public int ReceivingYDs { get; }

        public int Receptions { get; }

        public int Carries { get; }

        public int RushingFUMs { get; }

        public PositionStats(string name, string mainPosition, string teamName, int totalTDs, int passingTDs,
            int receivingTDs, int rushingTDs, int passingYDs, int receivingYDs, int receptions, int carries, int rushingFUMs)
        {
            Name = name;
            MainPosition = mainPosition;
            TeamName = teamName;
            TotalTDs = totalTDs;
            PassingTDs = passingTDs;
            ReceivingTDs = receivingTDs;
            RushingTDs = rushingTDs;
            PassingYDs = passingYDs;
            ReceivingYDs = receivingYDs;
            Receptions = receptions;
            Carries = carries;
            RushingFUMs = rushingFUMs;
        }
    }
}
