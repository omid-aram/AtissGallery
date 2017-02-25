$(function () {
    app.initialize();

    //// Activate Knockout
    //ko.validation.init({ grouping: { observable: false } });
    //ko.applyBindings(app);

    //var isHistoryBinded = false;

    //if (!isHistoryBinded) {
    //    History.Adapter.bind(window, 'statechange', function () {
    //        isHistoryBinded = true;
    //        var State = History.getState();
    //        //History.log(State.data, State.title, State.url);

    //        appCommon.loadMainPage();
    //    });
    //}

    //$('a').on('click', function (e) {
    //    e.preventDefault();
    //    var url = $(this).attr('href');
    //    if (!url) return;
    //    //alert(url);
    //    //var title = $(this).attr('title');
    //    var title = Strings('brand-title') + ' - ' + $(this).text();
    //    History.pushState({ data: title }, title, url);
    //});
});
