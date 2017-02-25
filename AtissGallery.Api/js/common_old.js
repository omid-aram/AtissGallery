window.common = (function () {
    var common = {};

    common.getFragment = function getFragment() {
        if (window.location.hash.indexOf("#") === 0) {
            return parseQueryString(window.location.hash.substr(1));
        } else {
            return {};
        }
    };

    function parseQueryString(queryString) {
        var data = {},
            pairs, pair, separatorIndex, escapedKey, escapedValue, key, value;

        if (queryString === null) {
            return data;
        }

        pairs = queryString.split("&");

        for (var i = 0; i < pairs.length; i++) {
            pair = pairs[i];
            separatorIndex = pair.indexOf("=");

            if (separatorIndex === -1) {
                escapedKey = pair;
                escapedValue = null;
            } else {
                escapedKey = pair.substr(0, separatorIndex);
                escapedValue = pair.substr(separatorIndex + 1);
            }

            key = decodeURIComponent(escapedKey);
            value = decodeURIComponent(escapedValue);

            data[key] = value;
        }

        return data;
    }

    common.popupMenu = function (data, event) {
        var element = $(event.target || event.srcElement).parents('a');
        if (element.length > 0) {
            var popup = $(element.attr('popup'));
            if (popup.length > 0) {
                var position = element.attr('position');
                var scrollTop = $(document).scrollTop();
                var offsetTop = element.offset().top - scrollTop;
                switch (position) {
                    case 'top':
                        var windowHeight = $(window).height();
                        popup.css('bottom', windowHeight - offsetTop);
                        break;

                    default:
                        var aHeight = element.height();
                        popup.css('top', offsetTop + aHeight);
                        break;
                }
                popup.toggle();
                event.stopPropagation();
            }
        }
    };

    $(window).on('click', function () {
        $('.popup-menu').hide();
    });


    return common;
})();