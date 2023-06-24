using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserRegistration.Models;
using UserRegistration.Repository;

namespace UserRegistration.Controllers
{
    public class UserController : Controller
    {
        private readonly IUserRepository _userRepository;

        public UserController(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult GetAllUser()
        {
            var UserList = _userRepository.GetAllUser();
            return Json(new { data = UserList });
        }

        public IActionResult AddEditModel(int id)
        {
            ViewBag.StateList = _userRepository.GetStateLookUp();
            ViewBag.CityList = _userRepository.GetCityLookUp(1);
            if (id == 0)
            {
                return View("_AddEditModel", new UserAddModel());
            }
            else
            {
                var user = _userRepository.GetUserById(id);
                return View("_AddEditModel", user);
            }
        }

        [HttpPost]
        public IActionResult Save(UserAddModel model)
        {
            var result = _userRepository.SaveUser(model);
            if (result == 1)
            {
                return Json(new { status = true, Message = "User Updated" });
            }
            else if (result == 2)
            {
                return Json(new { status = true, Message = "User Saved" });
            }
            else
            {
                return Json(new { status = false, Message = "Something wrong!" });
            }
        }

        [HttpGet]
        public IActionResult GetCityList(int id)
        {
            var cityList = _userRepository.GetCityLookUp(id);
            return Json(cityList);
        }

        [HttpPost]
        public IActionResult DeleteUser(int id)
        {
            var result = _userRepository.DeleteUser(id);
            if (result > 0)
            {
                return Json(new { status = true, message = "User Deleted" });
            }
            else
            {
                return Json(new { status = false, message = "Something wrong!" });
            }
        }
    }
}
