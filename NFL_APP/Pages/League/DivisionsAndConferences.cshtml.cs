using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.League
{
    public class DivisionsAndConferencesModel : PageModel
    {
        private readonly SqlTeamRepository repository;

        public IReadOnlyList<GetDivisionsAndConferences> Conferences { get; private set; } = new List<GetDivisionsAndConferences>();

        public DivisionsAndConferencesModel(SqlTeamRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            Conferences = repository.RetrieveDivisionsAndConferences;
        }
    }
}
