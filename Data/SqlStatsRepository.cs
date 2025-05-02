using Data.DataDelegates;
using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Data
{
    /// <summary>
    /// This is going to deal with all of the stats
    /// </summary>
    public class SqlStatsRepository : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        protected void OnPropertyChanged(string name)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name)); // we use on property change because it makes formatting a bit easier and cleaner :)
        }

        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=NFL_PROJECT;Integrated Security=SSPI;";

        private readonly SqlCommandExecutor executor;

        public SqlStatsRepository()
        {
            executor = new SqlCommandExecutor(connectionString);
        }

        // Get Conference Stats, Division Stats, Team Stats
        public IReadOnlyList<ConferenceStats> RetrieveConferenceStats => executor.ExecuteReader(new ConferenceStatsDataDelegate());

        public IReadOnlyList<DivisionStats> RetrieveDivisionStats => executor.ExecuteReader(new DivisionStatsDataDelegate());

        public IReadOnlyList<TeamStats> RetrieveTeamStats => executor.ExecuteReader(new TeamStatsDataDelegate());

        // get Positional Stats
        public IReadOnlyList<PositionStats> RetrieveQBStats => executor.ExecuteReader(new PositionStatsDataDelegate("QB"));
        public IReadOnlyList<PositionStats> RetrieveRBStats => executor.ExecuteReader(new PositionStatsDataDelegate("RB"));
        public IReadOnlyList<PositionStats> RetrieveWRStats => executor.ExecuteReader(new PositionStatsDataDelegate("WR"));
        public IReadOnlyList<PositionStats> RetrieveTEStats => executor.ExecuteReader(new PositionStatsDataDelegate("TE"));
        public IReadOnlyList<PositionStats> RetrieveOtherStats => executor.ExecuteReader(new PositionStatsDataDelegate("Other"));

        // get Height and Weight Stats
        public IReadOnlyList<HeightStats> RetrieveHeightStats => executor.ExecuteReader(new HeightStatsDataDelegate());

        public IReadOnlyList<WeightStats> RetrieveWeightStats => executor.ExecuteReader(new WeightStatsDataDelegate());


        // get Fantasy points
        public IReadOnlyList<GetFantasyPoints> RetrieveFantasyPTS => executor.ExecuteReader(new GetFantasyPointsDataDelegate());
        

        /*
         * Methods (Adding New Player and Update(merge) Offensive Stats
         */


        public Player NewPlayer(string firstName, string lastName, int height, int weight, string mainPosition, int teamID)
        {
            if (string.IsNullOrWhiteSpace(firstName))
                throw new ArgumentNullException(nameof(firstName), "First name cannot be null or empty.");

            if (string.IsNullOrWhiteSpace(lastName))
                throw new ArgumentNullException(nameof(lastName), "Last name cannot be null or empty.");

            if (string.IsNullOrWhiteSpace(mainPosition))
                throw new ArgumentNullException(nameof(lastName), "Position must be filled.");

            var newPlayerDelegate = new InsertPlayerDataDelegate(firstName, lastName, height, weight, mainPosition, teamID);

            var result = executor.ExecuteNonQuery(newPlayerDelegate);


            OnPropertyChanged(nameof(RetrieveConferenceStats));
            OnPropertyChanged(nameof(RetrieveDivisionStats));
            OnPropertyChanged(nameof(RetrieveTeamStats));
            OnPropertyChanged(nameof(RetrieveQBStats));
            OnPropertyChanged(nameof(RetrieveRBStats));
            OnPropertyChanged(nameof(RetrieveWRStats));
            OnPropertyChanged(nameof(RetrieveTEStats));
            OnPropertyChanged(nameof(RetrieveOtherStats));
            OnPropertyChanged(nameof(RetrieveHeightStats));
            OnPropertyChanged(nameof(RetrieveWeightStats));
            OnPropertyChanged(nameof(RetrieveFantasyPTS));

            return result;
        }

        public void UpdateOffensiveStats(string firstName, string lastName, int teamID, int passingYDs, int passingTDs, int receivingYDs, int receivingTDs,
            int rushingYDs, int rushingTDs, int receptions, int carries, int rushingFUMs, int passingINTs)
        {
            if (string.IsNullOrWhiteSpace(firstName))
                throw new ArgumentNullException(nameof(firstName), "First name cannot be null or empty.");

            if (string.IsNullOrWhiteSpace(lastName))
                throw new ArgumentNullException(nameof(lastName), "Last name cannot be null or empty.");

            var offStatsDelegate = new UpdateOffensiveStatsDataDelegate(firstName, lastName, teamID, passingYDs, passingTDs,
                receivingYDs, receivingTDs, rushingYDs, rushingTDs, receptions, carries, rushingFUMs, passingINTs);

            executor.ExecuteNonQuery(offStatsDelegate);

            OnPropertyChanged(nameof(RetrieveConferenceStats));
            OnPropertyChanged(nameof(RetrieveDivisionStats));
            OnPropertyChanged(nameof(RetrieveTeamStats));
            OnPropertyChanged(nameof(RetrieveQBStats));
            OnPropertyChanged(nameof(RetrieveRBStats));
            OnPropertyChanged(nameof(RetrieveWRStats));
            OnPropertyChanged(nameof(RetrieveTEStats));
            OnPropertyChanged(nameof(RetrieveOtherStats));
            OnPropertyChanged(nameof(RetrieveHeightStats));
            OnPropertyChanged(nameof(RetrieveWeightStats));
            OnPropertyChanged(nameof(RetrieveFantasyPTS));

        }


    }
}
