using Data.DataDelegates;
using Data.Models;
using DataAccess;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Data
{
    /// <summary>
    /// This is going to be for all SQL related to Team (Standings or Stats)
    /// </summary>
    public class SqlTeamRepository : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler? PropertyChanged;

        protected void OnPropertyChanged(string name)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(name));
        }

        private const string connectionString = @"Server=(localdb)\MSSQLLocalDb;Database=NFL_PROJECT;Integrated Security=SSPI;";

        private readonly SqlCommandExecutor executor;

        public SqlTeamRepository()
        {
            executor = new SqlCommandExecutor(connectionString);
        }
        // Get All Teams
        public IReadOnlyList<ConferenceTeams> RetrieveAllTeams => executor.ExecuteReader(new GetAllTeamsDataDelegate());

        // Get NFC Teams
        public IReadOnlyList<ConferenceTeams> RetrieveNFCTeams => executor.ExecuteReader(new GetNFCTeamsDataDelegate());

        // Get AFC Teams
        public IReadOnlyList<ConferenceTeams> RetrieveAFCTeams => executor.ExecuteReader(new GetAFCTeamsDataDelegate());

        public IReadOnlyList<GetDivisionsAndConferences> RetrieveDivisionsAndConferences => executor.ExecuteReader(new GetDivisionsAndConferencesDataDelegate());

        public void CreateTeam(int divisionID, int conferenceID, string city, string state, string name, string stadiumName)
        {
            if (string.IsNullOrWhiteSpace(city)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(state)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(name)) throw new ArgumentException();
            if (string.IsNullOrWhiteSpace(stadiumName)) throw new ArgumentException();

            var insertTeam = new InsertTeamDataDelegate(divisionID, conferenceID, city, state, name, stadiumName);
            executor.ExecuteNonQuery(insertTeam);


            OnPropertyChanged(nameof(RetrieveAllTeams));
            OnPropertyChanged(nameof(RetrieveAFCTeams));
            OnPropertyChanged(nameof(RetrieveNFCTeams));
        }


        public void CreateConference(string conferenceName)
        {
            if (string.IsNullOrWhiteSpace(conferenceName)) throw new ArgumentException();

            var insertConference = new InsertConferenceDataDelegate(conferenceName);
            executor.ExecuteNonQuery(insertConference);


            OnPropertyChanged(nameof(RetrieveAllTeams));
            OnPropertyChanged(nameof(RetrieveAFCTeams));
            OnPropertyChanged(nameof(RetrieveNFCTeams));
        }

        public Division CreateDivision(string divisionName, int conferenceID)
        {
            if (string.IsNullOrWhiteSpace(divisionName)) throw new ArgumentException();

            var insertDivision = new InsertDivisionDataDelegate(divisionName, conferenceID);
            var result = executor.ExecuteNonQuery(insertDivision);

            OnPropertyChanged(nameof(RetrieveAllTeams));
            OnPropertyChanged(nameof(RetrieveAFCTeams));
            OnPropertyChanged(nameof(RetrieveNFCTeams));

            return result;
        }

    }
}
