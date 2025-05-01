using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class TeamStatsModel : PageModel
    {
        private readonly SqlStatsRepository repository;

        public IReadOnlyList<TeamStats> TeamStats { get; private set; } = new List<TeamStats>();

        public TeamStatsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            TeamStats = repository.RetrieveTeamStats;
        }
    }
}
