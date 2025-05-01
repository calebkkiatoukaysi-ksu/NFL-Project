using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class FantasyPointsModel : PageModel
    {
        private readonly SqlStatsRepository repository;

        public IReadOnlyList<GetFantasyPoints> FantasyPTS { get; private set; } = new List<GetFantasyPoints>();

        public FantasyPointsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            FantasyPTS = repository.RetrieveFantasyPTS;
        }
    }
}
