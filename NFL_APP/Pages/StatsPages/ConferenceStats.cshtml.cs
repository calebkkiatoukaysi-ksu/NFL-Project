using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class ConferenceStatsModel : PageModel
    {
        private readonly SqlStatsRepository repository;

        public IReadOnlyList<ConferenceStats> Conferences { get; private set; } = new List<ConferenceStats>();

        public ConferenceStatsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            Conferences = repository.RetrieveConferenceStats;
        }
    }
}
