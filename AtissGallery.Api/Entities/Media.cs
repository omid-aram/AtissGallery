using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Media
    {
        public int Id { get; set; }

        public DateTime InDate { get; set; }

        public List<MediaFiles> MediaFiles { get; set; }
    }
}