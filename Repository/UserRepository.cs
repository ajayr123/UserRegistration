using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using UserRegistration.Models;
using UserRegistration.Utility;

namespace UserRegistration.Repository
{
    public interface IUserRepository
    {
        IEnumerable<UserListModel> GetAllUser();
        UserAddModel GetUserById(int id);
        int SaveUser(UserAddModel model);
        IEnumerable<SelectListItem> GetStateLookUp();
        IEnumerable<SelectListItem> GetCityLookUp(int stateId);
        int DeleteUser(int id);

    }
    public class UserRepository : IUserRepository
    {
        private readonly IDBHelper _dBHelper;

        public UserRepository(IDBHelper dBHelper)
        {
            _dBHelper = dBHelper;
        }

        public IEnumerable<UserListModel> GetAllUser()
        {
            var result = _dBHelper.ExcecuteProcedure<UserListModel>("GetAllUser");
            return result;
        }

        public UserAddModel GetUserById(int id)
        {
            var result = _dBHelper.ExcecuteProcedure<dynamic, UserAddModel>("GetUserById", new { Id = id });
            return result.FirstOrDefault() ?? new UserAddModel();
        }

        public int SaveUser(UserAddModel model)
        {
            try
            {
                var result = _dBHelper.ExcecuteProcedure<UserAddModel, int>("SaveUser", model);
                return result?.FirstOrDefault() ?? 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public IEnumerable<SelectListItem> GetStateLookUp()
        {
            var result = _dBHelper.ExcecuteProcedure<dynamic, SelectListItem>("dropDown", new { Type = "state" });
            return result;
        }

        public IEnumerable<SelectListItem> GetCityLookUp(int stateId)
        {
            var result = _dBHelper.ExcecuteProcedure<dynamic, SelectListItem>("dropDown", new { Type = "city", State = stateId });
            return result;
        }

        public int DeleteUser(int id)
        {
            try
            {
                var result = _dBHelper.ExcecuteProcedure<dynamic, int>("DeleteUser", new { Id = id });
                return result?.FirstOrDefault() ?? 0;
            }
            catch (Exception)
            {
                return 0;
            }
        }
    }
}
