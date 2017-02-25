using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class Product
    {
        public int Id { get; set; }

        public string Code { get; set; }

        public string NameFa { get; set; }

        public string NameEn { get; set; }

        public int CoverMediaId { get; set; }

        public string TextFa { get; set; }

        public string TextEn { get; set; }

        public int Price { get; set; }

        public int Count { get; set; }

        public List<int> MediaIds { get; set; }

        public List<int> LabelIds { get; set; }
    }

    public class StringType
    {
        public string Value { get; set; }
    }

    public class IntType
    {
        public int Value { get; set; }
    }
}