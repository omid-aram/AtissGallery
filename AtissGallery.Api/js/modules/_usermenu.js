function _Usermenu() {
    var self = this;

    //this.adminMenus = [
    //    { name: 'menu-home', href: 'admin/home/' },
    //    { name: 'menu-collections', href: 'admin/collections/' },
    //    { name: 'menu-products', href: 'admin/products/' },
    //    { name: 'menu-books', href: 'admin/books/' },
    //    { name: 'menu-blog', href: 'admin/blog/' },
    //    { name: 'menu-about', href: 'admin/about/' }
    //];

    self.init = function () {
        if (!app.user.isAuthenticated) {
            return;
        }

        appCommon.evalBindings('.atiss-usermenu');

        $('.authenticated-needed').show();
    }

    app.checkAuthentication(self.init);

    return self;
}

var _usermenu = new _Usermenu();

//appCommon.evalBindings('.atiss-usermenu');
