function MediaEditor() {
    var self = this;

    if (!app.user.isAuthenticated) {
        appCommon.goHome();
    }

    //appCommon.loadModules('mediaEditor', '#mediaEditorDialog');

    self.Media = {};
    self.refElement;
    self.callback = null;

    var dialogSelector = '#mediaEditorDialog';

    self.init = function () {
        appCommon.fetchModules(['textEditor', 'fileUploader']);
    }

    self.checkModule = function (sender) {
        $(sender).attr('data-checked', 'true');
    };

    self.showDialog = function (sender, event, callback) {
        //debugger;   
        self.callback = callback;
        self.refElement = $(sender);
        var mediaId = self.refElement.attr('media-id');
        $(dialogSelector).attr('media-id', mediaId);

        self.Media = {
            Id: -1,
            MediaFiles: [
            {
                Id: -1,
                MediaId: -1,
                FileId: -1,
                TextWidth: 40,
                BackColor: "#F4F4F4",
                File: {
                    Id: -1,
                    Address: "/html/design/no-image-slide.png",
                    Cover: "/html/design/no-image-slide.png",
                    ContentType: "image/png"
                }
            }]
        };

        if (media.Medias[mediaId]) {
            self.Media = jQuery.extend(true, {}, media.Medias[mediaId]);
        }
        appCommon.evalBindings(dialogSelector);

        $(dialogSelector).find('.tab-container [tab-selector].selected').click();

        appCommon.showDialog(dialogSelector, event);
    }

    var selectedIndex = 0;

    self.openFileUploader = function (sender, event) {
        selectedIndex = $(sender).parents('#loopItem').attr('index');
        fileUploader.showDialog(sender, event, mediaEditor.setSelectedFile)
    };

    self.setSelectedFile = function (file) {
        self.Media.MediaFiles[selectedIndex].File = file;
        self.Media.MediaFiles[selectedIndex].FileId = file.Id;
        appCommon.evalBindings(dialogSelector);
    }

    self.textWidthChange = function (sender) {
        var output = $(sender).parent().find('#volume');
        output.val($(sender).val() + '%');
    };

    self.backColorChange = function (sender) {
        appCommon.evalBack(sender);
        appCommon.evalBindings($(sender).parent());
    }

    self.add = function (sender) {
        if (self.Media.MediaFiles.length > 0) {
            self.Media.MediaFiles.push(jQuery.extend(true, {}, self.Media.MediaFiles[self.Media.MediaFiles.length - 1]));
            appCommon.evalBindings(dialogSelector);
        }
    };

    self.remove = function (sender) {
        if (self.Media.MediaFiles.length > 1) {
            var index = $(sender).parents('#loopItem').attr('index');
            self.Media.MediaFiles.splice(index, 1);
            appCommon.evalBindings(dialogSelector);
        }
    };

    self.moveUp = function (sender) {
        var index = parseInt($(sender).parents('#loopItem').attr('index'));
        if (index > 0) {
            self.Media.MediaFiles.move(index, index - 1);
            appCommon.evalBindings(dialogSelector);
        }
    };

    self.moveDown = function (sender) {
        var index = parseInt($(sender).parents('#loopItem').attr('index'));
        if (index < self.Media.MediaFiles.length - 1) {
            self.Media.MediaFiles.move(index, index + 1);
            appCommon.evalBindings(dialogSelector);
        }
    };

    self.ok = function (sender) {
        if (self.Media && self.Media.Id && self.Media.MediaFiles) {
            for (var i = 0; i < self.Media.MediaFiles.length; i++) {
                self.Media.MediaFiles[i]['ViewOrder'] = i;
            }
            $.post("/api/Media/PostMedia/", self.Media)
                .done(function (data) {
                    //alert("Success");
                    mediaEditor.Media.Id = data;
                    for (var i = 0; i < mediaEditor.Media.MediaFiles; i++) {
                        mediaEditor.Media.MediaFiles[i].MediaId = mediaEditor.Media.Id;
                    }
                    //self.refElement.attr('media-id', mediaEditor.Media.Id);

                    //refreshing media
                    if (window.media) {
                        window.media.Medias[mediaEditor.Media.Id] = mediaEditor.Media;
                    }
                    //media.refresh(mediaEditor.Media.Id);
                    appCommon.recheckElement('[module="media"][media-id=' + mediaEditor.Media.Id + ']');

                    if (self.callback) {
                        self.callback(mediaEditor.Media);
                    }

                    mediaEditor.cancel(sender);
                }).fail(function (data) {
                    debugger;
                    alert("Fail: " + JSON.stringify(data.responseText));
                });
        }
    };

    self.cancel = function (sender) {
        self.Media = {};
        appCommon.closeDialog(sender);
    };

    self.deleteMedia = function (sender) {
        if (!self.Media || self.Media.Id < 0) {
            alert('There is no media to delete.');
            return;
        }

        if (confirm('Are you sure to delete this media?')) {

            $.post("/api/Media/DeleteMedia/", self.Media)
                .done(function (data) {

                    if (self.callback) {
                        self.callback({});
                    }

                    mediaEditor.cancel(sender);

                }).fail(function (data) {
                    debugger;
                    alert("Media cannot be deleted because it is maybe in use. \n\n\nFor more detail: \n" + JSON.stringify(data.responseText));
                });
        }
    };

    //self.init = function () {
    //    //appCommon.appendActiveClasses(self);
    //    $('#mediaEditorDialog').find('.tab-container [tab-selector].selected').click();
    //}

    return self;
}

var mediaEditor = new MediaEditor();

//appCommon.evalBindings(dialogSelector);
