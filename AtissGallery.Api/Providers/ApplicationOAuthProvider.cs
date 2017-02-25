using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.Cookies;
using Microsoft.Owin.Security.OAuth;
using AtissGallery.Api.Models;
using AtissGallery.Api.Entities;
using System.Data.SqlClient;
using System.Data;
using AtissGallery.Api.Controllers;

namespace AtissGallery.Api.Providers
{
    public class ApplicationOAuthProvider : OAuthAuthorizationServerProvider
    {
        private readonly string _publicClientId;

        public ApplicationOAuthProvider(string publicClientId)
        {
            if (publicClientId == null)
            {
                throw new ArgumentNullException("publicClientId");
            }

            _publicClientId = publicClientId;
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            User user = null;
            var array = context.UserName.Split('|');
            var userName = array[0];
            var captchaId = int.Parse(array[1]);
            var captchaText = array[2];

            if (!AccountController.CheckCaptcha(new KeyValuePair<int, string>(captchaId, captchaText)))
            {
                context.SetError("wrong_captcha", "The captcha text is incorrect.");
                return;
            }

            var db = new DbProvider();
            var dtResult = db.ExecuteDataTable(@"select u.id, u.fullname From [user] u where u.enabled = 1 and u.username = @username and u.password = @password", CommandType.Text,
                new SqlParameter[] {
                    new SqlParameter("@username", userName),
                    new SqlParameter("@password", context.Password)
                });

            if (dtResult != null && dtResult.Rows.Count > 0)
            //if (context.UserName.ToLower() == "admin" && context.Password == "F@r@Dmin95")
            {
                var row = dtResult.Rows[0];
                user = new User
                {
                    Id = (int)Helper.GetColumnValue(row, "id"),
                    UserName = context.UserName,
                    FullName = (string)Helper.GetColumnValue(row, "fullname")
                };

                db.ExecuteNonQuery(string.Format(@"Update [user] set last_seen = getdate() where id = {0}", user.Id), CommandType.Text, null);
            }

            if (user == null)
            {
                context.SetError("invalid_grant", "The user name or password is incorrect.");
                return;
            }

            ClaimsIdentity oAuthIdentity = new ClaimsIdentity(OAuthDefaults.AuthenticationType);
            oAuthIdentity.AddClaim(new Claim(ClaimTypes.Name, user.UserName));
            oAuthIdentity.AddClaim(new Claim(ClaimTypes.GivenName, user.FullName));
            //ClaimsIdentity oAuthIdentity = await user.GenerateUserIdentityAsync(userManager, OAuthDefaults.AuthenticationType);
            //ClaimsIdentity cookiesIdentity = await user.GenerateUserIdentityAsync(userManager, CookieAuthenticationDefaults.AuthenticationType);

            AuthenticationProperties properties = CreateProperties(user.UserName);
            AuthenticationTicket ticket = new AuthenticationTicket(oAuthIdentity, properties);
            context.Validated(ticket);
            //context.Request.Context.Authentication.SignIn(cookiesIdentity);
        }

        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            // Resource owner password credentials does not provide a client ID.
            if (context.ClientId == null)
            {
                context.Validated();
            }

            return Task.FromResult<object>(null);
        }

        public override Task ValidateClientRedirectUri(OAuthValidateClientRedirectUriContext context)
        {
            if (context.ClientId == _publicClientId)
            {
                Uri expectedRootUri = new Uri(context.Request.Uri, "/");

                if (expectedRootUri.AbsoluteUri == context.RedirectUri)
                {
                    context.Validated();
                }
            }

            return Task.FromResult<object>(null);
        }

        public static AuthenticationProperties CreateProperties(string userName)
        {
            IDictionary<string, string> data = new Dictionary<string, string>
            {
                { "userName", userName }
            };
            return new AuthenticationProperties(data);
        }
    }
}