using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Workflow.Common.Services;
using Workflow.Common.Models;

namespace Workflow.Presentation.Web.Controllers
{
    public class HomeController : Controller
    {
        private IProcessService _service;

        public HomeController(IProcessService service)
        {
            _service = service;
        }

        // GET: Home
        public ActionResult Index()
        {
            IEnumerable <Process> p = _service.GetAll();

            return View(p);
        }
    }
}