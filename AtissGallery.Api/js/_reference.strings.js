function Strings(value) {
    var lang = appCommon.getLanguage();

    //alert(lang + ' - ' + value);

    switch (value.toLowerCase()) {
        case 'farsi': return 'فارسی';
        case 'english': return 'English'

        case 'control-panel': if (lang == 'en') return 'Control Panel'; return 'کنترل پنل مدیریت';
        case 'username': if (lang == 'en') return 'User Name'; return 'کد کاربری';
        case 'password': if (lang == 'en') return 'Password'; return 'کلمه عبور';
        case 'change-password': if (lang == 'en') return 'Change Password'; return 'تغییر کلمه عبور';
        case 'password-new': if (lang == 'en') return 'New Password'; return 'کلمه عبور جدید';
        case 'password-renew': if (lang == 'en') return 'Repeat New Password'; return 'تکرار کلمه عبور جدید';
        case 'login': if (lang == 'en') return 'Log In'; return 'ورود';
        case 'logout': if (lang == 'en') return 'Log Out'; return 'خروج';

        case 'support-phone': if (lang == 'en') return 'Support Phone'; return 'مشاوره و پشتیبانی';
        case 'brand-title': if (lang == 'en') return 'Far Gallery'; return 'فر گالری';
        case 'search': if (lang == 'en') return 'Search'; return 'جستجو';
        case 'admin-control-panel': if (lang == 'en') return 'Admin Control Panel'; return 'کنترل پنل مدیریت';
        case 'menu-home': if (lang == 'en') return 'Main Page'; return 'صفحه اصلی';
        case 'menu-collections': if (lang == 'en') return 'Collections'; return 'مجموعه ها';
        case 'menu-products': if (lang == 'en') return 'Products'; return 'محصولات';
        case 'menu-books': if (lang == 'en') return 'Season Book'; return 'کتاب فصل';
        case 'menu-blog': if (lang == 'en') return 'Blog'; return 'بلاگ';
        case 'menu-about': if (lang == 'en') return 'About Atiss Gallery'; return 'درباره گالری آتیس';

            /// media-editor            
        case 'file-uploader': if (lang == 'en') return 'File Uploader...'; return 'بارگذاری فایل...';
        case 'media-editor': if (lang == 'en') return 'Media Editor...'; return 'ویرایشگر تصاویر...';
        case 'media-address': if (lang == 'en') return 'Media Address'; return 'آدرس تصویر';
        case 'media-select': if (lang == 'en') return 'Media Select'; return 'انتخاب تصویر';            
        case 'text-width': if (lang == 'en') return 'Text Width'; return 'عرض متن';
        case 'text-position': if (lang == 'en') return 'Text Position'; return 'موقعیت متن';
        case 'text-en': if (lang == 'en') return 'English Text'; return 'متن انگلیسی';
        case 'text-fa': if (lang == 'en') return 'Farsi Text'; return 'متن فارسی';
        case 'text-editor': if (lang == 'en') return 'Text Editor...'; return 'ویرایشگر متن...';
        case 'back-color': if (lang == 'en') return 'Back Color'; return 'رنگ زمینه';
        case 'href-link': if (lang == 'en') return 'Link'; return 'لینک';
            
            /// media-selector
        case 'media-selector': if (lang == 'en') return 'Media Selector'; return 'انتخاب تصویر...';

            /// banner-editor
        case 'banner-editor': if (lang == 'en') return 'Banner Editor'; return 'ویرایش بنر';
        case 'banner-type': if (lang == 'en') return 'Banner Type'; return 'نوع بنر';
        case 'banner-single': if (lang == 'en') return 'Banner Single'; return 'بنر تک';
        case 'banner-double-sf': if (lang == 'en') return 'Banner Double - Square First'; return 'بنر دوتایی - مربع مستطیل';
        case 'banner-double-ss': if (lang == 'en') return 'Banner Double - Square Second'; return 'بنر دوتایی - مستطیل مربع';
        case 'banner-double-eq': if (lang == 'en') return 'Banner Double - Equal'; return 'بنر دوتایی - برابر';
        case 'banner-triple-eq': if (lang == 'en') return 'Banner Triple - Equal'; return 'بنر سه تایی - برابر';
        case 'first-media': if (lang == 'en') return 'First Media'; return 'تصویر اول';
        case 'second-media': if (lang == 'en') return 'Second Media'; return 'تصویر دوم';
        case 'third-media': if (lang == 'en') return 'Third Media'; return 'تصویر سوم';
        case 'page-banner-management': if (lang == 'en') return 'Page Banner Management'; return 'مدیریت بنرهای صفحه';
        case 'enabled': if (lang == 'en') return 'Enabled'; return 'فعال';
        case 'disabled': if (lang == 'en') return 'Disabled'; return 'غیر فعال';

            /// collection-editor
        case 'collection-editor': if (lang == 'en') return 'Collection Editor...'; return 'ویرایشگر مجموعه...';
        case 'header-media': if (lang == 'en') return 'Header Media'; return 'تصویر اصلی';
        case 'cover-media': if (lang == 'en') return 'Cover Media'; return 'تصویر کاور';
        case 'collection-name': if (lang == 'en') return 'Collection Name'; return 'نام مجموعه';
        case 'collection': if (lang == 'en') return 'Collection'; return 'مجموعه';

            /// product-editor
        case 'new-product': if (lang == 'en') return 'New Product'; return 'محصول جدید';
        case 'product-editor': if (lang == 'en') return 'Product Editor...'; return 'ویرایشگر محصولات...';
        case 'product-name': if (lang == 'en') return 'Product Name'; return 'نام محصول';
        case 'product-code': if (lang == 'en') return 'Product Code'; return 'کد محصول';
        case 'product-price': if (lang == 'en') return 'Price'; return 'قیمت';
        case 'product-count': if (lang == 'en') return 'Count'; return 'تعداد موجود';
        case 'price-unit': if (lang == 'en') return 'Toman'; return 'تومان';
        case 'other-medias': if (lang == 'en') return 'Other Medias'; return 'سایر تصاویر';
        case 'description': if (lang == 'en') return 'Description'; return 'توضیحات';
        case 'material': if (lang == 'en') return 'Material'; return 'جنس';
        case 'name-family': if (lang == 'en') return 'Name & Surname'; return 'نام و نام خانوادگی';
        case 'tel': if (lang == 'en') return 'Phone Number'; return 'شماره تماس';
        case 'email': if (lang == 'en') return 'Email'; return 'ایمیل';
        case 'address': if (lang == 'en') return 'Post Address'; return 'آدرس پستی';

            /// label-editor
        case 'label-management': if (lang == 'en') return 'Label Management'; return 'مدیریت برچسب ها';
        case 'label-editor': if (lang == 'en') return 'Label Editor...'; return 'ویرایشگر برچسب ها...';
        case 'keycode': if (lang == 'en') return 'KeyCode'; return 'کد کلید';
        case 'master-keycode': if (lang == 'en') return 'Master KeyCode'; return 'کد دسته';

            /// menu-editor
        case 'menu-management': if (lang == 'en') return 'Menu Management'; return 'مدیریت منوها';
        case 'main-menus': if (lang == 'en') return 'Main Menus'; return 'منوهای اصلی';
        case 'help-links': if (lang == 'en') return 'Help Links'; return 'لینک های کمکی';
        case 'social-networks': if (lang == 'en') return 'Social Networks'; return 'شبکه های اجتماعی';
        case 'col-no': if (lang == 'en') return 'Column No.: '; return 'شماره ستون : ';
        case 'link-address': return 'Link Address';

            /// buttons
        case 'button-ok': if (lang == 'en') return 'Ok'; return 'تایید';
        case 'button-cancel': if (lang == 'en') return 'Cancel'; return 'انصراف';
        case 'button-add': if (lang == 'en') return 'Add'; return 'ایجاد';
        case 'button-remove': if (lang == 'en') return 'Remove'; return 'حذف';
        case 'button-close': if (lang == 'en') return 'Close'; return 'بستن';
        case 'purchase-order': if (lang == 'en') return 'Purchase Order'; return 'سفارش خرید';
        case 'purchase': if (lang == 'en') return 'Purchase'; return 'ثبت سفارش';

        default:
            return value;
    }
}
