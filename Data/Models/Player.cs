using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class Player
    {
        public int PlayerID { get; }

        public string FirstName { get; }

        public string LastName { get; }

        public int Height { get; }

        public int Weight { get; }

        public string MainPosition { get; }

        public Player(int playerID, string firstName, string lastName, int height, int weight, string mainPos)
        {
            PlayerID = playerID;
            FirstName = firstName;
            LastName = lastName;
            Height = height;
            Weight = weight;
            MainPosition = mainPos;
        }
    }
}
