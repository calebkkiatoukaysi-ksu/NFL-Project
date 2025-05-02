using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class GetDivisionsAndConferences
    {
        public string DivisionName { get; }

        public string ConferenceName { get; }

        public GetDivisionsAndConferences(string divisionName, string conferenceName)
        {
            DivisionName = divisionName;
            ConferenceName = conferenceName;
        }
    }
}
