function MediaSelector() {
    var self = this;

    self.TempMedias = [];

    self.firstId = -1;
    self.lastId = -1;
    self.isFetching = false;
    self.refEditingElement;

    self.callback = null;
    var dialogSelector = '#mediaSelectorDialog';

    self.init = function () {
        appCommon.fetchModules(['media', 'mediaEditor']);
    }

    self.checkModule = function (sender) {
        $(sender).attr('data-checked', 'true');
    };

    self.showDialog = function (sender, event, callback) {
        //debugger;

        self.callback = callback;

        self.initilize();

        if (self.lastId < 0) {
            self.fetchMedias();
        }

        appCommon.showDialog(dialogSelector, event);
    }

    self.checkScroll = function () {
        var dialogBody = $(dialogSelector).find(".popup-dialog-body");
        var windowHeight = dialogBody.height();
        var scrollHeight = dialogBody.get(0).scrollHeight;
        if (scrollHeight <= windowHeight || (dialogBody.scrollTop() + windowHeight) > (scrollHeight - windowHeight)) {
            mediaSelector.fetchMedias();
        }

        //appCommon.adjustDialog();
    }

    var exportFetchedMedias = function () {
        if (window.media) {
            for (var i = 0; i < self.TempMedias.length; i++) {
                var _media = self.TempMedias[i];
                window.media.Medias[_media.Id] = _media;
            }
        }
    }

    self.fetchMedias = function () {
        if (self.lastId == 0 || self.isFetching) return;

        self.isFetching = true;
        $(dialogSelector).find(".loading-image").show();

        //jQuery.support.cors = true;
        $.ajax("/api/Media/GetOlderMedias/" + self.lastId)
              .done(function (list) {
                  //debugger;
                  if (list.length == 0) {
                      self.lastId = 0;//To prevent rechecking older items when we know there is nothing!
                      return;
                  }

                  if (self.lastId < 0 || list[list.length - 1]["Id"] < self.lastId) {
                      self.lastId = list[list.length - 1]["Id"];
                  }
                  if (self.firstId < 0 || list[0]["Id"] > self.firstId) {
                      self.firstId = list[0]["Id"];
                  }
                  self.TempMedias = list;
                  exportFetchedMedias();
                  appCommon.evalBindings(dialogSelector);

                  //self.isFetching = false;

                  self.checkScroll();
              })
              .fail(function () {
                  //alert("error");
              })
              .always(function () {
                  self.isFetching = false;
                  $(dialogSelector).find(".loading-image").hide();
              });
    };

    self.getNewerMedias = function () {
        //jQuery.support.cors = true;
        $.ajax("/api/Media/GetNewerMedias/" + self.firstId)
              .done(function (medias) {
                  if (medias.length > 0) {
                      if (self.lastId < 0 || medias[medias.length - 1]["Id"] < self.lastId) {
                          self.lastId = medias[medias.length - 1]["Id"];
                      }
                      if (self.firstId < 0 || medias[0]["Id"] > self.firstId) {
                          self.firstId = medias[0]["Id"];
                      }
                  }
                  self.TempMedias = medias;
                  exportFetchedMedias();
                  appCommon.evalBindings(dialogSelector, true);
                  //appCommon.adjustDialog();
              })
              .fail(function () {
              })
              .always(function () {
              });
    };

    self.initilize = function () {
        self.TempMedias = [];

        appCommon.evalBindings(dialogSelector);

        var dialogBody = $(dialogSelector).find(".popup-dialog-body");
        dialogBody.off('scroll');
        dialogBody.on('scroll', mediaSelector.checkScroll);
    };

    self.selectMedia = function (sender) {
        var media = JSON.parse($(sender).attr('media-json'));

        if (self.callback) {
            self.callback(media);
        }

        appCommon.closeDialog(sender);
    };

    self.addMedia = function (sender, event) {
        mediaEditor.showDialog(sender, event, mediaSelector.getNewerMedias)
    };

    self.editMedia = function (sender, event) {
        self.refEditingElement = $(sender).parents('#loopItem');
        mediaEditor.showDialog(sender, event, mediaSelector.setEditedMedia);
        event.stopPropagation();
    };

    self.setEditedMedia = function (editedMedia) {
        if (editedMedia && editedMedia.Id) {
            //because we don't save the media reference for selector items we need to change it manually.
            $(self.refEditingElement).attr('media-json', JSON.stringify(editedMedia));
            $(self.refEditingElement).css('background-image', 'url(\'' + editedMedia.MediaFiles[0].File.Cover + '\')');
        } else {
            //it means the media is deleted.
            $(self.refEditingElement).parent().remove();
        }
    }

    return self;
}

var mediaSelector = new MediaSelector();
