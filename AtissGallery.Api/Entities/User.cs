﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Entities
{
    public class User
    {
        public int Id { get; set; }

        public string UserName { get; set; }

        public string FullName { get; set; }
    }
}