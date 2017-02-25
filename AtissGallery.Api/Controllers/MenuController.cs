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
    public class MenuController : ApiController
    {
        //private Menu FindNode(List<Menu> menus, int id)
        //{
        //    if (id > 0 && menus != null && menus.Count > 0)
        //    {
        //        foreach (var menu in menus)
        //        {
        //            if (menu.Id == id)
        //            {
        //                return menu;
        //            }
        //            var node = FindNode(menu.SubMenus, id);

        //            if (node != null)
        //            {
        //                return node;
        //            }
        //        }
        //    }
        //    return null;
        //}

        [AllowAnonymous]
        public List<Menu> GetMenus()
        {
            var result = new List<Menu>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select t.id, t.title_fa, t.title_en, t.subtitle_fa, t.subtitle_en, t.address,
                                                        t.menu_type, t.view_order, t.col_no, t.media_id, t.enabled, t.parent_id
                                                   From menu t
                                                  order by t.view_order", CommandType.Text, null);

            foreach (DataRow row in dtResult.Rows)
            {
                result.Add(new Menu
                {
                    Id = (int)Helper.GetColumnValue(row, "id"),
                    TitleFa = (string)Helper.GetColumnValue(row, "title_fa"),
                    TitleEn = (string)Helper.GetColumnValue(row, "title_en"),
                    SubTitleFa = (string)Helper.GetColumnValue(row, "subtitle_fa"),
                    SubTitleEn = (string)Helper.GetColumnValue(row, "subtitle_en"),
                    Address = (string)Helper.GetColumnValue(row, "address"),
                    MenuType = (int)Helper.GetColumnValue(row, "menu_type"),
                    ViewOrder = (int)Helper.GetColumnValue(row, "view_order"),
                    ColNo = (int)Helper.GetColumnValue(row, "col_no"),
                    MediaId = (int?)Helper.GetColumnValue(row, "media_id"),
                    Enabled = (bool)Helper.GetColumnValue(row, "enabled") ? 1 : 0,
                    ParentId = (int?)Helper.GetColumnValue(row, "parent_id"),
                    SubMenus = new List<Menu>()
                });
            }

            //ایجاد ساختار درختی
            foreach (var menu in result)
            {
                //var parent = FindNode(result, menu.ParentId ?? 0);
                var parent = result.Find(x => x.Id == menu.ParentId);
                if (parent != null)
                {
                    parent.SubMenus.Add(menu);
                }
            }

            return result.Where(x => x.ParentId == null).ToList();
        }

        public HttpResponseMessage CreateMenu(Menu menu)
        {
            var db = new DbProvider();
            try
            {
                var dt = db.ExecuteDataTable(string.Format(@"insert into menu (title_fa, title_en, subtitle_fa, subtitle_en, address,
                                                                               menu_type, view_order, col_no, media_id, parent_id) 
                                                             OUTPUT Inserted.id values('', '', '', '', '', {0}, {1}, {2}, @media_id, @parent_id)",
                                                             menu.MenuType, menu.ViewOrder, menu.ColNo),
                                             CommandType.Text, new SqlParameter[] {
                                                 new SqlParameter("@media_id", menu.MediaId > 0 ? (object)menu.MediaId : DBNull.Value),
                                                 new SqlParameter("@parent_id", menu.ParentId > 0 ? (object)menu.ParentId : DBNull.Value)
                                             });

                if (dt.Rows.Count == 0) { throw new Exception("Could not insert new label!"); }
                menu.Id = (int)dt.Rows[0][0];
                menu.SubMenus = new List<Menu>();
                return Request.CreateResponse(HttpStatusCode.OK, menu);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        public HttpResponseMessage UpdateMenus(Menus menus)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                foreach (var menu in menus.List)
                {
                    menu.TitleFa = string.IsNullOrEmpty(menu.TitleFa) ? menu.TitleEn : menu.TitleFa;
                    menu.TitleEn = string.IsNullOrEmpty(menu.TitleEn) ? menu.TitleFa : menu.TitleEn;
                    menu.SubTitleFa = string.IsNullOrEmpty(menu.SubTitleFa) ? menu.SubTitleEn : menu.SubTitleFa;
                    menu.SubTitleEn = string.IsNullOrEmpty(menu.SubTitleEn) ? menu.SubTitleFa : menu.SubTitleEn;

                    db.ExecuteNonQuery(@"Update menu set title_fa = @title_fa, 
                                                         title_en = @title_en,
                                                         subtitle_fa = @subtitle_fa, 
                                                         subtitle_en = @subtitle_en, 
                                                         address = @address,
                                                         menu_type = @menu_type, 
                                                         view_order = @view_order, 
                                                         col_no = @col_no, 
                                                         media_id = @media_id, 
                                                         enabled = @enabled,
                                                         parent_id = @parent_id
                                          where id = @id", CommandType.Text,
                        new SqlParameter[] {
                            new SqlParameter("@id", menu.Id),
                            new SqlParameter("@title_fa", menu.TitleFa ?? string.Empty),
                            new SqlParameter("@title_en", menu.TitleEn ?? string.Empty),
                            new SqlParameter("@subtitle_fa", menu.SubTitleFa ?? string.Empty),
                            new SqlParameter("@subtitle_en", menu.SubTitleEn ?? string.Empty),
                            new SqlParameter("@address", menu.Address ?? string.Empty),
                            new SqlParameter("@menu_type", menu.MenuType),
                            new SqlParameter("@view_order", menu.ViewOrder),
                            new SqlParameter("@col_no", menu.ColNo),
                            new SqlParameter("@media_id", menu.MediaId > 0 ? (object)menu.MediaId : DBNull.Value),
                            new SqlParameter("@enabled", menu.Enabled),
                            new SqlParameter("@parent_id", menu.ParentId > 0 ? (object)menu.ParentId : DBNull.Value)
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
        public HttpResponseMessage DeleteMenu(Menu menu)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from menu where id = {0}", menu.Id), CommandType.Text, null);
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
