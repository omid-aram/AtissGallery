function Application() {
    var app = this;

    app.tokenKey = 'accessToken';

    //test online
    app.user = new User();
    app.Labels = [];
    app.MasterLabels = [];
    app.Menus = [];

    app.init = function () {
        $.get("/api/Label/GetLabels/")
            .done(function (data) {
                app.Labels = data;

                for (var i = 0; i < app.Labels.length; i++) {
                    var label = app.Labels[i];
                    if (label.MasterKeyCode) {
                        var masterLabel = app.MasterLabels.findItem(label.MasterKeyCode, 'KeyCode');
                        if (masterLabel) {
                            app.MasterLabels.push(masterLabel);
                            if (!masterLabel.Labels) masterLabel.Labels = [];

                            masterLabel.Labels.push(label);
                        }
                    } else {
                        var masterLabel = app.MasterLabels.findItem(label.KeyCode, 'KeyCode');
                        if (!masterLabel) {
                            app.MasterLabels.push(label);
                            label.Labels = [];
                        }
                    }
                }
            })
            .fail(function (data) {

            });

        $.get("/api/Menu/GetMenus/")
            .done(function (data) {
                app.Menus = data;

                app.drawMenus();
            })
            .fail(function (data) {

            });
    }

    app.checkAuthentication = function (callback) {
        //debugger;
        if (!app.user) {
            app.user = new User();
        }

        if (app.user.isAuthenticated) {
            if (callback) {
                callback();
            }
            return;
        }

        var token = localStorage.getItem(app.tokenKey);
        if (!app.user.isChecked && token) {
            var headers = {};
            headers.Authorization = 'Bearer ' + token;

            $.ajax({
                type: 'GET',
                url: 'api/account/userinfo',
                headers: headers
            }).done(function (data) {

                app.user.UserName = data.UserName;
                app.user.FullName = data.FullName;
                app.user.isAuthenticated = true;

                $.ajaxSetup({
                    headers: headers
                });

            }).fail(function (error) {

                app.user.UserName = null;
                app.user.FullName = 'کاربر مهمان';
                app.user.isAuthenticated = false;

            }).always(function () {
                app.user.isChecked = true;

                if (callback) {
                    callback();
                }
            });
        }
        else if (callback) {
            callback();
        }
    };

    app.logout = function () {
        localStorage.removeItem(app.tokenKey);
        appCommon.goHome();
    }

    app.drawMenus = function () {
        if (!window['_header'] || !window['_footer']) {
            setTimeout(app.drawMenus, 100);
            return;
        }

        window['_header'].init();
        window['_footer'].init();
    };

    app.init();

    return app;
};

function User() {
    this.isChecked = false;
    this.isAuthenticated = false;
    this.UserName = null;
    this.FullName = 'کاربر مهمان';
}
