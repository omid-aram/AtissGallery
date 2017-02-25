function FileUploader() {
    var self = this;

    self.files = [];

    self.firstId = -1;
    self.lastId = -1;
    self.isFetching = false;

    self.callback = null;

    var dialogSelector = '#fileUploaderDialog';

    self.init = function () {
        //appCommon.fetchModules(['textEditor', 'fileUploader']);
    }

    self.checkModule = function (sender) {
        $(sender).attr('data-checked', 'true');
    };

    self.showDialog = function (sender, event, callback) {
        self.callback = callback;

        self.initilize();

        if (self.lastId < 0) {
            self.fetchFiles();
        }

        appCommon.showDialog(dialogSelector, event);
    }

    self.checkScroll = function () {
        var dialogBody = $(dialogSelector).find(".popup-dialog-body");
        var windowHeight = dialogBody.height();
        var scrollHeight = dialogBody.get(0).scrollHeight;
        //alert(windowHeight + ' + ' + scrollHeight);
        if (scrollHeight <= windowHeight || (dialogBody.scrollTop() + windowHeight) > (scrollHeight - windowHeight)) {
            fileUploader.fetchFiles();
        }

        //appCommon.adjustDialog();
    }

    self.fetchFiles = function () {
        if (self.lastId == 0 || self.isFetching) return;

        self.isFetching = true;
        $(dialogSelector).find(".loading-image").show();

        //debugger;
        jQuery.support.cors = true;
        //alert(self.lastId);
        $.ajax("/api/File/GetOlderFiles/" + self.lastId)
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
                  self.files = list;
                  appCommon.evalBindings(dialogSelector);

                  self.isFetching = false;

                  self.checkScroll();
              })
              .fail(function () {
                  //alert("error");
              })
              .always(function () {
                  self.isFetching = false;
                  $(dialogSelector).find(".loading-image").hide();
              });

        //appCommon.evalBindings('.modules-file-uploader');
    };

    self.getNewFiles = function () {
        //debugger;
        jQuery.support.cors = true;
        //alert(self.lastId);
        $.ajax("/api/File/GetNewerFiles/" + self.firstId)
              .done(function (moduleFiles) {
                  if (moduleFiles.length > 0) {
                      if (self.lastId < 0 || moduleFiles[moduleFiles.length - 1]["Id"] < self.lastId) {
                          self.lastId = moduleFiles[moduleFiles.length - 1]["Id"];
                      }
                      if (self.firstId < 0 || moduleFiles[0]["Id"] > self.firstId) {
                          self.firstId = moduleFiles[0]["Id"];
                      }
                  }
                  self.files = moduleFiles;
                  appCommon.evalBindings(dialogSelector, true);
                  //appCommon.adjustDialog();
              })
              .fail(function () {
              })
              .always(function () {
              });
    };

    self.initilize = function () {
        var token = localStorage.getItem(app.tokenKey);

        var uploader = new qq.FineUploaderBasic({
            debug: true,
            request: {
                endpoint: '/api/File/PostFile/',
                customHeaders: {
                    "Authorization": 'Bearer ' + token
                },
                onUpload: function (id, name) {
                    //alert('onUpload ---> ' + id + ' - ' + name);
                    $('.uploader-progress').css('width', '0%');
                    $('.uploader-progress').show();
                },
                onProgress: function (id, name, uploadedBytes, totalBytes) {
                    //alert('onProgress ---> ' + id + ' - ' + name);
                    var percent = (uploadedBytes / totalBytes) * 100;
                    $('.uploader-progress').css('width', percent + '%');
                },
                onComplete: function (id, name, result, xhr) {
                    //alert('onComplete ---> ' + id + ' - ' + name);
                    if (result["success"]) {
                        self.getNewFiles();
                    } else {
                        alert(result["message"] ? result["message"] : "An error occurred");
                    }
                    $('.uploader-progress').hide();
                },
                onError: function (id, name, error, xhr) {
                    $('.uploader-progress').hide();
                    alert('Error: ' + JSON.stringify(error));
                }
            },
            button: $('.btn-uploader')[0],
            validation: {
                allowedExtensions: ["png", "jpg", "bmp", "gif", "mp4"],
                //itemLimit: 1
            },
            multiple: false,
            callbacks: {
                onError: function (id, name, error, xhr) {
                    $('.uploader-progress').hide();
                    alert(error);
                }
            }
        });

        var dialogBody = $(dialogSelector).find(".popup-dialog-body");
        dialogBody.off('scroll');
        dialogBody.on('scroll', fileUploader.checkScroll);
    };

    self.selectFile = function (sender) {
        //var id = $(sender).attr('file-id');
        //var cover = $(sender).css('background-image');
        //var contentType = $(sender).attr('content-type');
        //cover = cover.substring(5, cover.length - 2); //removing url("...")
        var file = JSON.parse($(sender).attr('file-json'));

        if (self.callback) {
            self.callback(file);
        }

        appCommon.closeDialog(sender);
    };

    self.deleteFile = function (sender, event) {
        var file = JSON.parse($(sender).parents('#loopItem').attr('file-json'));

        if (file && confirm('Are you sure to delete this file?')) {

            $(sender).parents('#loopItem').parent().remove();

            $.post("/api/File/DeleteFile/", file)
                .done(function (data) {
                    //alert("Success");
                }).fail(function (data) {
                    debugger;
                    alert("File cannot be deleted because it is maybe in use. \n\n\nFor more detail: \n" + JSON.stringify(data.responseText));
                });
        }

        event.stopPropagation()
    };

    self.init = function () {
        //appCommon.appendActiveClasses(self);
    };

    return self;
}

var fileUploader = new FileUploader();
