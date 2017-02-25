using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Banner
    {
        public int Id { get; set; }

        public int BannerTypeId { get; set; }

        public int FirstMediaId { get; set; }

        public string FirstLink { get; set; }

        public int SecondMediaId { get; set; }

        public string SecondLink { get; set; }

        public int ThirdMediaId { get; set; }

        public string ThirdLink { get; set; }

        public int PageId { get; set; }

        public int ViewOrder { get; set; }

        public int Enabled { get; set; }
    }

    public class Banners
    {
        public List<Banner> List { get; set; }
    }
}