using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Purchase
    {
        public int Id { get; set; }

        public int ProductId { get; set; }

        public string CustomerName { get; set; }

        public string CustomerPhone { get; set; }

        public string CustomerEmail { get; set; }

        public string CustomerAddress { get; set; }

        public string Description { get; set; }

        public KeyValuePair<int, string> Captcha { get; set;
        }
    }
}