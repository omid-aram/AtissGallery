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
    public class CollectionController_old : ApiController
    {
        private List<Collection_old> DataTableToCollectionList(DataTable dataTable)
        {
            var result = new List<Collection_old>();

            foreach (DataRow row in dataTable.Rows)
            {
                result.Add(new Collection_old
                {
                    Id = (int)Helper.GetColumnValue(row, "id"),
                    NameFa = (string)Helper.GetColumnValue(row, "name_fa"),
                    NameEn = (string)Helper.GetColumnValue(row, "name_en"),
                    HeaderMediaId = (int)Helper.GetColumnValue(row, "header_media_id"),
                    CoverMediaId = (int)Helper.GetColumnValue(row, "cover_media_id"),
                    TextFa = (string)Helper.GetColumnValue(row, "text_fa"),
                    TextEn = (string)Helper.GetColumnValue(row, "text_en")
                });
            }

            return result;
        }

        public HttpResponseMessage PostCollection(Collection_old collection)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                collection.NameFa = collection.NameFa ?? collection.NameEn;
                collection.NameEn = collection.NameEn ?? collection.NameFa;
                collection.TextFa = collection.TextFa ?? collection.NameFa;
                collection.TextEn = collection.TextEn ?? collection.NameEn;

                if (collection.Id < 0)
                {
                    var dt = db.ExecuteDataTable(@"insert into collection 
                            (name_fa, name_en, header_media_id, cover_media_id, text_fa, text_en) 
                            OUTPUT Inserted.id 
                            values(@name_fa, @name_en, @header_media_id, @cover_media_id, @text_fa, @text_en)", CommandType.Text, new SqlParameter[] {
                            new SqlParameter("@id", collection.Id),
                            new SqlParameter("@name_fa", collection.NameFa),
                            new SqlParameter("@name_en", collection.NameEn),
                            new SqlParameter("@header_media_id", collection.HeaderMediaId),
                            new SqlParameter("@cover_media_id", collection.CoverMediaId),
                            new SqlParameter("@text_fa", collection.TextFa),
                            new SqlParameter("@text_en", collection.TextEn)
                        });
                    if (dt.Rows.Count == 0) { throw new Exception("Could not insert new collection!"); }
                    collection.Id = (int)dt.Rows[0][0];
                }
                else
                {
                    db.ExecuteNonQuery(@"update collection set name_fa = @name_fa, name_en = @name_en, 
                                            header_media_id = @header_media_id, cover_media_id = @cover_media_id, 
                                            text_fa = @text_fa, text_en = @text_en 
                                        where id = @id", CommandType.Text, new SqlParameter[] {
                            new SqlParameter("@id", collection.Id),
                            new SqlParameter("@name_fa", collection.NameFa),
                            new SqlParameter("@name_en", collection.NameEn),
                            new SqlParameter("@header_media_id", collection.HeaderMediaId),
                            new SqlParameter("@cover_media_id", collection.CoverMediaId),
                            new SqlParameter("@text_fa", collection.TextFa),
                            new SqlParameter("@text_en", collection.TextEn)
                        });
                }
                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, collection.Id);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [HttpPost]
        public HttpResponseMessage DeleteCollection(Collection_old collection)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from collection_products where collection_id = {0}", collection.Id), CommandType.Text, null);
                db.ExecuteNonQuery(string.Format("delete from collection where id = {0}", collection.Id), CommandType.Text, null);
                db.Commit();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        private Collection_old GetEmptyCollection()
        {
            return new Collection_old
            {
                Id = -1,
                HeaderMediaId = -1,
                CoverMediaId = -1
            };
        }

        public List<Collection_old> FetchCollections(IdArray ids)
        {
            var result = new List<Collection_old>();

            if (ids != null && ids.Ids != null && ids.Ids.Contains(-1))
            {
                result.Add(GetEmptyCollection());
                ids.Ids.Remove(-1);
            }

            if (ids == null || ids.Ids == null || ids.Ids.Count == 0) return result;

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select c.id, c.name_fa, c.name_en,
                                                                      c.header_media_id, c.cover_media_id, 
                                                                      c.text_fa, c.text_en
                                                                 From collection c
                                                                where c.id in ({0})
                                                                order by c.id desc",
                string.Join(",", ids.Ids)), CommandType.Text, null);

            result.AddRange(DataTableToCollectionList(dtResult));

            //To prevent continuos requesting data that is actually not exist.
            foreach (var id in ids.Ids)
            {
                var item = result.Find(x => x.Id == id);
                if (item == null)
                {
                    item = GetEmptyCollection();
                    item.Id = id;
                    result.Add(item);
                }
            }

            return result;
        }

        public List<Collection_old> GetOlderCollections(int id)
        {
            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select top 12 c.id, c.name_fa, c.name_en,
                                                        c.header_media_id, c.cover_media_id, 
                                                        c.text_fa, c.text_en
                                                    From collection c
                                                where @lastId < 0 or c.id < @lastId
                                                order by c.id desc", CommandType.Text, new SqlParameter("@lastId", id));

            return DataTableToCollectionList(dtResult);
        }

        public List<Collection_old> GetNewerCollections(int id)
        {
            var result = new List<Collection_old>();

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select top 10 c.id, c.name_fa, c.name_en,
                                                        c.header_media_id, c.cover_media_id, 
                                                        c.text_fa, c.text_en
                                                    From collection c
                                                where @firstId < 0 or c.id > @firstId 
                                                order by c.id desc", CommandType.Text, new SqlParameter("@firstId", id));

            return DataTableToCollectionList(dtResult);
        }
    }
}
