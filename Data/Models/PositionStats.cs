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
        public string PlayerName { get; }
        public string MainPosition { get; }
        public string TeamName { get; }
        public int PassingYDs { get; }
        public int PassingTDs { get; }
        public int PassingINTs { get; }
        public int RushingYDs { get; }
        public int Carries { get; }
        public int RushingTDs { get; }
        public int RushingFUMs { get; }
        public int Receptions { get; }
        public int ReceivingYDs { get; }
        public int ReceivingTDs { get; }


        public PositionStats(string playerName, string mainPosition, string teamName, int passingYDs, int passingTDs,
            int passingINTs, int carries, int rushingYDs, int rushingTDs, int rushingFUMs, int receptions,
            int receivingYDs, int receivingTDs)
        {
            PlayerName = playerName;
            MainPosition = mainPosition;
            TeamName = teamName;

            PassingYDs = passingYDs;
            PassingTDs = passingTDs;
            PassingINTs = passingINTs;

            Carries = carries;
            RushingYDs = rushingYDs;
            RushingTDs = rushingTDs;
            RushingFUMs = rushingFUMs;

            Receptions = receptions;
            ReceivingYDs = receivingYDs;
            ReceivingTDs = receivingTDs;

        }
    }
}
