using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class GetFantasyPoints
    {
        public string FirstName { get; }

        public string LastName { get; }

        public string Position { get; }

        public decimal TotalFantasyPoints { get; }

        public long PositionRank { get; }

        public GetFantasyPoints(string firstName, string lastName, string position, decimal totalFantasyPoints, long posRank)
        {
            FirstName = firstName;
            LastName = lastName;
            Position = position;
            TotalFantasyPoints = totalFantasyPoints;
            PositionRank = posRank;
        }
    }
}
