using Data;
using Data.Models;

using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class DivisionStatsModel : PageModel
    {
        private readonly SqlStatsRepository repository;

        public IReadOnlyList<DivisionStats> DivisionStats { get; private set; } = new List<DivisionStats>();

        public DivisionStatsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            DivisionStats = repository.RetrieveDivisionStats;
        }
    }
}
