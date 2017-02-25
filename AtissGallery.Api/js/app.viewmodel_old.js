function AppViewModel(dataModel, ver) {
    // Private state
    var self = this;

    if (!ver) ver = '1.0';

    var isHistoryBinded = false;

    var myLoadQueue = {},
        isAllQueued = false,
        _mainPage = 'home',
        _lang = 'fa',
        _hrefPrefix = '';

    // Private operations
    function cleanUpLocation() {
        window.location.hash = "";

        if (typeof (history.pushState) !== "undefined") {
            history.pushState("", document.title, location.pathname);
        }
    }
    // Data
    self.Views = {
        Loading: {} // Other views are added dynamically by app.addViewModel(...).
    };
    self.dataModel = dataModel;

    // UI state
    self.view = ko.observable(self.Views.Loading);

    self.loading = ko.computed(function () {
        return self.view() === self.Views.Loading;
    });

    // UI operations

    // Other navigateToX functions are added dynamically by app.addViewModel(...).

    // Other operations
    self.addViewModel = function (options) {
        var viewItem = new options.factory(self, dataModel),
            navigator;

        // Add view to AppViewModel.Views enum (for example, app.Views.Home).
        self.Views[options.name] = viewItem;

        // Add binding member to AppViewModel (for example, app.home);
        self[options.bindingMemberName] = ko.computed(function () {
            if (!dataModel.getAccessToken()) {
                // The following code looks for a fragment in the URL to get the access token which will be
                // used to call the protected Web API resource
                var fragment = common.getFragment();

                if (fragment.access_token) {
                    // returning with access token, restore old hash, or at least hide token
                    window.location.hash = fragment.state || '';
                    dataModel.setAccessToken(fragment.access_token);
                } else {
                    // no token - so bounce to Authorize endpoint in AccountController to sign in or register
                    //window.location = "/Account/Authorize?client_id=web&response_type=token&state=" + encodeURIComponent(window.location.hash);
                }
            }

            return self.Views[options.name];
        });

        if (typeof (options.navigatorFactory) !== "undefined") {
            navigator = options.navigatorFactory(self, dataModel);
        } else {
            navigator = function () {
                window.location.hash = options.bindingMemberName;
            };
        }

        // Add navigation member to AppViewModel (for example, app.NavigateToHome());
        self["navigateTo" + options.name] = navigator;
    };

    self.user = ko.observable(new User());
    self.strings = function (value) { return Strings(value); };

    var plusVersion = function (url) {
        return url + (url.indexOf('?') < 0 ? '?' : '&') + 'ver=' + ver;
    };

    var setLoadQueue = function (url, isLoaded) {
        myLoadQueue[url] = isLoaded;

        checkAllLoaded();
    };

    var checkAllLoaded = function () {
        if (!isAllQueued) return;

        for (var key in myLoadQueue) {
            if (!myLoadQueue[key]) return;
        }

        myLoadQueue = {};

        self.documentReady();

        //All Files loaded
        $('.loading-panel-fill').fadeOut();
        $('.loading-panel').fadeOut();
    };

    self.loadMainPage = function () {
        $('.loading-panel').show();
        $('.main-container').hide();
        evalMainPageLang();
        self.loadHtml('.main-container', plusVersion('pages/' + _mainPage), function () {
            $('html title').text(_pageTitle);
            $('.main-container').css('min-height', $(window).height() - $('.header-container').height() - $('.footer-container').height());
            $('.main-container').fadeIn();
        });
    };

    self.enqueueImage = function (selector) {
        var img = $(selector);
        setLoadQueue(img.src, false);

        img.load(function () {
            setLoadQueue(img.src, true);
        })
    };

    self.enqueueAllImages = function (container) {
        var imgs = $(container).find('img');
        for (var i = 0; i < imgs.length; i++) {
            self.enqueueImage(imgs[i]);
        }
    };

    self.getQueryStrings = function () {
        var vars = [], hash;
        var hashes = _mainPage.slice(_mainPage.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    };

    self.goHome = function () {
        window.location = "";
    };

    var evalMainPageLang = function () {
        _mainPage = '';
        var queryString = '';
        var pathName = window.location.pathname;
        var baseUrl = $('base').attr('href');
        //removing the last slash
        baseUrl = baseUrl.substr(0, baseUrl.length - 1);
        var parts = $.trim(pathName.replace(baseUrl, '').replace(/\//g, " ")).split(' ');
        if (parts) {
            pi = 0;
            for (var i = 0; i < parts.length; i++) {
                if (i == 0) {
                    switch (parts[0]) {
                        case 'fa':
                        case 'en':
                            _lang = parts[0];
                            if (parts.length > 1) {
                                _mainPage = parts[1];
                                i++;
                            }
                            _hrefPrefix = _lang + '/';
                            break;
                        default:
                            _hrefPrefix = '';
                            _mainPage = parts[0];
                            break;
                    }
                }
                else queryString += '&p' + (++pi) + '=' + parts[i];
            }
            if (queryString) queryString = '?' + queryString.substr(1);
        }

        if (!_mainPage) _mainPage = 'home';
        _mainPage += '.html' + queryString;

        self.setLanguage();
    };

    self.setLanguage = function () {
        $('html').attr('lang', _lang);
        $('html').attr('xml:lang', _lang);
        $('html').attr('dir', _lang == 'fa' ? 'rtl' : 'ltr');
        $('body').addClass(_lang == 'fa' ? 'bx-rtl' : 'bx-ltr');
    };

    self.getLanguage = function () {
        return _lang;
    };

    self.getMainPage = function () {
        return _mainPage;
    };

    self.loadHtml = function (container, url, callback) {
        var key = url + container;
        if (myLoadQueue[key] != null) return;
        setLoadQueue(key, false);
        $(container).load(url, function () {
            if (_hrefPrefix) {
                $(container).find('a').each(function (i) {
                    var href = $(this).attr('href');
                    if (href) {
                        $(this).attr('href', _hrefPrefix + href);
                    }
                });
            }
            setLoadQueue(key, true);
            if (callback) callback();
        });
    };

    self.initialize = function () {
        Sammy().run();

        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/normalize.css'));
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/font-awesome.min.css'));
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/atiss.css'));

        evalMainPageLang();

        self.loadHtml('.header-container', plusVersion('pages/modules/_header.html'));
        self.loadHtml('.footer-container', plusVersion('pages/modules/_footer.html'));
        self.loadHtml('.usermenu-container', plusVersion('pages/modules/_usermenu.html'));

        self.loadMainPage();

        isAllQueued = true;

        checkAllLoaded();
    }

    self.documentReady = function () {

        if (!isHistoryBinded) {

            // Activate Knockout
            ko.validation.init({ grouping: { observable: false } });
            ko.applyBindings(app);

            History.Adapter.bind(window, 'statechange', function () {
                isHistoryBinded = true;
                var State = History.getState();
                //History.log(State.data, State.title, State.url);

                self.loadMainPage();
            });
        }

        $('a').on('click', function (e) {
            e.preventDefault();
            var url = $(this).attr('href');
            if (!url) return;
            //alert(url);
            //var title = $(this).attr('title');
            var title = Strings('brand-title') + ' - ' + $(this).text();
            History.pushState({ data: title }, title, url);
        });

    };

    return self;
}

var app = new AppViewModel(new AppDataModel(), 1.62);

function User() {
    this.isAuthenticated = ko.observable(true);
    this.fullName = ko.observable('مینا جودی');
    this.firstName = ko.observable('مینا');
}
