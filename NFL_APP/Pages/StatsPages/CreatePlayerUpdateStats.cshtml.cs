using Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.StatsPages
{
    public class CreatePlayerUpdateStatsModel : PageModel
    {
        private readonly SqlStatsRepository repository;

        // To store the values for Creating a Team
        [BindProperty]
        public string? FirstName { get; set; }

        [BindProperty]
        public string? LastName { get; set; }

        [BindProperty]
        public int Height { get; set; }

        [BindProperty]
        public int Weight { get; set; }

        [BindProperty]
        public string? MainPosition { get; set; }

        [BindProperty]
        public int TeamID { get; set; }

        public CreatePlayerUpdateStatsModel(SqlStatsRepository repository)
        {
            this.repository = repository;
        }

        public IActionResult OnPostCreatePlayer()
        {
            if (string.IsNullOrWhiteSpace(FirstName) || string.IsNullOrWhiteSpace(LastName) ||
                        string.IsNullOrWhiteSpace(MainPosition))
            {
                ModelState.AddModelError("", "All fields are required.");
                return Page();
            }

            try
            {
                repository.NewPlayer(FirstName, LastName, Height, Weight, MainPosition, TeamID);


                FirstName = string.Empty;
                LastName = string.Empty;
                Height = 0;
                Weight = 0;
                MainPosition = string.Empty;
                TeamID = 0;

                return Page(); // Redirect to a success page after creation
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred: " + ex.Message);
                return Page();
            }
        }


        [BindProperty]
        public string UpdateFirstName { get; set; } = string.Empty;

        [BindProperty]
        public string UpdateLastName { get; set; } = string.Empty;

        [BindProperty]
        public int UpdateTeamID { get; set; }

        [BindProperty]
        public int UpdatePassingYDs { get; set; }

        [BindProperty]
        public int UpdatePassingTDs { get; set; }

        [BindProperty]
        public int UpdatePassingINTs { get; set; }

        [BindProperty]
        public int UpdateReceivingYDs { get; set; }

        [BindProperty]
        public int UpdateReceivingTDs { get; set; }

        [BindProperty]
        public int UpdateReceptions { get; set; }

        [BindProperty]
        public int UpdateRushingYDs { get; set; }

        [BindProperty]
        public int UpdateRushingTDs { get; set; }

        [BindProperty]
        public int UpdateCarries { get; set; }

        [BindProperty]
        public int UpdateRushingFUMs { get; set; }

        public IActionResult OnPostUpdateOffensiveStats()
        {
            if (string.IsNullOrWhiteSpace(UpdateFirstName) || string.IsNullOrWhiteSpace(UpdateLastName))
            {
                ModelState.AddModelError("", "All fields are required.");
                return Page();
            }

            try
            {
                repository.UpdateOffensiveStats(UpdateFirstName, UpdateLastName, UpdateTeamID, UpdatePassingYDs, UpdatePassingTDs, UpdatePassingINTs, UpdateReceivingYDs, UpdateReceivingTDs, UpdateReceptions, UpdateRushingYDs, UpdateRushingTDs, UpdateCarries, UpdateRushingFUMs); // ow


                return Page(); // Redirect to a success page after creation
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred: " + ex.Message);
                return Page();
            }
        }

        public void OnGet()
        {
        }
    }
}
