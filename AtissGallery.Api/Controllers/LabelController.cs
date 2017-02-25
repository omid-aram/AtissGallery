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
    public class LabelController : ApiController
    {
        [AllowAnonymous]
        public List<Label> GetLabels()
        {
            var result = new List<Label>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select t.id, t.keycode, t.name_fa, t.name_en, t.view_order, t.master_keycode
                                                   From label t
                                                  order by t.view_order", CommandType.Text, null);

            foreach (DataRow row in dtResult.Rows)
            {
                result.Add(new Label
                {
                    Id = (int)Helper.GetColumnValue(row, "id"),
                    KeyCode = (string)Helper.GetColumnValue(row, "keycode"),
                    NameFa = (string)Helper.GetColumnValue(row, "name_fa"),
                    NameEn = (string)Helper.GetColumnValue(row, "name_en"),
                    ViewOrder = (int)Helper.GetColumnValue(row, "view_order"),
                    MasterKeyCode = (string)Helper.GetColumnValue(row, "master_keycode"),
                });
            }

            return result;
        }

        public HttpResponseMessage CreateLabel()
        {
            var db = new DbProvider();
            try
            {
                var dt = db.ExecuteDataTable(string.Format("insert into label (keycode, name_fa, name_en, view_order, master_keycode) OUTPUT Inserted.id values(SUBSTRING(CONVERT(varchar(255), NEWID()), 0, 7), '', '', 0, null)", 1), CommandType.Text, null);
                if (dt.Rows.Count == 0) { throw new Exception("Could not insert new label!"); }
                var id = (int)dt.Rows[0][0];
                return Request.CreateResponse(HttpStatusCode.OK, id);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        public HttpResponseMessage UpdateLabels(Labels labels)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                foreach (var label in labels.List)
                {
                    int? pageId = null;
                    if (!string.IsNullOrEmpty(label.MasterKeyCode))
                    {
                        var dt = db.ExecuteDataTable(@"select id From page where keycode = @keycode", CommandType.Text,
                            new SqlParameter[] {
                                new SqlParameter("@keycode", label.KeyCode)
                            });

                        if (dt == null || dt.Rows.Count == 0)
                        {
                            dt = db.ExecuteDataTable(@"insert into page (keycode) OUTPUT Inserted.id values(@keycode)", CommandType.Text,
                                new SqlParameter[] { new SqlParameter("@keycode", label.KeyCode) });

                            if (dt.Rows.Count == 0) { throw new Exception("Could not insert new page!"); }
                        }
                        pageId = (int)dt.Rows[0][0];
                    }

                    label.NameFa = string.IsNullOrEmpty(label.NameFa) ? label.NameEn.Trim() : label.NameFa.Trim();
                    label.NameEn = string.IsNullOrEmpty(label.NameEn) ? label.NameFa.Trim() : label.NameEn.Trim();

                    db.ExecuteNonQuery(@"Update label set keycode = @keycode, 
                                                          name_fa = @name_fa, 
                                                          name_en = @name_en, 
                                                          view_order = @view_order,
                                                          master_keycode = @master_keycode,
                                                          page_id = @page_id
                                          where id = @id", CommandType.Text,
                        new SqlParameter[] {
                            new SqlParameter("@id", label.Id),
                            new SqlParameter("@keycode", label.KeyCode),
                            new SqlParameter("@name_fa", label.NameFa ?? string.Empty),
                            new SqlParameter("@name_en", label.NameEn ?? string.Empty),
                            new SqlParameter("@view_order", label.ViewOrder),
                            new SqlParameter("@master_keycode", (object)label.MasterKeyCode ?? DBNull.Value),
                            new SqlParameter("@page_id", (object)pageId ?? DBNull.Value),
                        });
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

        [HttpPost]
        public HttpResponseMessage DeleteLabel(Label label)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from label where id = {0}", label.Id), CommandType.Text, null);
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
