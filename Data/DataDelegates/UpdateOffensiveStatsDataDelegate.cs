using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DataDelegates
{
    internal class UpdateOffensiveStatsDataDelegate(string firstName, string lastName, int teamID, int passingYDs, int passingTDs, int receivingYDs, int receivingTDs,
        int rushingYDs, int rushingTDs, int receptions, int carries, int rushingFUMs, int passingINTs) : DataDelegate("NFL.UpsertOffensiveStats")
    {
        private readonly string firstName = firstName;
        private readonly string lastName = lastName;
        private readonly int teamID = teamID;
        private readonly int passingYDs = passingYDs;
        private readonly int passingTDs = passingTDs;
        private readonly int receivingYDs = receivingYDs;
        private readonly int receivingTDs = receivingTDs;
        private readonly int rushingYDs = rushingYDs;
        private readonly int rushingTDs = rushingTDs;
        private readonly int receptions = receptions;
        private readonly int carries = carries;
        private readonly int rushingFUMs = rushingFUMs;
        private readonly int passingINTs = passingINTs;

        public override void PrepareCommand(Command command)
        {
            base.PrepareCommand(command);

            command.Parameters.AddWithValue("FIRSTNAME", firstName);
            command.Parameters.AddWithValue("LASTNAME", lastName);
            command.Parameters.AddWithValue("TEAMID", teamID);
            command.Parameters.AddWithValue("PASSINGYDS", passingYDs);
            command.Parameters.AddWithValue("PASSINGTDS", passingTDs);
            command.Parameters.AddWithValue("RECEIVINGYDS", receivingYDs);
            command.Parameters.AddWithValue("RECEIVINGTDS", receivingTDs);
            command.Parameters.AddWithValue("RUSHINGYDS", rushingYDs);
            command.Parameters.AddWithValue("RUSHINGTDS", rushingTDs);
            command.Parameters.AddWithValue("RECEPTIONS", receptions);
            command.Parameters.AddWithValue("CARRIES", carries);
            command.Parameters.AddWithValue("RUSHINGFUMS", rushingFUMs);
            command.Parameters.AddWithValue("PASSINGINTS", passingINTs);
        }
    }
}
