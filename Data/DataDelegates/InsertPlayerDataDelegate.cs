using DataAccess;
using Data.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace Data.DataDelegates
{
    internal class InsertPlayerDataDelegate(string firstName, string lastName, int height, int weight, string mainPos) 
        : NonQueryDataDelegate<Player>("NFL.InsertPlayer")
    {
        private readonly string firstName = firstName;
        private readonly string lastName = lastName;
        private readonly int height = height;
        private readonly int weight = weight;
        private readonly string mainPos = mainPos;

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("FirstName", firstName);
            command.Parameters.AddWithValue("LastName", lastName);
            command.Parameters.AddWithValue("Height", height);
            command.Parameters.AddWithValue("Weight", weight);
            command.Parameters.AddWithValue("MainPosition", mainPos);

            var p = command.Parameters.Add("PlayerID", System.Data.SqlDbType.Int);
            p.Direction = System.Data.ParameterDirection.Output;
        }

        public override Player Translate(Command command)
        {
            return new Player(command.GetParameterValue<int>("PlayerID"), firstName, lastName, height, weight, mainPos);
        }

    }
}
