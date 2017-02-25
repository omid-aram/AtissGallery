function Media() {
    var self = this;

    self.isFetching = false;
    self.Medias = {};
    self.mediaTimers = {};

    self.init = function () {
    };

    self.getList = function (sender) {
        //debugger;
        var mediaId = $(sender).parents('[module="media"]').attr('media-id');

        if (self.Medias[mediaId]) {
            setSlideShowTimer(mediaId);

            return self.Medias[mediaId].MediaFiles;
        } else {
            return [{
                MediaId: -1,
                File: {
                    Id: -1
                }
            }];
        }
    };

    self.fetchMedias = function () {
        if (self.isFetching) return;

        var ids = [];
        $('[module="media"]').each(function () {
            var $this = $(this);
            var id = parseInt($this.attr('media-id'));
            if (!isNaN(id) && !self.Medias[id] && ids.indexOf(id) < 0) {
                ids.push(id);
            }
        });

        if (ids.length > 0) {
            self.isFetching = true;
            $.post("/api/Media/FetchMedias", { Ids: ids })
                .done(function (data) {
                    for (var i = 0; i < data.length; i++) {
                        var id = data[i]['Id'];
                        media.Medias[id] = data[i];
                    }
                }).fail(function (data) {
                    debugger;
                    alert("media.fetchMedias() Fail: " + data.message);
                }).always(function () {
                    self.isFetching = false;
                });;
        }
    };

    self.checkModule = function (sender) {
        //debugger;
        var $sender = $(sender);
        var id = parseInt($sender.attr('media-id'));
        if (id > 0 && self.Medias[id]) {
            appCommon.evalBindings($sender);
            $sender.attr('data-checked', 'true');

            var _banner = $sender.parents('[module="banner"]');
            if (_banner.length && window.banner) {
                window.banner.adjustBoxes(_banner);
            }
        } else {
            self.fetchMedias();
        }
    };

    var setSlideShowTimer = function (mediaId) {
        //Initializing SlideShow Timer
        if (self.Medias[mediaId] && self.Medias[mediaId].MediaFiles.length > 1) {
            startTimer(mediaId);
        } else if (self.mediaTimers[mediaId]) {
            stopTimer(mediaId);
        }
    };

    self.pauseSlideShow = function (sender) {
        var mediaId = $(sender).parents('[module="media"]').attr('media-id');
        stopTimer(mediaId);
    };

    self.resumeSlideShow = function (sender) {
        var mediaId = $(sender).parents('[module="media"]').attr('media-id');
        startTimer(mediaId);
    };

    var startTimer = function (mediaId) {
        if (!self.mediaTimers[mediaId] && self.Medias[mediaId].MediaFiles.length > 1) {
            self.mediaTimers[mediaId] = setInterval(function () { self.nextSlide(mediaId); }, 5000);
        }
    };

    var stopTimer = function (mediaId) {
        if (self.mediaTimers[mediaId]) {
            clearInterval(self.mediaTimers[mediaId]);
        }
        self.mediaTimers[mediaId] = null;
    };

    var playMedia = function (el) {
        try {
            if (el.paused) {
                el.play();
            } else {
                throw true;
            }
        }
        catch (ex) {
            setTimeout(function () { playMedia(el); }, 100);
        }
    };

    self.nextSlide = function (mediaId) {
        var module = $('[module="media"][media-id=' + mediaId + ']');

        if (module.length) {
            module.each(function () {
                var slides = $(this).find('#loopItem[index]');
                var currentSlideIndex = $(this).attr('slide-index');
                if (!currentSlideIndex) currentSlideIndex = 0;
                var nextSlideIndex = (parseInt(currentSlideIndex) + 1) % slides.length;
                $(this).attr('slide-index', nextSlideIndex);
                slides.hide();
                $(slides[nextSlideIndex]).fadeIn();
            });
        } else {
            stopTimer(mediaId);
        }
    };

    self.createMedia = function (sender, iMedia) {
        if (!iMedia) return;

        var file = iMedia.File;
        if (!file) {
            file = {
                Id: -1,
                Address: "/html/design/no-image-slide.png",
                Cover: "/html/design/no-image-slide.png",
                ContentType: "image/png"
            };
        }
        var mediaElement;
        if (file.ContentType == 'video/mp4') {
            mediaElement = $('<video class="bx-fill" preload="preload" loop="loop"></video>');
            mediaElement.attr('poster', file.Cover);
            mediaElement.append($('<source>').attr('src', file.Address).attr('type', file.ContentType));
            mediaElement.append($('<p>Your Browser does not support video tag. Please update your Browser.</p>'));
            $(sender).after(mediaElement);
            //mediaElement.get(0).play();
            setTimeout(function () { playMedia(mediaElement.get(0)); }, 100);
        } else {
            $(sender).after($('<img class="bx-fill" alt="">').attr({ 'src': file.Address }));
        }

        var link = iMedia.HrefLink;
        //banner link
        var mediaLink = $(sender).closest('[module=media]').attr('media-link');
        if (mediaLink) {
            link = mediaLink;
        }

        if (link) {
            //debugger;
            var linkElement = $(sender).closest('a');
            linkElement.attr('href', link);
        }

        $(sender).remove();
    };

    self.setParentBackgroundImage = function (sender, iMedia) {
        if (!iMedia || !iMedia.File) return;

        var parentElement = $(sender).closest('[module="media"]').parent();
        parentElement.css('background-image', 'url(\'' + iMedia.File.Cover + '\')').addClass(' background-image-cover');
    };

    self.getViewMode = function (sender) {
        //debugger;
        var ownerModule = $(sender).parents('[module="media"]');
        return ownerModule.attr('view-mode') ? ownerModule.attr('view-mode') : 'full';
    };

    return self;
}

var media = new Media();
