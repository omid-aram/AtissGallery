using AtissGallery.Api.Entities;
using AtissGallery.Api.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;

namespace AtissGallery.Api.Controllers
{
    [Authorize]
    public class MediaController : ApiController
    {
        private List<Media> DataTableToMediaList(DataTable dataTable)
        {
            var result = new List<Media>();

            foreach (DataRow row in dataTable.Rows)
            {
                var mediaId = (int)row["media_id"];
                var media = result.Find(x => x.Id == mediaId);
                if (media == null)
                {
                    media = new Media
                    {
                        Id = mediaId,
                        MediaFiles = new List<MediaFiles>()
                    };

                    result.Add(media);
                }
                media.MediaFiles.Add(new MediaFiles
                {
                    MediaId = (int)row["media_id"],
                    FileId = (int)row["file_id"],
                    ViewOrder = (int)row["view_order"],
                    TextFa = (string)(row["text_fa"] is DBNull ? string.Empty : row["text_fa"]),
                    TextEn = (string)(row["text_en"] is DBNull ? string.Empty : row["text_en"]),
                    TextPosition = (int)row["text_position"],
                    TextWidth = (int)row["text_width"],
                    BackColor = (string)(row["back_color"] is DBNull ? string.Empty : row["back_color"]),
                    HrefLink = (string)(row["href_link"] is DBNull ? string.Empty : row["href_link"]),
                    File = new File
                    {
                        Id = (int)row["file_id"],
                        Address = (string)row["address"],
                        Cover = (string)row["cover"],
                        ContentType = (string)row["content_type"]
                    }
                });
            }

            return result;
        }

        public HttpResponseMessage PostMedia(Media media)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                if (media.Id < 0)
                {
                    var dt = db.ExecuteDataTable(string.Format("insert into media (user_id) OUTPUT Inserted.id values({0})", 1), CommandType.Text, null);
                    if (dt.Rows.Count == 0) { throw new Exception("Could not insert new media!"); }
                    media.Id = (int)dt.Rows[0][0];
                    foreach (var mediaFile in media.MediaFiles)
                    {
                        mediaFile.MediaId = media.Id;
                    }
                }
                db.ExecuteNonQuery(string.Format("delete from media_files where media_id = {0}", media.Id), CommandType.Text, null);
                foreach (var mediaFile in media.MediaFiles)
                {
                    db.ExecuteNonQuery(string.Format("insert into media_files (media_id, file_id, view_order, text_fa, text_en, text_position, text_width, back_color, href_link) values({0}, {1}, {2}, @text_fa, @text_en, {3}, {4}, @back_color, @href_link)",
                        mediaFile.MediaId, mediaFile.FileId, mediaFile.ViewOrder, mediaFile.TextPosition, mediaFile.TextWidth), CommandType.Text,
                        new SqlParameter[] {
                            new SqlParameter("@text_fa", mediaFile.TextFa ?? string.Empty),
                            new SqlParameter("@text_en", mediaFile.TextEn ?? string.Empty),
                            new SqlParameter("@back_color", mediaFile.BackColor ?? string.Empty),
                            new SqlParameter("@href_link", mediaFile.HrefLink ?? string.Empty)
                        });
                }
                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, media.Id);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteMedia(Media media)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from media_files where media_id = {0}", media.Id), CommandType.Text, null);
                db.ExecuteNonQuery(string.Format("delete from media where id = {0}", media.Id), CommandType.Text, null);
                db.Commit();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        private Media GetEmptyMedia()
        {
            return new Media
            {
                Id = -1,
                MediaFiles = new List<MediaFiles>
                {
                    new MediaFiles
                    {
                        Id = -1,
                        MediaId = -1,
                        FileId = -1,
                        TextWidth = 40,
                        BackColor = "#F4F4F4",
                        File = new File
                        {
                            Id = -1,
                            Address = "/html/design/no-image-slide.png",
                            Cover = "/html/design/no-image-slide.png",
                            ContentType = "image/png"
                        }
                    }
                }
            };
        }

        [AllowAnonymous]
        public List<Media> FetchMedias(IdArray ids)
        {
            var result = new List<Media>();

            if (ids != null && ids.Ids != null && ids.Ids.Contains(-1))
            {
                result.Add(GetEmptyMedia());
                ids.Ids.Remove(-1);
            }

            if (ids == null || ids.Ids == null || ids.Ids.Count == 0) return result;

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select mf.media_id, mf.file_id, mf.view_order, 
                                                                      mf.text_fa, mf.text_en, mf.text_position, mf.text_width, 
                                                                      mf.back_color, mf.href_link, 
                                                                      f.[address], f.cover, f.content_type 
                                                                 From media_files mf
                                                                 join [file] f on mf.file_id = f.id
                                                                where mf.media_id in ({0})
                                                                order by mf.view_order",
                string.Join(",", ids.Ids)), CommandType.Text, null);

            result.AddRange(DataTableToMediaList(dtResult));

            //To prevent continuos requesting data that is actually not exist.
            foreach (var id in ids.Ids)
            {
                var item = result.Find(x => x.Id == id);
                if (item == null)
                {
                    item = GetEmptyMedia();
                    item.Id = id;
                    result.Add(item);
                }
            }

            return result;
        }

        [AllowAnonymous]
        public List<Media> GetOlderMedias(int id)
        {
            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select top 12 mf.media_id, mf.file_id, mf.view_order, 
                                                        mf.text_fa, mf.text_en, mf.text_position, mf.text_width, 
                                                        mf.back_color, mf.href_link, 
                                                        f.[address], f.cover, f.content_type 
                                                    From media_files mf
                                                    join [file] f on mf.file_id = f.id
                                                where @lastId < 0 or mf.media_id < @lastId
                                                order by mf.media_id desc", CommandType.Text, new SqlParameter("@lastId", id));

            return DataTableToMediaList(dtResult);
        }

        [AllowAnonymous]
        public List<Media> GetNewerMedias(int id)
        {
            var result = new List<Media>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select top 10 mf.media_id, mf.file_id, mf.view_order, 
                                                        mf.text_fa, mf.text_en, mf.text_position, mf.text_width, 
                                                        mf.back_color, mf.href_link, 
                                                        f.[address], f.cover, f.content_type 
                                                    From media_files mf
                                                    join [file] f on mf.file_id = f.id
                                                where @firstId < 0 or mf.media_id > @firstId 
                                                order by mf.media_id desc", CommandType.Text, new SqlParameter("@firstId", id));

            return DataTableToMediaList(dtResult);
        }
    }
}