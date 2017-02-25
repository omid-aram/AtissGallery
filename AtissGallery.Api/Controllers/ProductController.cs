using AtissGallery.Api.Entities;
using AtissGallery.Api.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Web.Http;

namespace AtissGallery.Api.Controllers
{
    [Authorize]
    public class ProductController : ApiController
    {
        private List<Product> DataTableToProductList(DataTable dataTable)
        {
            var result = new List<Product>();

            foreach (DataRow row in dataTable.Rows)
            {
                result.Add(new Product
                {
                    Id = Convert.ToInt32(Helper.GetColumnValue(row, "id")),
                    Code = (string)Helper.GetColumnValue(row, "code"),
                    //NameFa = (string)Helper.GetColumnValue(row, "name_fa"),
                    //NameEn = (string)Helper.GetColumnValue(row, "name_en"),
                    CoverMediaId = (int)Helper.GetColumnValue(row, "cover_media_id"),
                    //TextFa = (string)Helper.GetColumnValue(row, "text_fa"),
                    //TextEn = (string)Helper.GetColumnValue(row, "text_en"),
                    //Count = (int)Helper.GetColumnValue(row, "count"),
                    //Price = (int)Helper.GetColumnValue(row, "price"),
                    MediaIds = new List<int>(),
                    LabelIds = new List<int>()
                });
            }

            return result;
        }

        public HttpResponseMessage PostProduct(Product product)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                product.NameFa = "نام محصول";// product.NameFa ?? product.NameEn;
                product.NameEn = "Product Name";// product.NameEn ?? product.NameFa;
                //product.TextFa = product.TextFa ?? product.NameFa;
                //product.TextEn = product.TextEn ?? product.NameEn;

                if (product.Id < 0)
                {
                    var dt = db.ExecuteDataTable(@"insert into product 
                            (code, name_fa, name_en, cover_media_id, text_fa, text_en, price, [count]) 
                            OUTPUT Inserted.id 
                            values(@code, @name_fa, @name_en, @cover_media_id, @text_fa, @text_en, @count, @price)", CommandType.Text, new SqlParameter[] {
                            new SqlParameter("@code", product.Code),
                            new SqlParameter("@name_fa", product.NameFa),
                            new SqlParameter("@name_en", product.NameEn),
                            new SqlParameter("@cover_media_id", product.CoverMediaId),
                            new SqlParameter("@text_fa", product.TextFa ?? string.Empty),
                            new SqlParameter("@text_en", product.TextEn ?? string.Empty),
                            new SqlParameter("@count", product.Count),
                            new SqlParameter("@price", product.Price)
                        });
                    if (dt.Rows.Count == 0) { throw new Exception("Could not insert new product!"); }
                    product.Id = (int)dt.Rows[0][0];
                }
                else
                {
                    db.ExecuteNonQuery(@"update product set code = @code, name_fa = @name_fa, name_en = @name_en, cover_media_id = @cover_media_id, 
                                                            text_fa = @text_fa, text_en = @text_en, count = @count, price = @price
                                        where id = @id", CommandType.Text, new SqlParameter[] {
                            new SqlParameter("@id", product.Id),
                            new SqlParameter("@code", product.Code),
                            new SqlParameter("@name_fa", product.NameFa),
                            new SqlParameter("@name_en", product.NameEn),
                            new SqlParameter("@cover_media_id", product.CoverMediaId),
                            new SqlParameter("@text_fa", product.TextFa ?? string.Empty),
                            new SqlParameter("@text_en", product.TextEn ?? string.Empty),
                            new SqlParameter("@count", product.Count),
                            new SqlParameter("@price", product.Price),
                        });
                    db.ExecuteNonQuery(string.Format("delete from product_medias where product_id = {0}", product.Id), CommandType.Text, null);
                    db.ExecuteNonQuery(string.Format("delete from product_labels where product_id = {0}", product.Id), CommandType.Text, null);
                }

                //Inserting Product Medias
                if (product.MediaIds != null)
                {
                    for (var i = 0; i < product.MediaIds.Count; i++)
                    {
                        db.ExecuteNonQuery(string.Format(@"insert into product_medias (product_id, media_id, view_order) values({0}, {1}, {2})",
                            product.Id, product.MediaIds[i], i), CommandType.Text, null);
                    }
                }

                //Inserting Product Labels
                foreach (var labelId in product.LabelIds)
                {
                    db.ExecuteNonQuery(string.Format(@"insert into product_labels (product_id, label_id) values({0}, {1})",
                        product.Id, labelId), CommandType.Text, null);
                }

                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, product.Id);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [AllowAnonymous]
        public Page FindLabelPage(StringType keyCode)
        {
            Page result = null;

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select t.page_id from label t 
                                                  where t.keycode = @keycode", CommandType.Text,
                                new SqlParameter[] {
                                new SqlParameter("@keycode", keyCode.Value)
                                });

            if (dtResult.Rows.Count > 0)
            {
                var row = dtResult.Rows[0];
                result = new Page
                {
                    Id = (int)Helper.GetColumnValue(row, "page_id"),
                    KeyCode = keyCode.Value
                };
            }

            return result;
        }

        [HttpPost]
        public HttpResponseMessage DeleteProduct(Product product)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                db.ExecuteNonQuery(string.Format("delete from product_medias where product_id = {0}", product.Id), CommandType.Text, null);
                db.ExecuteNonQuery(string.Format("delete from product_labels where product_id = {0}", product.Id), CommandType.Text, null);
                db.ExecuteNonQuery(string.Format("delete from product where id = {0}", product.Id), CommandType.Text, null);
                db.Commit();

                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        private Product GetEmptyProduct()
        {
            return new Product
            {
                Id = -1,
                CoverMediaId = -1,
                MediaIds = new List<int>(),
                LabelIds = new List<int>()
            };
        }

        [AllowAnonymous]
        public List<Product> FetchFullProduct(StringType code)
        {
            var result = new List<Product>();

            if (code == null || string.IsNullOrEmpty(code.Value))
            {
                result.Add(GetEmptyProduct());
                return result;
            }

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select t.id, t.code, t.[count], t.price, t.text_fa, t.text_en, 
                                                                      t.cover_media_id, m.media_id, lv.label_id
                                                                 From product t
                                                                 left join product_medias m on m.product_id = t.id
                                                                 left join product_labels lv on lv.product_id = t.id
                                                                where t.code = '{0}' 
                                                                order by m.view_order",
                code.Value), CommandType.Text, null);

            foreach (DataRow row in dtResult.Rows)
            {
                var id = (int)Helper.GetColumnValue(row, "id");
                var item = result.Find(x => x.Id == id);

                if (item == null)
                {
                    item = GetEmptyProduct();
                    item.Id = id;
                    item.Code = (string)Helper.GetColumnValue(row, "code");
                    //item.NameFa = (string)Helper.GetColumnValue(row, "name_fa");
                    //item.NameEn = (string)Helper.GetColumnValue(row, "name_en");
                    item.TextFa = (string)Helper.GetColumnValue(row, "text_fa");
                    item.TextEn = (string)Helper.GetColumnValue(row, "text_en");
                    item.Count = (int)Helper.GetColumnValue(row, "count");
                    item.Price = (int)Helper.GetColumnValue(row, "price");
                    item.CoverMediaId = (int)Helper.GetColumnValue(row, "cover_media_id");

                    result.Add(item);
                }
                var mediaId = (int?)Helper.GetColumnValue(row, "media_id");
                if (mediaId != null && !item.MediaIds.Contains((int)mediaId)) item.MediaIds.Add((int)mediaId);

                var labelId = (int?)Helper.GetColumnValue(row, "label_id");
                if (labelId != null && !item.LabelIds.Contains((int)labelId)) item.LabelIds.Add((int)labelId);
            }

            return result;
        }

        [AllowAnonymous]
        public List<Product> FetchProducts(IdArray ids)
        {
            var result = new List<Product>();

            if (ids != null && ids.Ids != null && ids.Ids.Contains(-1))
            {
                result.Add(GetEmptyProduct());
                ids.Ids.Remove(-1);
            }

            if (ids == null || ids.Ids == null || ids.Ids.Count == 0) return result;

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(string.Format(@"select t.id, t.code, t.name_fa, t.name_en,
                                                                      t.cover_media_id, t.text_fa, t.text_en, t.count, t.price
                                                                 From product t
                                                                where t.id in ({0})
                                                                order by t.id desc",
                string.Join(",", ids.Ids)), CommandType.Text, null);

            result.AddRange(DataTableToProductList(dtResult));

            //To prevent continuos requesting data that is actually not exist.
            foreach (var id in ids.Ids)
            {
                var item = result.Find(x => x.Id == id);
                if (item == null)
                {
                    item = GetEmptyProduct();
                    item.Id = id;
                    result.Add(item);
                }
            }

            return result;
        }

        [AllowAnonymous]
        public List<Product> FetchOlderProducts(Page page)
        {
            var lastId = page.Id;

            var db = new DbProvider();
            //var dtResult = db.ExecuteDataTable(string.Format(@"select top 15 t.id, t.code, t.cover_media_id, t.count, t.price
            //                                       From product t {0}
            //                                      where @lastId < 0 or t.id < @lastId
            //                                      order by t.id desc", page.LabelId > 0 ? "join product_label_values pl on pl.product_id = t.id and pl.label_id = @label_id and pl.value_en = @label_value" : string.Empty), CommandType.Text,
            //                                      new SqlParameter[] {
            //                                            new SqlParameter("@lastId", lastId),
            //                                            new SqlParameter("@label_id", page.LabelId),
            //                                            new SqlParameter("@label_value", page.LabelValue ?? string.Empty)
            //                                      });
            var dtResult = db.ExecuteDataTable(string.Format(@"select * From (
                                                                select ROW_NUMBER() OVER(ORDER BY q.idate desc) AS id, q.code, q.cover_media_id 
                                                                  from (
                                                                        select t.code, t.idate, t.cover_media_id, 
                                                                               ROW_NUMBER() OVER (PARTITION BY t.code ORDER BY l.view_order) AS rn 
                                                                          from product t
                                                                          left join product_labels pl on t.id = pl.product_id
                                                                          left join label l on l.id = pl.label_id {1}
                                                                   ) q
                                                                where q.rn = 1) qq
                                                                where qq.id > {0} and qq.id <= ({0} + 15)
                                                                order by qq.id", lastId, string.IsNullOrEmpty(page.KeyCode) ? string.Empty :
                                                                                    string.Format("where l.keycode = '{0}'", page.KeyCode)),
                                                                CommandType.Text, null);

            return DataTableToProductList(dtResult);
        }

        //public List<Product> FetchNewerProducts(Page page)
        //{
        //    var firstId = page.Id;

        //    var db = new DbProvider();
        //    var dtResult = db.ExecuteDataTable(string.Format(@"select top 10 t.id, t.code, t.cover_media_id, t.count, t.price
        //                                           From product t {0}
        //                                        where @firstId < 0 or t.id > @firstId 
        //                                        order by t.id desc", page.LabelId > 0 ? "join product_label_values pl on pl.product_id = t.id and pl.label_id = @label_id and pl.value_en = @label_value" : string.Empty), CommandType.Text,
        //                                          new SqlParameter[] {
        //                                                new SqlParameter("@firstId", firstId),
        //                                                new SqlParameter("@label_id", page.LabelId),
        //                                                new SqlParameter("@label_value", page.LabelValue != null ? (object)page.LabelValue : DBNull.Value)
        //                                          });

        //    return DataTableToProductList(dtResult);
        //}

        [AllowAnonymous]
        public async Task<HttpResponseMessage> DoPurchase(Purchase purchase)
        {
            if (!AccountController.CheckCaptcha(purchase.Captcha))
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = "The captcha text is incorrect." });
            }

            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                var dt = db.ExecuteDataTable(@"insert into purchase 
                            (product_id, customer_name, customer_phone, customer_email, customer_address, description) 
                            OUTPUT Inserted.id 
                            values(@product_id, @customer_name, @customer_phone, @customer_email, @customer_address, @description)", CommandType.Text, new SqlParameter[] {
                            new SqlParameter("@product_id", purchase.ProductId),
                            new SqlParameter("@customer_name", purchase.CustomerName),
                            new SqlParameter("@customer_phone", purchase.CustomerPhone),
                            new SqlParameter("@customer_email", (object)purchase.CustomerEmail ?? DBNull.Value),
                            new SqlParameter("@customer_address", purchase.CustomerAddress),
                            new SqlParameter("@description", (object)purchase.Description ?? DBNull.Value)
                        });
                if (dt.Rows.Count == 0) { throw new Exception("Could not insert the purchase!"); }
                purchase.Id = (int)dt.Rows[0][0];

                db.Commit();
                return Request.CreateResponse(HttpStatusCode.OK, purchase.Id);//TODO: کد رهگیری
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [AllowAnonymous]
        public async Task<HttpResponseMessage> SendEmail(IntType id)
        {
            var db = new DbProvider();
            db.BeginTransaction();
            try
            {
                var purchaseId = id.Value;

                var dtResult = db.ExecuteDataTable(string.Format(@"select t.id, t.product_id, t.customer_name, t.customer_phone, t.customer_email, t.customer_address, t.[description],
                                                                          p.code, p.price, q.name_en, q.name_fa, t.idate
                                                                     From purchase t 
                                                                     join product p on t.product_id = p.id
                                                                     left join (select pl.product_id, l.keycode, l.name_en, l.name_fa
	     	                                                                      from product_labels pl 
			                                                                      join label l on pl.label_id = l.id and l.master_keycode = 'material') q on q.product_id = p.id 
                                                                    where t.id = {0}", purchaseId), CommandType.Text, null);

                var row = dtResult.Rows[0];
                var email = Helper.GetColumnValue(row, "customer_email");
                var customerEmail = (email == null) ? null : email.ToString();
                var customerName = (string)Helper.GetColumnValue(row, "customer_name");
                var customerPhone = (string)Helper.GetColumnValue(row, "customer_phone");
                var customerAddress = (string)Helper.GetColumnValue(row, "customer_address");
                var description = Helper.GetColumnValue(row, "description");
                var customerDescription = (description == null) ? null : description.ToString();
                var productCode = (string)Helper.GetColumnValue(row, "code");
                var price = (int)Helper.GetColumnValue(row, "price");
                var materialNameFa = (string)Helper.GetColumnValue(row, "name_fa");
                var materialNameEn = (string)Helper.GetColumnValue(row, "name_en");
                var purchaseDate = (DateTime)Helper.GetColumnValue(row, "idate");

                var myEmail = "sale@far-gallery.com";
                var subject = string.Format("خرید از فرگالری - کد رهگیری: {0}", purchaseId);
                var body = "<div style='direction: rtl'><h3>مشخصات محصول:</h3><p>{0} - {1}</p><p>{2} تومان</p><p>کد رهگیری: {3}</p><p>{4} - {5}</p><h3>مشخصات خریدار:</h3><p>{6}</p><p>{7}</p><p>{8}</p><p>{9}</p><p>{10}</p></div>";
                var message = new MailMessage();
                if (!string.IsNullOrEmpty(customerEmail))
                {
                    message.To.Add(new MailAddress(customerEmail));  // replace with valid value 
                }
                message.To.Add(new MailAddress("sale@far-gallery.com"));  // replace with valid value 
                message.From = new MailAddress(myEmail);  // replace with valid value
                message.Subject = subject;
                message.Body = string.Format(body, productCode, materialNameFa, price, purchaseId, purchaseDate.ToPersianDate(), purchaseDate.ToShortTimeString(), customerName, customerPhone, customerAddress, customerEmail, customerDescription);
                message.IsBodyHtml = true;

                using (var smtp = new SmtpClient("mail.far-gallery.com"))
                {
                    var credential = new NetworkCredential
                    {
                        UserName = myEmail,  // replace with valid value
                        Password = "sa1eP@ss"  // replace with valid value
                    };
                    smtp.Credentials = credential;
                    await smtp.SendMailAsync(message);
                }

                return Request.CreateResponse(HttpStatusCode.OK, purchaseId);
            }
            catch (Exception ex)
            {
                db.Rollback();
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }
    }
}
