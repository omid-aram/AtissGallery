function TextEditor() {
    var self = this;

    if (!app.user.isAuthenticated) {
        appCommon.goHome();
    };

    self.contentElement = null;

    var dialogSelector = '#textEditorDialog';

    self.init = function () {
        //appCommon.fetchModules(['textEditor', 'fileUploader']);
    }

    self.checkModule = function (sender) {
        $(sender).attr('data-checked', 'true');
    };

    self.showDialog = function (sender, event) {
        //debugger;
        appCommon.evalBindings(dialogSelector);

        var module = $(sender).parents('[module = "textEditor"]');
        var bodyClass = module.attr('adding-class');
        var contentSelector = module.attr('content-selector');
        if (contentSelector) {
            self.contentElement = module.parent().find(contentSelector);

            if (self.contentElement.length) {

                if (tinyMCE && tinyMCE.activeEditor) {
                    tinyMCE.activeEditor.setContent(self.contentElement.html());
                } else {
                    $(dialogSelector).find('#mytextarea').html(self.contentElement.html());

                    tinymce.init({
                        selector: dialogSelector + ' #mytextarea',
                        body_class: bodyClass,
                        //plugins: 'autolink link image media lists textcolor colorpicker ',
                        //toolbar: 'undo redo | alignleft aligncenter alignright alignjustify | bold italic | fontsizeselect | forecolor backcolor | link image',
                        plugins: ['autolink lists link image hr pagebreak',
                                  'searchreplace wordcount visualblocks visualchars code',
                                  'media nonbreaking table contextmenu',
                                  'paste textcolor colorpicker textpattern imagetools'
                        ],
                        toolbar: 'undo redo | styleselect | bold italic | bullist numlist outdent indent | forecolor backcolor',
                        menubar: 'edit insert view table tools',
                        content_css: ['/html/css/barfix.css', '/html/css/atiss.css'],
                        textcolor_cols: "4",
                        textcolor_rows: "3",
                        textcolor_map: [
                            "662677", "#662677",
                            "0092AE", "#0092AE",
                            "C7C4B3", "#C7C4B3",
                            "D2BAC6", "#D2BAC6",
	                        "000000", "Black",
                            "800000", "Maroon",
                            "008000", "Green",
                            "FFCC00", "Gold",
	                        "333399", "Indigo",
                            "FF0000", "Red",
                            "999999", "Medium gray",
                        ],
                        theme_concrete_text_colors: "436EB2,3CB54B,3b2315,ffffff,000000",
                        init_instance_callback: function () { setTimeout(textEditor.setEditorHeight, 100); },
                        setup: function (ed) {
                            ed.on('keyup', function (e) {
                                textEditor.setEditorHeight();
                            });
                            ed.on('change', function (e) {
                                textEditor.setEditorHeight();
                            });
                        }
                    });
                }
                var iframe = $(dialogSelector).find('iframe');
                var ibody = iframe.contents().find('#tinymce');
                if (ibody.length) {
                    ibody.attr('class', '');
                    ibody.addClass('mce-content-body ' + bodyClass);
                }
                appCommon.showDialog(dialogSelector, event);
                textEditor.setEditorHeight();
            }
        }
    };

    self.setEditorHeight = function () {
        var menubarHeight = $('#textEditorDialog .mce-menubar').height();
        var toolbarHeight = $('#textEditorDialog .mce-toolbar-grp').height();
        var statusbarHeight = $('#textEditorDialog .mce-statusbar').height();
        var dialogBodyHeight = $('#textEditorDialog .popup-dialog-body').height();

        $('#textEditorDialog #mytextarea_ifr').height(dialogBodyHeight - (menubarHeight + toolbarHeight + statusbarHeight + 10));
    };

    self.ok = function (sender) {
        if (self.contentElement && self.contentElement.length) {
            self.contentElement.html(tinyMCE.activeEditor.getContent());
            self.contentElement.trigger("change");
        }
        self.cancel(sender);
    }

    self.cancel = function (sender) {
        self.contentElement = null;
        appCommon.closeDialog(sender);
    }

    return self;
}

var textEditor = new TextEditor();

//appCommon.evalBindings('#textEditorDialog');