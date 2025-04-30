using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PPR_Player
    {
        public string PlayerName { get; }

        public string MainPosition { get; }

        public string TeamName { get; }

        public string FantasyPoints { get; }

        public int PositionRank { get; }

        public PPR_Player(string playerName, string mainPosition, string teamName, string fantasyPoints, int posRank)
        {
            PlayerName = playerName;
            MainPosition = mainPosition;
            TeamName = teamName;
            FantasyPoints = fantasyPoints;
            PositionRank = posRank;
        }
    }


}
