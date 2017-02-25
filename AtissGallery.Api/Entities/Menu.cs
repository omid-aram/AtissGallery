using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Menu
    {
        public int Id { get; set; }

        public string TitleFa { get; set; }

        public string TitleEn { get; set; }

        public string SubTitleFa { get; set; }

        public string SubTitleEn { get; set; }

        public string Address { get; set; }

        public int MenuType { get; set; }

        public int ViewOrder { get; set; }

        public int ColNo { get; set; }

        public int? MediaId { get; set; }

        public int Enabled { get; set;  }

        public int? ParentId { get; set; }

        public List<Menu> SubMenus { get; set; }
    }

    public class Menus
    {
        public List<Menu> List { get; set; }
    }
}