using Microsoft.AspNetCore.Mvc;

namespace Controllers
{
    [Route("")]
    public class HomeController : Controller
    {
        /// <summary>
        /// Возвращает список продуктов.
        /// </summary>
        [HttpGet, Route("/")]

        public IActionResult Index()
        {
            return View();
        }
    }
}