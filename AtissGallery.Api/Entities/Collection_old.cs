using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Collection_old
    {
        public int Id { get; set; }

        public string NameFa { get; set; }

        public string NameEn { get; set; }

        public int HeaderMediaId { get; set; }

        public int CoverMediaId { get; set; }

        public string TextFa { get; set; }

        public string TextEn { get; set; }
    }
}