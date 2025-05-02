using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class HeightWeightStatsModel : PageModel
    {
        private readonly SqlStatsRepository repository;
        public string SelectedType { get; set; } = "Height"; // Default

        public List<PhysicalStats> PhysicalStats { get; private set; } = new List<PhysicalStats>();
        public IReadOnlyList<HeightStats> HeightStats { get; private set; } = new List<HeightStats>();
        public IReadOnlyList<WeightStats> WeightStats { get; private set; } = new List<WeightStats>();

        public List<string> TableHeaders = new List<string>();

        public List<string> WeightHeaders = new List<string> { "Height", "Player Count", "Passing Yards", "Rushing Yards", "Receiving Yards", "Total Yards", "Average Yards", "Total Touchdowns"};

        public List<string> HeightHeaders = new List<string> { "Height", "Player Count", "Passing Yards", "Rushing Yards", "Receiving Yards", "Total Yards", "Average Yards", "Total Touchdowns" };


        public HeightWeightStatsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public void OnGet()
        {
            // Default to QB on first load
            LoadStats("Height");
        }

        public IActionResult OnPostGetTypeStats(string type)
        {
            SelectedType = type;
            LoadStats(type);
            return Page();
        }

        private void LoadStats(string position)
        {
            PhysicalStats.Clear();
            switch (position)
            {
                case "Height":
                    HeightStats = repository.RetrieveHeightStats;
                    PhysicalStats.AddRange(HeightStats);
                    TableHeaders = HeightHeaders;
                    break;

                case "Weight":
                    WeightStats = repository.RetrieveWeightStats;
                    PhysicalStats.AddRange(WeightStats);
                    TableHeaders = WeightHeaders;
                    break;
            }
        }
    }
}
