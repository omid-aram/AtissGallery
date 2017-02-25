function Admin() {
    var self = this;

    self.init = function () {
        //debugger;
        if (!app.user.isAuthenticated) {
            appCommon.gotoLoginPage();
            return;
        }

        var adminPage = appCommon.getQueryStrings()['p1'] || 'Panel';
        var relatedPage = 'pages/admin/admin' + adminPage + '.html';
        //alert(relatedPage);

        appCommon.loadHtml('.atiss-admin', relatedPage);

        //appCommon.recheckAllElements();

        $(document).off('scroll');
    }

    app.checkAuthentication(self.init);

    return self;
}

var admin = new Admin();

var _pageTitle = Strings('brand-title') + ' - ' + Strings('admin-control-panel');

//appCommon.evalBindings('.atiss-admin');