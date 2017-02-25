using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Web;

namespace AtissGallery.Api.Providers
{
    public class CustomMultipartFormDataStreamProvider : MultipartFormDataStreamProvider
    {
        private ContentType _contentType;
        private string[] AllowMediaTypes = new string[] { "image/jpeg", "image/jpg", "image/png", "image/gif", "image/bmp", "video/mp4" };
        private static string GetRootPath(ContentType contentType)
        {
            switch (contentType)
            {
                case ContentType.Media:
                    return HttpContext.Current.Server.MapPath("~/media");
                default:
                    return HttpContext.Current.Server.MapPath("~/files");
            }
        }
        public new string RootPath { get { return GetRootPath(_contentType); } }

        public CustomMultipartFormDataStreamProvider(ContentType contentType) : base(GetRootPath(contentType))
        {
            _contentType = contentType;
        }

        public override string GetLocalFileName(System.Net.Http.Headers.HttpContentHeaders headers)
        {
            var type = headers.ContentType.MediaType;
            switch (_contentType)
            {
                case ContentType.Media:
                    if (!AllowMediaTypes.Contains(type)) throw new Exception(string.Format("Uploaded file type ({0}) is not a valid media.", type));
                    break;
                case ContentType.Other:
                    break;
                default:
                    break;
            }
            
            var name = !string.IsNullOrWhiteSpace(headers.ContentDisposition.FileName) ? headers.ContentDisposition.FileName : "NoName";
            var localFileName = Path.GetFileName(name.Replace("\"", string.Empty).Replace(" ", string.Empty)); //this is here because Chrome submits files in quotation marks which get treated as part of the filename and get escaped
            if (File.Exists(Path.Combine(RootPath, localFileName)))
            {
                throw new Exception("There is already a file with the same name on the server.");
            }
            return localFileName;
        }
    }

    public enum ContentType
    {
        Media,
        Other
    }
}