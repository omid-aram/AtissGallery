using AtissGallery.Api.Entities;
using AtissGallery.Api.Providers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Web.Http;

namespace AtissGallery.Api.Controllers
{
    [Authorize]
    [RoutePrefix("api/Account")]
    public class AccountController : ApiController
    {
        // GET api/Account/UserInfo
        [Route("UserInfo")]
        public User GetUserInfo()
        {
            return new User
            {
                Id = 1,
                UserName = ((ClaimsIdentity)User.Identity).FindFirst(ClaimTypes.Name).Value,
                FullName = ((ClaimsIdentity)User.Identity).FindFirst(ClaimTypes.GivenName).Value
            };
        }

        public HttpResponseMessage ChangePassword(User user)
        {
            var db = new DbProvider();
            try
            {
                db.ExecuteNonQuery("Update [user] set password = @password where username = @username", CommandType.Text,
                    new SqlParameter[] {
                    new SqlParameter("@username", user.UserName),
                    new SqlParameter("@password", user.FullName)
                });
                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [AllowAnonymous]
        public HttpResponseMessage GenerateCaptcha()
        {
            var db = new DbProvider();
            try
            {
                System.Drawing.FontFamily family = new System.Drawing.FontFamily("Arial");
                CaptchaImage img = new CaptchaImage(150, 50, family);
                string text = img.CreateRandomText(6);// + " " + img.CreateRandomText(3);
                img.SetText(text);
                img.GenerateImage();

                var dt = db.ExecuteDataTable(string.Format("insert into captcha (text) OUTPUT Inserted.id values('{0}')", text), CommandType.Text, null);
                if (dt.Rows.Count == 0) { throw new Exception("Could not insert new captcha!"); }
                var id = (int)dt.Rows[0][0];

                using (MemoryStream ms = new MemoryStream())
                {
                    img.Image.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    HttpResponseMessage result = Request.CreateResponse(HttpStatusCode.OK, new { id = id, image = Convert.ToBase64String(ms.ToArray()) });
                    result.Content.Headers.ContentType = new MediaTypeHeaderValue("application/octet-stream");
                    return result;
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.InternalServerError, new { message = Helper.GetInnerestException(ex) });
            }
        }

        [AllowAnonymous]
        public static bool CheckCaptcha(KeyValuePair<int, string> captcha)
        {
            var db = new DbProvider();
            try
            {
                var dtResult = db.ExecuteDataTable(@"select * from captcha t where t.id = @captchaId and t.text = @captchaText and t.idate > getdate()-0.01", CommandType.Text,
                    new SqlParameter[] {
                        new SqlParameter("@captchaId", captcha.Key),
                        new SqlParameter("@captchaText", captcha.Value)
                    });

                if (dtResult != null && dtResult.Rows.Count > 0)
                {
                    return true;
                }
            }
            catch (Exception ex)
            {

            }
            return false;
        }
    }
}
