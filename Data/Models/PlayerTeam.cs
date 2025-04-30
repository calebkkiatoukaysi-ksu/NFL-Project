using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class PlayerTeam
    {
        public int PlayerTeamID { get; }

        public int PlayerID { get; }

        public int TeamID { get; }

        public PlayerTeam(int playerTeamID, int playerID, int teamID)
        {
            PlayerTeamID = playerTeamID;
            PlayerID = playerID;
            TeamID = teamID;
        }
    }
}
