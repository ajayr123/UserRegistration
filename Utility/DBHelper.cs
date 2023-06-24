using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using UserRegistration.DbContext;

namespace UserRegistration.Utility
{
    public interface IDBHelper
    {
        IEnumerable<TResult> ExcecuteProcedure<TResult>(string sp_name);
        IEnumerable<TResult> ExcecuteProcedure<TParams, TResult>(string sp_name, TParams oParams);
    }

    public class DBHelper : IDBHelper
    {
        private readonly DapperContext _context;

        public DBHelper(DapperContext context)
        {
            _context = context;
        }

        public IEnumerable<TResult> ExcecuteProcedure<TResult>(string sp_name)
        {
            try
            {
                using (var connection = _context.CreateConnection())
                {
                    IEnumerable<TResult> result = connection.Query<TResult>(sp_name, commandType: CommandType.StoredProcedure);
                    return result;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public IEnumerable<TResult> ExcecuteProcedure<TParams, TResult>(string sp_name, TParams oParams)
        {
            try
            {
                using (var connection = _context.CreateConnection())
                {
                    var result = connection.Query<TResult>(sp_name, param: oParams, commandType: CommandType.StoredProcedure);
                    return result;
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
