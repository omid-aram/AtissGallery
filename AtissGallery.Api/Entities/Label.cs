using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Label
    {
        public int Id { get; set; }

        public string KeyCode { get; set; }

        public string NameFa { get; set; }

        public string NameEn { get; set; }

        public int ViewOrder { get; set; }

        public string MasterKeyCode { get; set; }

        public int? PageId { get; set; }
    }

    public class Labels
    {
        public List<Label> List { get; set; }
    }
}