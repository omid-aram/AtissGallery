using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;

namespace AtissGallery.Api.Providers
{
    public static class Helper
    {
        public static string GetInnerestException(Exception ex)
        {
            return (ex.InnerException == null) ? ex.Message : GetInnerestException(ex.InnerException);
        }

        public static object GetColumnValue(DataRow row, string columnName)
        {
            return row[columnName] is DBNull ? null : row[columnName];
        }

        public static string ToPersianDate(this DateTime date)
        {
            var pCalendar = new PersianCalendar();
            var pYear = pCalendar.GetYear(date);
            var pMonth = pCalendar.GetMonth(date);
            var pDay = pCalendar.GetDayOfMonth(date);
            return string.Format("{0}/{1}/{2}", pYear, pMonth, pDay);
        }
    }
}