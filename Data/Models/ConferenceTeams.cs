using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.Models
{
    public class ConferenceTeams
    {
        public int? ConferenceSeeding { get; }

        public bool IsConferenceChamp { get; } // will be read as a string so have to convert

        public string City { get; }

        public string State { get; }

        public string Name { get; }

        public string StadiumName { get; }


        public ConferenceTeams(int? conferenceSeeding, string isConferenceChampStr, string city, string state, string name, string stadiumName)
        {
            ConferenceSeeding = conferenceSeeding ?? -1;
            IsConferenceChamp = ConvertToBool(isConferenceChampStr);
            City = city;
            State = state;
            Name = name;
            StadiumName = stadiumName;
        }

        private bool ConvertToBool(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return false;

            return value.Trim().ToLower() switch
            {
                "true" => true,
                "false" => false,
                _ => throw new ArgumentException($"Invalid boolean value: {value}")
            };
        }
    }
}
