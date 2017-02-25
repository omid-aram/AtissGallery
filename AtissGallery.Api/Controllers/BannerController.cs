using AtissGallery.Api.Entities;
using AtissGallery.Api.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AtissGallery.Api.Controllers
{
    [Authorize]
    public class BannerController : ApiController
    {
        private List<Banner> DataTableToBannerList(DataTable dataTable)
        {
            var result = new List<Banner>();

            foreach (DataRow row in dataTable.Rows)
            {
                result.Add(new Banner
                {
                    Id = (int)Helper.GetColumnValue(row, "id"),
                    BannerTypeId = (int)Helper.GetColumnValue(row, "banner_type_id"),
                    FirstMediaId = (int?)Helper.GetColumnValue(row, "first_media_id") ?? -1,
                    FirstLink = (string)Helper.GetColumnValue(row, "first_link"),
                    SecondMediaId = (int?)Helper.GetColumnValue(row, "second_media_id") ?? -1,
                    SecondLink = (string)Helper.GetColumnValue(row, "second_link"),
                    ThirdMediaId = (int?)Helper.GetColumnValue(row, "third_media_id") ?? -1,
                    ThirdLink = (string)Helper.GetColumnValue(row, "third_link"),
                    PageId = (int)Helper.GetColumnValue(row, "page_id"),
                    ViewOrder = (int)Helper.GetColumnValue(row, "view_order"),
                    Enabled = (bool)Helper.GetColumnValue(row, "enabled") ? 1 : 0
                });
            }

            return result;
        }

        [AllowAnonymous]
        public List<Banner> GetPageBanners(int id)
        {
            var result = new List<Banner>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select b.id, b.banner_type_id, b.first_media_id, b.second_media_id, b.third_media_id, b.first_link, b.second_link, b.third_link,
                                                                      b.page_id, b.view_order, b.enabled                                              
                                                                 From banner b
                                                                where b.page_id = {0} 
                                                                order by b.view_order", id),
                                                                CommandType.Text, null);

            result.AddRange(DataTableToBannerList(dtResult));

            return result;
        }

        [AllowAnonymous]
        public List<Banner> FetchBanners(IdArray ids)
        {
            var result = new List<Banner>();

            if (ids == null || ids.Ids == null || ids.Ids.Count == 0) return result;

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select b.id, b.banner_type_id, b.first_media_id, b.second_media_id, b.third_media_id, b.first_link, b.second_link, b.third_link,
                                                                      b.page_id, b.view_order, b.enabled
                                                                 From banner b
                                                                where b.id in ({0})",
                string.Join(",", ids.Ids)), CommandType.Text, null);

            result.AddRange(DataTableToBannerList(dtResult));

            return result;
        }

        public HttpResponseMessage PostBanner(Banner banner)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                if (banner.Id < 0)
                {
                    var dt = db.ExecuteDataTable(string.Format("insert into banner (banner_type_id, page_id, view_order, enabled, first_media_id, second_media_id, third_media_id, first_link, second_link, third_link) OUTPUT Inserted.id values({0}, {1}, {2}, {3}, @first_media_id, @second_media_id, @third_media_id, @first_link, @second_link, @third_link)",
                        banner.BannerTypeId, banner.PageId, banner.ViewOrder, banner.Enabled), CommandType.Text,
                            new SqlParameter[] {
                                new SqlParameter("@first_media_id", banner.FirstMediaId > 0 ? (object)banner.FirstMediaId : DBNull.Value),
                                new SqlParameter("@second_media_id", banner.SecondMediaId > 0 ? (object)banner.SecondMediaId : DBNull.Value),
                                new SqlParameter("@third_media_id", banner.ThirdMediaId > 0 ? (object)banner.ThirdMediaId : DBNull.Value),
                                new SqlParameter("@first_link", !string.IsNullOrEmpty(banner.FirstLink) ? (object)banner.FirstLink : DBNull.Value),
                                new SqlParameter("@second_link", !string.IsNullOrEmpty(banner.SecondLink) ? (object)banner.SecondLink : DBNull.Value),
                                new SqlParameter("@third_link", !string.IsNullOrEmpty(banner.ThirdLink) ? (object)banner.ThirdLink : DBNull.Value)
                            });
                    if (dt.Rows.Count == 0) { throw new Exception("Could not insert new banner!"); }
                    banner.Id = (int)dt.Rows[0][0];
                }
                else
                {
                    db.ExecuteNonQuery(string.Format("update banner set banner_type_id = {1}, page_id = {2}, view_order = {3}, enabled = {4}, first_media_id = @first_media_id, second_media_id = @second_media_id, third_media_id = @third_media_id, first_link = @first_link, second_link = @second_link, third_link = @third_link where id = {0}",
                        banner.Id, banner.BannerTypeId, banner.PageId, banner.ViewOrder, banner.Enabled), CommandType.Text,
                            new SqlParameter[] {
                                new SqlParameter("@first_media_id", banner.FirstMediaId > 0 ? (object)banner.FirstMediaId : DBNull.Value),
                                new SqlParameter("@second_media_id", banner.SecondMediaId > 0 ? (object)banner.SecondMediaId : DBNull.Value),
                                new SqlParameter("@third_media_id", banner.ThirdMediaId > 0 ? (object)banner.ThirdMediaId : DBNull.Value),
                                new SqlParameter("@first_link", !string.IsNullOrEmpty(banner.FirstLink) ? (object)banner.FirstLink : DBNull.Value),
                                new SqlParameter("@second_link", !string.IsNullOrEmpty(banner.SecondLink) ? (object)banner.SecondLink : DBNull.Value),
                                new SqlParameter("@third_link", !string.IsNullOrEmpty(banner.ThirdLink) ? (object)banner.ThirdLink : DBNull.Value)
                            });
                }

                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, banner);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteBanner(Banner banner)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from banner where id = {0}", banner.Id), CommandType.Text, null);
                db.Commit();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        public HttpResponseMessage UpdateBanners(Banners banners)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                foreach (var banner in banners.List)
                {
                    db.ExecuteNonQuery(string.Format(@"Update banner set banner_type_id = {1}, 
                                                                         view_order = {2}, 
                                                                         enabled = {3} 
                                                        where id = {0}",
                                                        banner.Id, banner.BannerTypeId, banner.ViewOrder,
                                                        banner.Enabled),
                                        CommandType.Text, null);
                }
                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }
    }
}
