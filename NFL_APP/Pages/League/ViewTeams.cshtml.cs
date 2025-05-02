using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.League
{
    public class ViewTeamsModel : PageModel
    {
        private readonly SqlTeamRepository repository;
        public string SelectedType { get; set; } = "All"; // Default

        public List<string> TableHeaders = new List<string> {"ConferenceSeeding", "IsConferenceChamp", "City", "State", "Name", "StadiumName"};

        public IReadOnlyList<ConferenceTeams> Teams { get; private set; } = new List<ConferenceTeams>();

        public ViewTeamsModel(SqlTeamRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            // Default to QB on first load
            LoadTeams("All");
        }

        public IActionResult OnPostGetConference(string type)
        {
            SelectedType = type;
            LoadTeams(type);
            return Page();
        }

        private void LoadTeams(string position)
        {
            switch (position)
            {
                case "All":
                    Teams = repository.RetrieveAllTeams;
                    break;
                case "AFC":
                    Teams = repository.RetrieveAFCTeams;
                    break;
                case "NFC":
                    Teams = repository.RetrieveNFCTeams;
                    break;
            }
        }
    }
}
