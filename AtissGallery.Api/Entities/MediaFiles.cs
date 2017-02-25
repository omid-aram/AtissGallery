using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class MediaFiles
    {
        public int Id { get; set; }

        public int MediaId { get; set; }

        public int FileId { get; set; }

        public int ViewOrder { get; set; }

        public string TextFa { get; set; }

        public string TextEn { get; set; }

        public int TextPosition { get; set; }

        public int TextWidth { get; set; }

        public string BackColor { get; set; }

        public string HrefLink { get; set; }

        public File File { get; set; }
    }

    public class IdArray
    {
        public List<int> Ids { get; set; }
    }
}