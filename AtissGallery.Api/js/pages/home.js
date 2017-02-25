function Home() {
    var self = this;
    var TempBanners = [];

    self.PageBannerIds = [];

    self.init = function () {
        appCommon.fetchModules(['banner']);

        var pageId = $('.atiss-home').attr('page-id');

        $.get("/api/Banner/GetPageBanners/" + pageId)
            .done(function (data) {
                TempBanners = data;
                loadBanners();
            })
            .fail(function (data) {
                debugger;
                alert("home.getPageBanners() Fail: " + data.message);
            });

        $(document).off('scroll');
    };

    var loadBanners = function () {
        if (!window['banner']) {
            setTimeout(loadBanners, 100);
            return;
        }

        for (var i = 0; i < TempBanners.length; i++) {
            home.PageBannerIds.push(TempBanners[i].Id);
            window['banner'].Banners[TempBanners[i].Id] = TempBanners[i];
        }

        appCommon.evalBindings('.atiss-home');
    }

    self.init();

    return self;
}

var home = new Home();

var _pageTitle = Strings('brand-title');// + ' - ' + strings('menu-home');
