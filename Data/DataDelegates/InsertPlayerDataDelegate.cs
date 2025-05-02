using DataAccess;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Data.DataDelegates
{
    internal class InsertPlayerDataDelegate(string firstName, string lastName, int height, int weight, string mainPos, int teamID) 
        : NonQueryDataDelegate<Player>("NFL.InsertPlayer")
    {
        private readonly string firstName = firstName;
        private readonly string lastName = lastName;
        private readonly int height = height;
        private readonly int weight = weight;
        private readonly string mainPos = mainPos;
        private readonly int teamID = teamID;


        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("FIRSTNAME", firstName);
            command.Parameters.AddWithValue("LASTNAME", lastName);
            command.Parameters.AddWithValue("HEIGHT", height);
            command.Parameters.AddWithValue("WEIGHT", weight);
            command.Parameters.AddWithValue("MAINPOSITION", mainPos);
            command.Parameters.AddWithValue("TEAMID", teamID);

            var p = command.Parameters.Add("PLAYERID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Player Translate(Command command)
        {
            return new Player(command.GetParameterValue<int>("PLAYERID"), firstName, lastName, height, weight, mainPos);
        }

    }
}
