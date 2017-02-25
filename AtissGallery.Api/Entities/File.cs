using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class File
    {
        public int Id { get; set; }

        public string Address { get; set; }

        public string Cover { get; set; }

        public string ContentType { get; set; }

        public long Length { get; set; }
    }
}