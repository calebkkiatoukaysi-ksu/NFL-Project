using Data.Models;
using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
    {
        public class PositionStatsModel : PageModel
        {
            
            private readonly SqlStatsRepository repository;
            public string SelectedPosition { get; set; } = "QB"; // Default

            public List<string> TableHeaders = new List<string> { "Player", "Position", "Passing Yards", "Passing Touchdowns", "Passing Interceptions", "Rushing Attempts", "Rushing Yards", "Rushing Touchdowns", "Rushing Fumbles", "Receptions", "Receiving Yards", "Receiving Touchdowns" };

            public IReadOnlyList<PositionStats> Stats { get; private set; } = new List<PositionStats>();

            public PositionStatsModel(SqlStatsRepository repository)
            {
                this.repository = repository;
            }

            public void OnGet()
            {
                // Default to QB on first load
                LoadStats("QB");
            }

            public IActionResult OnPostGetPositionStats(string position)
            {
                SelectedPosition = position;
                LoadStats(position);
                return Page();
            }

            private void LoadStats(string position)
            {
                switch (position)
                {
                    case "QB":
                        Stats = repository.RetrieveQBStats;
                        break;
                    case "RB":
                        Stats = repository.RetrieveRBStats;
                        break;
                    case "WR":
                    case "TE":
                        Stats = position == "WR" ? repository.RetrieveWRStats : repository.RetrieveTEStats;
                        break;
                    case "Other":
                        Stats = repository.RetrieveOtherStats;
                        break;
                    default:
                        Stats = new List<PositionStats>();
                        break;
                }
            }
        }
 }
