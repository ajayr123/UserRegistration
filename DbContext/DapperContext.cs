using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;

namespace UserRegistration.DbContext
{
    public class DapperContext 
    {
        public readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public DapperContext(IConfiguration configuration)
        {
            _configuration = configuration;
            _connectionString = _configuration.GetConnectionString("UserConnection");
        }

        public IDbConnection CreateConnection() => new SqlConnection(_connectionString);
    }
}
