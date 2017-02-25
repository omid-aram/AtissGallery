using AtissGallery.Api.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using File = AtissGallery.Api.Entities.File;

namespace AtissGallery.Api.Controllers
{
    [Authorize]
    public class FileController : ApiController
    {
        private void Resize(Image srcImage, string outputFile, int newWidth)
        {
            //using (var srcImage = Image.FromFile(imageFile))
            //{
            double scaleFactor = (double)newWidth / srcImage.Width;
            //var newWidth = (int)(srcImage.Width * scaleFactor);
            var newHeight = (int)(srcImage.Height * scaleFactor);
            //using (var newImage = new Bitmap(newWidth, newHeight))
            //using (var graphics = Graphics.FromImage(newImage))
            //{
            //    graphics.SmoothingMode = SmoothingMode.HighQuality;
            //    graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            //    graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
            //    graphics.DrawImage(srcImage, new Rectangle(0, 0, newWidth, newHeight));
            //    newImage.Save(outputFile, srcImage.RawFormat);
            //}
            //}
            srcImage.GetThumbnailImage(newWidth, newHeight, null, (IntPtr)0).Save(outputFile, srcImage.RawFormat);
        }

        private string GetVirtualPath(string physicalPath)
        {
            var applicationPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
            if (!physicalPath.StartsWith(applicationPath))
            {
                throw new InvalidOperationException("Physical path is not within the application root");
            }

            return "/" + physicalPath.Substring(applicationPath.Length).Replace("\\", "/");
        }

        private string GetPhysicalPath(string virtualPath)
        {
            var applicationPath = System.Web.Hosting.HostingEnvironment.MapPath("~/");
            return applicationPath + virtualPath.Replace("/", "\\");
        }

        public Task<HttpResponseMessage> PostFile()
        {
            if (!Request.Content.IsMimeMultipartContent())
            {
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);
            }

            var streamProvider = new CustomMultipartFormDataStreamProvider(ContentType.Media);
            var task = Request.Content.ReadAsMultipartAsync(streamProvider).ContinueWith(t =>
            {
                if (t.IsFaulted || t.IsCanceled)
                {
                    return Request.CreateResponse(HttpStatusCode.BadRequest, new { message = Helper.GetInnerestException(t.Exception) });
                }

                foreach (MultipartFileData file in streamProvider.FileData)
                {
                    var info = new FileInfo(file.LocalFileName);
                    var address = GetVirtualPath(file.LocalFileName);
                    var content_type = file.Headers.ContentType.MediaType;
                    var length = info.Length;

                    var coverName = string.Format("{0}\\cover\\{1}", info.DirectoryName, info.Name);
                    if (content_type.Contains("video"))
                    {
                        try
                        {
                            coverName = coverName.Substring(0, coverName.Length - Path.GetExtension(coverName).Length) + ".jpg";
                            var ffMpeg = new NReco.VideoConverter.FFMpegConverter();
                            var thumbJpegStream = new MemoryStream();
                            ffMpeg.GetVideoThumbnail(file.LocalFileName, thumbJpegStream, 1);

                            using (var srcImage = Image.FromStream(thumbJpegStream))
                            {
                                //Resize(srcImage, coverName, 160);
                                srcImage.Save(coverName, srcImage.RawFormat);
                            }

                            thumbJpegStream.Close();
                        }
                        catch(Exception ex)
                        {
                            info.Delete();
                            return Request.CreateResponse(HttpStatusCode.BadRequest, new { message = Helper.GetInnerestException(ex) });
                        }
                    }
                    else
                    {
                        using (var srcImage = Image.FromFile(file.LocalFileName))
                        {
                            Resize(srcImage, coverName, 160);
                        }
                    }

                    var cover = GetVirtualPath(coverName);

                    var db = new DbProvider();
                    db.ExecuteNonQuery(string.Format("insert into [file] (address, cover, content_type, length) values('{0}', '{1}', '{2}', {3})", address, cover, content_type, length), CommandType.Text, null);
                }
                return Request.CreateResponse(HttpStatusCode.OK, new { success = true });
            });

            return task;
        }

        [HttpPost]
        public HttpResponseMessage DeleteFile(File file)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from [file] where id = {0}", file.Id), CommandType.Text, null);
                db.Commit();

                System.IO.File.Delete(GetPhysicalPath(file.Address));
                System.IO.File.Delete(GetPhysicalPath(file.Cover));

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [AllowAnonymous]
        public List<File> GetOlderFiles(int id)
        {
            var result = new List<File>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable("select top 12 t.id, t.address, t.cover, t.content_type, t.length From [file] t where @lastId < 0 or t.id < @lastId order by t.id desc",
                CommandType.Text, new SqlParameter("@lastId", id));

            foreach (DataRow row in dtResult.Rows)
            {
                result.Add(new File
                {
                    Id = (int)row["id"],
                    Address = (string)row["address"],
                    Cover = (string)row["cover"],
                    ContentType = (string)row["content_type"],
                    Length = (long)row["length"]
                });
            }

            return result;
        }

        [AllowAnonymous]
        public List<File> GetNewerFiles(int id)
        {
            var result = new List<File>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable("select top 10 t.id, t.address, t.cover, t.content_type, t.length From [file] t where @firstId < 0 or t.id > @firstId order by t.id desc",
                CommandType.Text, new SqlParameter("@firstId", id));

            foreach (DataRow row in dtResult.Rows)
            {
                result.Add(new File
                {
                    Id = (int)row["id"],
                    Address = (string)row["address"],
                    Cover = (string)row["cover"],
                    ContentType = (string)row["content_type"],
                    Length = (long)row["length"]
                });
            }

            return result;
        }

        //// GET api/upload
        //public HttpResponseMessage GetMedia(string id)
        //{
        //    //string localFilePath = "F:/Projects/Online/AtissGallery/AtissGallery.Api/App_Data/BodyPart_4006b326-e71a-404a-8d3c-bcbfb99a2443";
        //    //string localFilePath = System.Web.Hosting.HostingEnvironment.MapPath("~/App_Data/" + id);
        //    string localFilePath = System.Web.Hosting.HostingEnvironment.MapPath("~/html/_media/" + id);

        //    HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
        //    response.Content = new StreamContent(new FileStream(localFilePath, FileMode.Open, FileAccess.Read));
        //    //response.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("attachment");
        //    response.Content.Headers.ContentDisposition = new System.Net.Http.Headers.ContentDispositionHeaderValue("inline");
        //    response.Content.Headers.ContentDisposition.FileName = "myImage.jpg";
        //    response.Content.Headers.ContentType = new System.Net.Http.Headers.MediaTypeHeaderValue("image/jpg");

        //    response.Headers.CacheControl = new CacheControlHeaderValue
        //    { Public = true };

        //    return response;
        //}

        //public Task<HttpResponseMessage> PostFormData()
        //{
        //    if (!Request.Content.IsMimeMultipartContent())
        //    {
        //        throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);
        //    }

        //    string root = HttpContext.Current.Server.MapPath("~/html/_media");
        //    var provider = new MultipartFormDataStreamProvider(root);
        //    var fileName = provider.GetLocalFileName(Request.Content.Headers);

        //    // Read the form data and return an async task.
        //    var task = Request.Content.ReadAsMultipartAsync(provider).
        //        ContinueWith(t =>
        //        {
        //            if (t.IsFaulted || t.IsCanceled)
        //            {
        //                Request.CreateErrorResponse(HttpStatusCode.InternalServerError, t.Exception);
        //            }

        //            foreach (MultipartFileData file in provider.FileData)
        //            {
        //                var address = GetVirtualPath(file.LocalFileName);
        //                var filename = file.Headers.ContentDisposition.FileName.Trim('\"', '\'');
        //                var content_type = file.Headers.ContentType.MediaType;

        //                var db = new DbProvider();
        //                db.ExecuteNonQuery(string.Format("insert into module_file (address, filename, content_type) values('{0}', '{1}', '{2}')", address, filename, content_type), CommandType.Text, null);
        //            }
        //            return Request.CreateResponse(HttpStatusCode.OK, new { success = true });
        //        });

        //    return task;
        //}

        //public async Task<HttpResponseMessage> PostUserImage()
        //{
        //    try
        //    {

        //        var httpRequest = HttpContext.Current.Request;

        //        foreach (string file in httpRequest.Files)
        //        {
        //            HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created);

        //            var postedFile = httpRequest.Files[file];
        //            if (postedFile != null && postedFile.ContentLength > 0)
        //            {

        //                int MaxContentLength = 1024 * 1024 * 1; //Size = 1 MB

        //                IList<string> AllowedFileExtensions = new List<string> { ".jpg", ".gif", ".png" };
        //                var ext = postedFile.FileName.Substring(postedFile.FileName.LastIndexOf('.'));
        //                var extension = ext.ToLower();
        //                if (!AllowedFileExtensions.Contains(extension))
        //                {

        //                    var message = string.Format("Please Upload image of type .jpg,.gif,.png.");

        //                    return Request.CreateResponse(HttpStatusCode.BadRequest);
        //                }
        //                else if (postedFile.ContentLength > MaxContentLength)
        //                {

        //                    var message = string.Format("Please Upload a file upto 1 mb.");

        //                    return Request.CreateResponse(HttpStatusCode.BadRequest);
        //                }
        //                else
        //                {

        //                    //YourModelProperty.imageurl = userInfo.email_id + extension;
        //                    //  where you want to attach your imageurl

        //                    //if needed write the code to update the table
        //                    var address = postedFile.FileName;
        //                    var filename = postedFile.FileName;
        //                    var content_type = postedFile.ContentType;

        //                    var db = new DbProvider();
        //                    db.ExecuteNonQuery(string.Format("insert into module_file (address, filename, content_type) values('{0}', '{1}', '{2}')", address, filename, content_type), CommandType.Text, null);

        //                    var filePath = HttpContext.Current.Server.MapPath("~/_media/" + filename);
        //                    //Userimage myfolder name where i want to save my image
        //                    postedFile.SaveAs(filePath);

        //                }
        //            }

        //            //var message1 = string.Format("Image Updated Successfully.");
        //            //return Request.CreateErrorResponse(HttpStatusCode.Created, message1); ;
        //            return Request.CreateResponse(HttpStatusCode.OK, new { success = true });
        //        }
        //        //var res = string.Format("Please Upload a image.");
        //        return Request.CreateResponse(HttpStatusCode.NotFound);
        //    }
        //    catch (Exception ex)
        //    {
        //        return Request.CreateResponse(HttpStatusCode.NotFound);
        //    }
        //}
    }
}
