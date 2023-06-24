using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace UserRegistration.Models
{
    public class UserAddModel
    {
        public int Id { get; set; }
        [Required(ErrorMessage = "Please enter name")]
        public string Name { get; set; }

        [RegularExpression(@"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", ErrorMessage = "please enter valid email")]
        [Required(ErrorMessage = "Please enter email")]
        public string Email { get; set; }

        [MaxLength(10)]
        [RegularExpression(@"^(\+\d{1,2}\s?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$", ErrorMessage = "Please enter valid mobile")]
        [Required(ErrorMessage = "Please enter phone")]
        public string Phone { get; set; }
        public string Address { get; set; }
        [Required(ErrorMessage = "Please Select state")]
        public int StateId { get; set; }
        [Required(ErrorMessage = "Please Select city")]
        public int CityId { get; set; }
    }
}
