using Data;
using Data.Models;
using DataAccess;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace NFL_APP.Pages.League
{
    public class LeagueModel : PageModel
    {

        private readonly SqlTeamRepository repository;

        // keep track of how many conference we have
        private static int _conferenceCount = 2;
        public int ConferenceCount { get => _conferenceCount; set { _conferenceCount = value; } }
        private static int _divisionCount = 8;
        public int DivisionCount { get => _divisionCount; set { _divisionCount = value; } }

        // To store the values for Creating a Team
        [BindProperty]
        public string? City { get; set; }

        [BindProperty]
        public string? State { get; set; }

        [BindProperty]
        public string? Name { get; set; }

        [BindProperty]
        public string? StadiumName { get; set; }

        [BindProperty]
        public int ConferenceID { get; set; }

        [BindProperty]
        public int DivisionID { get; set; }

        public LeagueModel(SqlTeamRepository repository)
        {
            this.repository = repository;
        }

        public IActionResult OnPostCreateTeam()
        {
            if (string.IsNullOrWhiteSpace(City) || string.IsNullOrWhiteSpace(State) ||
                        string.IsNullOrWhiteSpace(Name) || string.IsNullOrWhiteSpace(StadiumName))
            {
                ModelState.AddModelError("", "All fields are required.");
                return Page();
            }

            try
            {
                repository.CreateTeam(DivisionID, ConferenceID, City, State, Name, StadiumName);


                City = string.Empty;
                State = string.Empty;
                Name = string.Empty;
                StadiumName = string.Empty;
                ConferenceID = 0;
                DivisionID = 0;

                return Page(); // Redirect to a success page after creation
            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred: " + ex.Message);
                return Page();
            }
        }

        // Store values for creating a Conference
        [BindProperty]
        public string? CreateConferenceName { get; set; }

        public IActionResult OnPostCreateConference()
        {
            if (string.IsNullOrWhiteSpace(CreateConferenceName))
            {
                ModelState.AddModelError("", "All fields are required.");
                return Page();
            }

            try
            {
                repository.CreateConference(CreateConferenceName);
                ConferenceCount++;

                CreateConferenceName = string.Empty;

                return Page();

            }
            catch (Exception ex)
            {
                ModelState.AddModelError("", "An error occurred: " + ex.Message);
                return Page();
            }
        }

        [BindProperty]
        public string? CreateDivisionName { get; set; }

        [BindProperty]
        public int CreateConferenceID { get; set; }

        public IActionResult OnPostCreateDivision()
        {
            if (string.IsNullOrWhiteSpace(CreateDivisionName))
            {
                ModelState.AddModelError("", "All fields are required.");
                return Page();
            }

            try
            {
                repository.CreateDivision(CreateDivisionName, CreateConferenceID);
                DivisionCount++;

                CreateDivisionName = string.Empty;
                CreateConferenceID = 0;

                return Page();

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
