function AppCommon(ver) {
    var appCommon = {};

    if (!ver) ver = '1.0';

    var _mainPage = 'home',
        _lang = 'fa',
        _hrefPrefix = '',
        _pageTitle = '',
        myLoadQueue = {},
        _isAllQueued = {},
        //modulesWaitingList = [],
        activeModules = [],
        activePageUrl = '',
        moduleLoaderTimer;

    appCommon.isFirstBooted = false;

    appCommon.initialize = function () {
        if (appCommon.isFirstBooted) return;

        _isAllQueued['appCommon.initialize'] = false;

        appCommon.isFirstBooted = true;
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/normalize.css'));
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/font-awesome.min.css'));
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/barfix.css'));
        $('head').append($('<link rel="stylesheet" type="text/css" media="all" />').attr('href', 'css/atiss.css'));

        evalMainPageLang();

        appCommon.loadHtml('.header-container', plusVersion('pages/modules/_header.html'));
        appCommon.loadHtml('.footer-container', plusVersion('pages/modules/_footer.html'));
        appCommon.loadHtml('.usermenu-container', plusVersion('pages/modules/_usermenu.html'));

        appCommon.loadMainPage();

        //isAllQueued = true;
        _isAllQueued['appCommon.initialize'] = true;
        checkAllLoaded();
    };

    var getPageObjectName = function (url) {
        var pathname = url.split('.html');
        var names = pathname[0].split('/');
        return names[names.length - 1];
    };

    appCommon.loadMainPage = function () {
        //debugger;
        appCommon.closeDialog();

        $('.loading-panel').show(); 
        //$('.main-container').hide();

        evalMainPageLang();

        var $container = $('.main-container');

        var lastObject = null;
        if (activePageUrl) {
            lastObject = getPageObjectName(activePageUrl);
        }

        //if (activePageUrl) {
        //    var page = $('<page></page>').attr('page', activePageUrl).attr('object', getPageObjectName(activePageUrl));
        //    page.append($container.children());
        //    $('.pages-holder').append(page);
        //}

        activePageUrl = plusVersion('pages/' + _mainPage);

        var newObject = getPageObjectName(activePageUrl);

        //var page = $('.pages-holder').children('[page="' + activePageUrl + '"]');

        //if (page.length) {
        //    $container.empty();
        //    $container.append(page.children());
        //    var object = page.attr('object');
        //    if (window[object]) {
        //        window[object].init();//TODO: Check all pages should have init()
        //    }

        //    page.remove();
        //    checkAllLoaded();
        //} else {

        if (lastObject == newObject && window[lastObject]) {
            window[lastObject].init();
            checkAllLoaded();
        } else {
            activeModules = [];

            //$container.find("video").each(function () {
            //    //debugger;
            //    try {
            //        this.pause();
            //        $(this).attr("src", "data:video/mp4;base64, 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");
            //        this.load();
            //        this.remove();
            //    }
            //    catch (ex) {
            //    }
            //});

            appCommon.loadHtml('.main-container', activePageUrl, function () {
                $('html title').text(_pageTitle);
                $container.hide();
                $container.fadeIn();
            });
        }
        //}
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

                            //$('base').attr('href', baseUrl + '/' + _hrefPrefix);
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

        //alert(_mainPage);

        appCommon.setLanguage();
    };

    appCommon.setLanguage = function () {
        $('html').attr('lang', _lang);
        $('html').attr('xml:lang', _lang);
        $('html').attr('dir', _lang == 'fa' ? 'rtl' : 'ltr');
        $('body').addClass(_lang == 'fa' ? 'bx-rtl' : 'bx-ltr');
    };

    appCommon.getLanguage = function () {
        return _lang;
    };

    appCommon.getUrlPrefix = function () {
        return _hrefPrefix;
    };

    appCommon.mergeAddress = function(first, second) {
        var hasFirstSlash = false;
        if (first[first.length - 1]== '/') {
hasFirstSlash = true; }
        if (second[0]== '/') { second = second.substr(1); }

            return first +(hasFirstSlash?'': '/') +second;
        };

    appCommon.getFixedUrl = function (address) {
            //debugger;   
        if (address.indexOf('//') >= 0 || address.indexOf('www') >= 0) {
            return address;
        }

        var winloc = window.location.origin;

        return appCommon.mergeAddress(winloc, appCommon.mergeAddress(_hrefPrefix, address));
        };

    appCommon.getMainPage = function () {
        return _mainPage;
        };

    appCommon.loadHtml = function (container, url, callback) {
        var key = (url +container).replace(/ /gi, '_');
        if (myLoadQueue[key]!= null) return;
        setLoadQueue(key, false);
            //alert($(container).length + '----' + url);

            //$(container).find("video").each(function () {
            //    debugger;
            //    this.pause();
            //    $(this).attr("src", "data:video/mp4;base64, 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");
        //    this.load();
        //    this.remove();
        //});

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
            if (callback) callback($(container).attr('class'));
        });
    };

    //appCommon.loadStyle = function (url, callback) {
    //    var link = document.createElement("link");
    //    link.rel = "stylesheet";
    //    link.type = "text/css";
    //    link.media = "all";

    //    link.href = url;
    //    document.getElementsByTagName("head")[0].appendChild(link);
    //};

    //appCommon.loadScript = function (url, callback) {
    //    if (myLoadQueue[url] != null) return;
    //    setLoadQueue(url, false);
    //    var script = document.createElement("script")
    //    script.type = "text/javascript";

    //    if (script.readyState) {  //IE
    //        script.onreadystatechange = function () {
    //            if (script.readyState == "loaded" ||
    //                script.readyState == "complete") {
    //                script.onreadystatechange = null;
    //                setLoadQueue(url, true);
    //                if (callback) callback();
    //            }
    //        };
    //    } else {  //Others
    //        script.onload = function () {
    //            setLoadQueue(url, true);
    //            if (callback) callback();
    //        };
    //    }

    //    script.src = url;
    //    document.getElementsByTagName("body")[0].appendChild(script);
    //};

    appCommon.enqueueImage = function (selector) {
        var img = $(selector);
        if (!img.attr('src')) return;

        setLoadQueue('img.src=' + img.attr('src'), false);

        img.one("load", function () {
            setLoadQueue('img.src=' + img.attr('src'), true);
        }).on("error", function () {
            setLoadQueue('img.src=' + img.attr('src'), true);
        }).each(function () {
            if (this.complete) $(this).load();
        });
    };

    appCommon.enqueueAllImages = function (container) {
        _isAllQueued['appCommon.enqueueAllImages' + container] = false;

        var imgs = $(container).find('img');
        for (var i = 0; i < imgs.length; i++) {
            appCommon.enqueueImage(imgs[i]);
        }

        _isAllQueued['appCommon.enqueueAllImages' + container] = true;
        checkAllLoaded();
    };

    //appCommon.appendActiveClasses = function (obj) {
    //    if (activeClasses.indexOf(obj) < 0) {
    //        activeClasses.push(obj);
    //    }
    //};

    appCommon.goto = function(address) {
        if (!address) address = '';
        window.location = appCommon.getFixedUrl(address);
    };

    appCommon.goHome = function () {
    //window.location = appCommon.getUrlPrefix();
        appCommon.goto('');
    };

    appCommon.gotoLoginPage = function () {
        var returnUrl = window.location.pathname;
        appCommon.goto("login?r=" + returnUrl);
    };

    appCommon.reloadPage = function () {
        window.location.reload();
    };

    appCommon.getQueryStrings = function () {
        var vars = [], hash;
        var hashes = _mainPage.slice(_mainPage.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    };

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //  Data Binding Functions...
    //
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    var doReplaceLoopItems = function (templateContainer, listName, i) {
        var dataValues = $(templateContainer).find('[data-loop], [data-loop-keep], [data-if], [data-bind], [data-bind-once], [data-attr], [data-attr-once]');
        dataValues.push(templateContainer);
        dataValues.each(function () {
            //if ($(this).closest('[module]').attr('data-checked') == "true") return;
            if ($(this).closest('[data-loop-template]').length > 0) return;

            var value;

            value = $(this).attr('data-loop');
            if (value) $(this).attr('data-loop', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-loop-keep');
            if (value) $(this).attr('data-loop-keep', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-if');
            if (value) $(this).attr('data-if', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-bind');
            if (value) $(this).attr('data-bind', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-bind-once');
            if (value) $(this).attr('data-bind-once', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-attr');
            if (value) $(this).attr('data-attr', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));

            value = $(this).attr('data-attr-once');
            if (value) $(this).attr('data-attr-once', value.replace(/#item/gi, listName + '[' + i + ']').replace(/#index/gi, i));
        });
    };

    var doDataLoop = function (sender, isLoopPrepend) {
        $(sender).each(function () {
            var $loop = $(this);

            //if ($(this).closest('[module]').attr('data-checked') == "true") return;
            if ($loop.closest('[data-loop-template]').length > 0) return;

            var listName = $loop.attr('data-loop') || $loop.attr('data-loop-keep');
            var list = eval(listName);
            var template = $loop.children('[data-loop-template]');
            var loopSticks = $loop.children('[data-loop-stick]');
            if (template.length > 0) {

                if ($loop.attr('data-loop')) {
                    $loop.empty();
                    $loop.append(template);
                }

                //Doing Inner Loops
                var templateContainer = $(template.get(0).outerHTML).attr('data-loop-template', null);
                templateContainer.show();
                template.hide();

                var innerDataLoops = $(templateContainer).find('[data-loop], [data-loop-keep]');
                innerDataLoops.each(function () {
                    doDataLoop(this, isLoopPrepend);
                });

                if (list) {
                    if (isLoopPrepend) {
                        for (var i = list.length - 1; i >= 0; i--) {
                            var templateContainerClone = (i < list.length - 1) ? $(templateContainer.get(0).outerHTML) : $(templateContainer);
                            doReplaceLoopItems(templateContainerClone, listName, i);
                            $loop.prepend(/*templateTagName == 'TR' ?*/ templateContainerClone.get(0).outerHTML /*: templateContainerClone.html()*/);

                            templateContainerClone.remove();
                            templateContainerClone = undefined;
                        }
                    } else {
                        for (var i = 0; i < list.length; i++) {
                            var templateContainerClone = (i < list.length - 1) ? $(templateContainer.get(0).outerHTML) : $(templateContainer);
                            doReplaceLoopItems(templateContainerClone, listName, i);
                            $loop.append(/*templateTagName == 'TR' ?*/ templateContainerClone.get(0).outerHTML /*: templateContainerClone.html()*/);

                            templateContainerClone.remove();
                            templateContainerClone = undefined;
                        }
                    }
                }
                templateContainer.remove();
                templateContainer = undefined;
            }
            loopSticks.each(function () {
                var $loopStick = $(this);
                if ($loopStick.attr('data-loop-stick') == 'first') {
                    $loop.prepend($loopStick);
                }
                else {
                    $loop.append($loopStick);
                }
            });
        });
    };

    appCommon.doRepeatLoopTemplate = function (sender, strDataLoop, strDataBind, strDataAttr) {
        var $sender = $(sender);
        var dataLoop = eval(strDataLoop);
        if (!dataLoop || dataLoop.length == 0) {
            $sender.empty();
            return;
        }

        var $loop = $sender.closest('[data-loop],[data-loop-keep]');
        var $template = $loop.children('[data-loop-template]');
        $sender.attr('data-loop', strDataLoop);
        var $templateClone = $template.clone();
        if (strDataAttr) {
            $templateClone.attr('data-attr', strDataAttr);
        }
        if (strDataBind) {
            $templateClone.attr('data-bind', strDataBind);
        }
        $sender.append($templateClone);
        appCommon.evalBindings($sender);
    }

    appCommon.evalBindings = function (selector, isLoopPrepend) {
        var $selector = $(selector);

        //debugger;
        var moduleElements = $selector.find('module');
        var notTemplatedModules = [];
        moduleElements.each(function () {
            var $module = $(this);
            if (!$module.attr('data-loop-template') && $module.parents('[data-loop-template]').length == 0) {
                notTemplatedModules.push($module);
            }
        });
        //if ($(selector).find('module').length) {
        if (notTemplatedModules.length) {
            window.setTimeout(function () {
                appCommon.evalBindings(selector, isLoopPrepend);
            }, 100);
            return;
        }

        var dataLoops = $selector.find('[data-loop], [data-loop-keep]');
        $selector.each(function () {
            if (this.hasAttribute('data-loop') || this.hasAttribute('data-loop-keep')) {
                dataLoops.push($selector);
            }
        });
        dataLoops.each(function () {
            doDataLoop(this, isLoopPrepend);
        });

        var dataIfs = $selector.find('[data-if]');
        dataIfs.each(function () {
            var $this = $(this);
            //if ($this.closest('[module]').attr('data-checked') == "true") return;
            if ($this.closest('[data-loop-template]').length > 0) return;

            //debugger;
            var condition = $this.attr('data-if');
            if (eval(condition)) {
                var children = $this.children();
                for (var i = children.length - 1; i >= 0; i--) {
                    $this.after($(children[i]).clone());
                }
            }
            $this.remove();
        });

        var dataAttrs = $selector.find('[data-attr], [data-attr-once]');
        dataAttrs.each(function () {
            //if ($(this).closest('[module]').attr('data-checked') == "true") return;
            if ($(this).closest('[data-loop-template]').length > 0) return;

            var dataAttr = $(this).attr('data-attr') || $(this).attr('data-attr-once');
            var parts = dataAttr.split('::');
            for (var i = 0; i < parts.length; i++) {
                var columnIndex = parts[i].indexOf(':');
                var attr = parts[i].substr(0, columnIndex).trim();
                var value = parts[i].substr(columnIndex + 1).trim();

                try {
                    eval('$(this).attr("' + attr + '", ' + value + ')');
                } catch (ex) {
                    //debugger;
                    console.error(ex);
                }
            }
            if ($(this).attr('data-attr-once')) {
                $(this).attr('data-attr-once', null);
            }
            if (this.hasAttribute("module")) {
                $(this).attr('data-checked', 'false');
            }
        });

        var dataBinds = $selector.find('[data-bind], [data-bind-once]');
        dataBinds.each(function () {
            //if ($(this).closest('[module]').attr('data-checked') == "true") return;
            if ($(this).closest('[data-loop-template]').length > 0) return;

            var dataBind = $(this).attr('data-bind') || $(this).attr('data-bind-once');
            var parts = dataBind.split('::');
            for (var i = 0; i < parts.length; i++) {
                var columnIndex = parts[i].indexOf(':');
                var func = parts[i].substr(0, columnIndex).trim();
                var value = parts[i].substr(columnIndex + 1).trim();

                try {
                    switch (func) {
                        case "do":
                            eval(value);
                            break;
                        default:
                            eval('$(this).' + func + '(' + value + ')');
                    }
                } catch (ex) {
                    //debugger;
                    console.error(ex);
                }
            }
            if ($(this).attr('data-bind-once')) {
                $(this).attr('data-bind-once', null);
            }
            if (this.hasAttribute("module")) {
                $(this).attr('data-checked', 'false');
            }
        });

        //appCommon.setAnchorsClick(selector);
    }

    appCommon.evalBack = function (sender) {
        var dataBind = $(sender).attr('data-bind');
        if (dataBind.length) {
            var parts = dataBind.split('::');
            for (var i = 0; i < parts.length; i++) {
                var columnIndex = parts[i].indexOf(':');
                var func = parts[i].substr(0, columnIndex).trim();
                var value = parts[i].substr(columnIndex + 1).trim();

                try {
                    eval(value + ' = $(sender).' + func + '()');
                } catch (ex) {
                    //debugger;
                    console.error(ex);
                }
            }
        }
    };

    appCommon.evalBackAttr = function (sender) {
        var dataAttr = $(sender).attr('data-attr');
        if (dataAttr.length) {
            var parts = dataAttr.split('::');
            for (var i = 0; i < parts.length; i++) {
                var columnIndex = parts[i].indexOf(':');
                var attr = parts[i].substr(0, columnIndex).trim();
                var value = parts[i].substr(columnIndex + 1).trim();

                try {
                    eval(value + ' = $(sender).attr("' + attr + '")');
                } catch (ex) {
                    //debugger;
                    console.error(ex);
                }
            }
        }
    };

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //  Module Loading Functions...
    //
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    var moduleFetched = function (type) {
        if (window[type]) {

            if (activeModules.indexOf(type) < 0) {
                activeModules.push(type);
            }
            setLoadQueue(type, true);

            eval(type + '.init()');
        }
        else {
            setTimeout(function () {
                moduleFetched(type);
            }, 100);
        }
    };

    appCommon.fetchModules = function (types) {
        var key = JSON.stringify(types).replace(/ /gi, '_');;
        _isAllQueued['appCommon.importModules.' + key] = false;

        for (var i = 0; i < types.length; i++) {
            var type = types[i];

            setLoadQueue(type, false);

            var moduleSourceClass = '.modules-container .' + type;
            var moduleSource = $(document).find(moduleSourceClass);
            if (moduleSource.length) {
                moduleFetched(type);
            }
            else {
                $('.modules-container').append($('<div class="' + type + '"></div>'));
                moduleSource = $(document).find(moduleSourceClass);
                appCommon.loadHtml(moduleSourceClass, plusVersion('pages/modules/' + type + '.html'), function (type) {
                    moduleFetched(type);
                });
            }
        }

        _isAllQueued['appCommon.importModules.' + key] = true;
    };

    appCommon.loadActiveModules = function () {
        //debugger;
        $('.page-container [data-loop-template="true"]').each(function () {
            if ($(this).css('display') != 'none') {
                $(this).closest('[module]').attr('data-checked', 'false');
            }
        });

        //$('.page-container [media-id="-1"]').each(function () {
        //    var parentModule = $(this).closest('[module]');
        //    if (parentModule) {
        //        parentModule.attr('data-checked', 'false');
        //    }
        //});

        for (var i = 0; i < activeModules.length; i++) {
            var type = activeModules[i];
            var $module = $('.modules-container').children('.' + type);
            if ($module.length == 0) continue;

            $('.page-container module[type="' + type + '"]').each(function () {
                var $this = $(this);
                if ($this.attr('data-loop-template') || $this.parents('[data-loop-template]').length) return;

                var $moduleClone = $($module.children()[0].outerHTML);

                //Copying module attributes
                $.each(this.attributes, function (i, attrib) {
                    if (attrib.name !== 'type' && attrib.name !== 'container') {
                        if (attrib.name === 'class') {
                            $moduleClone.addClass(attrib.value);
                        } else {
                            $moduleClone.attr(attrib.name, attrib.value);
                        }
                    }
                });

                $this.after($moduleClone);
                $this.remove();
            });

            $('.page-container [module="' + type + '"]').each(function () {
                var $this = $(this);
                if ($this.attr('data-checked') == 'true' || $this.closest('[data-loop-template]').length) return;

                eval(type + '.checkModule(this)');
            });

            var editorOf = $($module.children()[0]).attr('editor-of');
            if (editorOf) {
                //debugger;
                $('.page-container [module="' + editorOf + '"]').each(function () {
                    var $this = $(this);
                    if ($this.attr('data-checked') != 'true' || $this.attr('editor') == 'loaded') return;

                    var $moduleClone = $($module.children()[0].outerHTML);
                    $this.append($moduleClone);
                    $this.attr('editor', 'loaded');
                });
            }
        }
        //});
    };
    moduleLoaderTimer = window.setInterval(appCommon.loadActiveModules, 100);

    appCommon.recheckElement = function (element) {
        window.clearInterval(moduleLoaderTimer);
        $(element).attr('data-checked', 'false');
        moduleLoaderTimer = window.setInterval(appCommon.loadActiveModules, 100);
    };

    appCommon.recheckAllElements = function (selector) {
        if (!selector) selector = '.page-container';
        appCommon.recheckElement(selector + ' [data-checked="true"]');
    };

    //appCommon.loadModulesEditors = function (scope, callback) {
    //    var moduleTags = $(scope).find('module');
    //    if (moduleTags.length > 0) {
    //        window.setTimeout(function () {
    //            appCommon.loadModulesEditors(scope, callback);
    //        }, 100);
    //        return;
    //    }
    //    _isAllQueued['appCommon.loadModulesEditors' + scope] = false;

    //    var modules = $(scope).find('[module]');

    //    for (var i = 0; i < modules.length; i++) {
    //        var moduleName = $(modules[i]).attr('module');
    //        var moduleEditorContainer = $('<div></div>');
    //        $(modules[i]).append(moduleEditorContainer);
    //        var type = moduleName + 'Editor';
    //        loadModule('', type, moduleEditorContainer);
    //    }

    //    _isAllQueued['appCommon.loadModulesEditors' + scope] = true;
    //    checkAllLoaded();
    //};

    //appCommon.loadModules = function (parentModule, scope, callback) {
    //    if (!scope) scope = '';
    //    var moduleTags = $(scope).find('module');

    //    if (!moduleTags.length) return;

    //    _isAllQueued['appCommon.loadModules' + scope] = false;

    //    for (var i = 0; i < moduleTags.length; i++) {
    //        var type = $(moduleTags[i]).attr('type');

    //        var attributes = {};
    //        $.each($(moduleTags[i]).get(0).attributes, function (i, attrib) {
    //            attributes[attrib.name] = attrib.value;
    //        });
    //        loadModule(parentModule, type, $(moduleTags[i]), attributes, callback);
    //    }

    //    _isAllQueued['appCommon.loadModules' + scope] = true;
    //    checkAllLoaded();
    //};

    //var loadModule = function (parentModule, type, container, attributes, callback) {

    //    var key = (container + type).replace(/ /gi, '_');
    //    setLoadQueue(key, false);

    //    var moduleSourceClass = '.modules-container .' + type;
    //    var moduleSource = $(document).find(moduleSourceClass);
    //    if (moduleSource.length > 0) {
    //        addToModuleWaitingList(parentModule, type, container, attributes, callback);
    //        if (moduleSource.html()) {
    //            appendModuleToContainer(type);
    //            setLoadQueue(key, true);
    //        }
    //    }
    //    else {
    //        $('.modules-container').append($('<div class="' + type + '"></div>'));
    //        moduleSource = $(document).find(moduleSourceClass);
    //        addToModuleWaitingList(parentModule, type, container, attributes, callback);
    //        appCommon.loadHtml(moduleSourceClass, plusVersion('pages/modules/' + type + '.html'), function () {
    //            appendModuleToContainer(type);
    //            setLoadQueue(key, true);
    //        });
    //    }
    //};

    //var addToModuleWaitingList = function (parentModule, type, container, attributes, callback) {
    //    if (!container) container = 'body';
    //    if (!attributes) attributes = {};

    //    var key = type;
    //    if (!modulesWaitingList[key]) modulesWaitingList[key] = { parentModule: parentModule, innerModules: [], owners: [], callback: callback };
    //    if (modulesWaitingList[parentModule] && modulesWaitingList[parentModule].innerModules.indexOf(type) < 0) {
    //        modulesWaitingList[parentModule].innerModules.push(type);
    //    }
    //    modulesWaitingList[key].owners.push({ container: container, attributes: attributes });
    //};

    //var appendModuleToContainer = function (type) {
    //    var moduleSource = $('.modules-container .' + type);
    //    var key = type;
    //    if (!modulesWaitingList[key]) modulesWaitingList[key] = { parentModule: '', innerModules: [], owners: [] };

    //    if (modulesWaitingList[key].innerModules.length > 0) {
    //        return;
    //    }

    //    while (modulesWaitingList[key].owners.length > 0) {
    //        var item = modulesWaitingList[key].owners.pop();
    //        var container = item.container;
    //        if ($(container).length === 0) continue;
    //        var attributes = item.attributes;

    //        var module = $(moduleSource.children()[0].outerHTML);

    //        for (var property in attributes) {
    //            if (attributes.hasOwnProperty(property)) {
    //                if (property !== 'type' && property !== 'container') {
    //                    if (property === 'class') {
    //                        $(module).addClass(attributes[property]);
    //                    } else {
    //                        $(module).attr(property, attributes[property]);
    //                    }
    //                }
    //            }
    //        }
    //        $(container).after(module);
    //        $(container).remove();

    //        if (typeof (modulesWaitingList[key].callback) === 'function') {
    //            modulesWaitingList[key].callback(module);
    //        }
    //    }

    //    //initialize module - it has to have an init() method to work fine on preloaded modules
    //    eval(type + '.init()');

    //    var parentModuleType = modulesWaitingList[key].parentModule;
    //    if (parentModuleType) {
    //        if (modulesWaitingList[parentModuleType]) modulesWaitingList[parentModuleType].innerModules.pop(type);
    //        appendModuleToContainer(modulesWaitingList[key].parentModule)
    //    }
    //};

    appCommon.popupMenu = function (sender, event) {
        //debugger;
        var $sender = $(sender);
        if ($sender.length > 0) {
            $('.popup-menu').each(function () {
                var $this = $(this);

                if ($this.css('display') != 'none' && !$this.find($sender).length) {
                    $this.hide();
                }
            });

            var popup = $($sender.attr('popup'));
            if (popup.length > 0) {
                var $subMenuCollector = popup.closest('.sub-menu-collector');
                $subMenuCollector.append(popup);

                var position = $sender.attr('position');
                var scrollTop = $(document).scrollTop();
                var offsetTop = $sender.offset().top - scrollTop;
                switch (position) {
                    case 'top':
                        var windowHeight = $(window).height();
                        popup.css('bottom', windowHeight - offsetTop);
                        break;

                    default:
                        var aHeight = $sender.height();
                        popup.css('top', offsetTop + aHeight + scrollTop);
                        break;
                }
                popup.toggle();
                event.stopPropagation();
            }
        }
    };

    appCommon.showSideMenu = function (sender, event) {
        //debugger;
        var $sideMenu = $('.side-menu');
        if ($sideMenu.css('display') != 'none') return;

        $sideMenu.show();
        //alert(_lang);
        $sideMenu.css(_lang == 'en' ? 'left' : 'right', '-200px');
        setTimeout(function () {
            $sideMenu.css('left', '');
            $sideMenu.css('right', '');
        }, 1);

        event.stopPropagation();
    };

    appCommon.hideSideMenu = function (sender, event) {
        var $sideMenu = $('.side-menu');
        $sideMenu.css(_lang == 'en' ? 'left' : 'right', '-200px');
        setTimeout(function () {
            $sideMenu.hide();
        }, 400);
    };

    appCommon.showDialog = function (dialogSelector, event) {

        var $dialog = $(dialogSelector);
        if ($dialog.length > 0) {
            //$('.page-container').addClass(' filter-blur');
            if ($dialog.parent('.dialogs-container').length == 0) {
                $('.dialogs-container').append($dialog);
            }

            var moduleElements = $dialog.find('module');
            var notTemplatedModules = [];
            moduleElements.each(function () {
                var $module = $(this);
                if (!$module.attr('data-loop-template') && $module.parents('[data-loop-template]').length == 0) {
                    notTemplatedModules.push($module);
                }
            });
            //if ($dialog.find('module').length) {
            if (notTemplatedModules.length) {
                window.setTimeout(function () {
                    appCommon.showDialog(dialogSelector, event);
                }, 100);
                return;
            }


            if (event) {
                event.stopPropagation();

                //debugger;
                var sender = $(event.target);
                if (sender.length) {
                    var senderDialog = $(sender).parents('.popup-dialog');
                    var zIndex = senderDialog.css('z-index');
                    if (zIndex) {
                        $dialog.css('z-index', parseInt(zIndex) + 1);
                    }
                }
            }

            $('.popup-mask').fadeIn('fast');
            //$dialog.fadeIn('fast');
            $dialog.show();
            //alert(_lang);
            $dialog.css(_lang == 'en' ? 'left' : 'right', '-100%');
            setTimeout(function () {
                $dialog.css('left', '');
                $dialog.css('right', '');
            }, 1);


            //appCommon.adjustDialog($dialog);

            //debugger;
            //History.pushState({ data: dialogSelector }, null, dialogSelector);
        }
    };

    appCommon.closeDialog = function (sender) {
        var $dialog;
        if (!sender) {
            $dialog = $('.popup-dialog');//.hide();
        } else {
            $dialog = $(sender).parents('.popup-dialog');//.hide();
        }
        $dialog.css(_lang == 'en' ? 'left' : 'right', '-100%');
        setTimeout(function () {
            $dialog.hide();

            var openedDialogs = $('.dialogs-container').children(':visible');
            if (openedDialogs.length == 0) {
                //$('.page-container').removeClass('filter-blur');
                $('.popup-mask').hide();
            }
        }, 400);
        //debugger;
        //History.popState();
    }

    //appCommon.adjustDialog = function (dialog) {
    //    return;

    //    if (!dialog) {
    //        dialog = $(document).find('.popup-dialog:visible');
    //    }
    //    $(dialog).each(function () {

    //        var windowWidth = $(window).width();
    //        var dialogWidth = $(this).width();
    //        $(this).css('left', (windowWidth - dialogWidth) * 0.5);

    //        var windowHeight = $(window).height();
    //        var dialogHeight = windowHeight * (dialogWidth / windowWidth);
    //        $(this).height(dialogHeight);

    //        var dialogHeaderHeight = $(this).children('.popup-dialog-header').height();
    //        var dialogFooterHeight = $(this).children('.popup-dialog-footer').height();
    //        var dialogBodyPadding = parseInt($(this).children('.popup-dialog-body').css('padding-top')) + parseInt($(this).children('.popup-dialog-body').css('padding-bottom'));
    //        var dialogFooterPadding = parseInt($(this).children('.popup-dialog-footer').css('padding-top')) + parseInt($(this).children('.popup-dialog-footer').css('padding-bottom'));
    //        $(this).children('.popup-dialog-body').height(dialogHeight - dialogHeaderHeight - dialogFooterHeight - dialogBodyPadding - dialogFooterPadding);

    //        $(this).css('top', (windowHeight - dialogHeight) * 0.45);
    //    });
    //}

    appCommon.selectTab = function (sender) {
        var tabContainer = $(sender).parents('.tab-container');
        var tabSelector = $(sender).attr('tab-selector');
        if (tabContainer.length && tabSelector) {
            tabContainer.find('.tab-page').hide();
            tabContainer.find(tabSelector).show();
            tabContainer.find('[tab-selector]').removeClass('selected');
            $(sender).addClass('selected');
        }
    }

    appCommon.selectButton = function (sender) {
        var buttonContainer = $(sender).parents('.button-container');
        if (buttonContainer.length) {
            var isSelectedBefore = $(sender).hasClass('selected');
            buttonContainer.find('button').removeClass('selected');
            buttonContainer.attr('selected-value', buttonContainer.attr('no-selected-value'));
            if (!isSelectedBefore) {
                $(sender).addClass('selected');
                buttonContainer.attr('selected-value', $(sender).attr('value'));
            }

            buttonContainer.trigger('change');
        }
    }

    appCommon.selectButtonByValue = function (sender, value) {
        var buttonContainer = $(sender);
        if (buttonContainer.length) {
            buttonContainer.find('button').each(function () {
                if ($(this).attr('value') == value) {
                    $(this).addClass('selected');
                }
                else {
                    $(this).removeClass('selected');
                }
            });
        }
    }

    appCommon.addPositionClass = function (sender, positionNo) {
        var className = "";

        switch (parseInt(positionNo)) {
            case 1: className = "bx-pos-top-left"; break;
            case 2: className = "bx-pos-top-center"; break;
            case 3: className = "bx-pos-top-right"; break;
            case 4: className = "bx-pos-middle-left"; break;
            case 5: className = "bx-pos-middle-center"; break;
            case 6: className = "bx-pos-middle-right"; break;
            case 7: className = "bx-pos-bottom-left"; break;
            case 8: className = "bx-pos-bottom-center"; break;
            case 9: className = "bx-pos-bottom-right"; break;
            default:
                className = "bx-hidden"; break;
        }

        $(sender).addClass(className);
    }

    //var isUrlExists = function (url) {
    //    var http = new XMLHttpRequest();
    //    http.open('HEAD', url, false);
    //    http.send();
    //    alert(url + ' ====== ' + http.status);
    //    return http.status != 404;
    //}

    var plusVersion = function (url) {
        return url + (url.indexOf('?') < 0 ? '?' : '&') + 'ver=' + ver;
    };

    var setLoadQueue = function (url, isLoaded) {
        if (isLoaded && !myLoadQueue.hasOwnProperty(url)) return;

        myLoadQueue[url] = isLoaded;
        //alert(url + ' : ' + isLoaded);
        checkAllLoaded();
    };

    var checkAllLoaded = function () {
        //if (!isAllQueued) return;
        for (var key in _isAllQueued) {
            if (!_isAllQueued[key]) return;
        }
        _isAllQueued = {};

        for (var key in myLoadQueue) {
            if (!myLoadQueue[key]) return;
        }
        myLoadQueue = {};

        documentReady();

        //All Files loaded
        $('.loading-panel-fill').fadeOut();
        $('.loading-panel').fadeOut();
    };

    //History.Adapter.bind(window, 'statechange', function () {
    //    myLoadQueue = {};
    //    _isAllQueued = {};
    //    appCommon.loadMainPage();
    //});

    //appCommon.setAnchorsClick = function (sender) {
    //    if (!sender) sender = $('.page-container');

    //    $(sender).find('a').off('click');
    //    $(sender).find('a').on('click', function (e) {
    //        var $this = $(this);
    //        var url = $this.attr('href');
    //        var target = $this.attr('target');
    //        if (url.indexOf('://') >= 0 || url.indexOf('www') >= 0 || target == '_blank') return;

    //        //debugger;
    //        e.preventDefault();
    //        if (!url) return;
    //        //alert(url);
    //        //var title = $(this).attr('title');
    //        var title = Strings('brand-title') + ' - ' + $this.text();
    //        //appCommon.isPushingState = true;
    //        History.pushState({ data: title }, title, url);
    //    });
    //};

    var documentReady = function () {

        //for (var i = 0; i < activeClasses.length; i++) {
        //    if (activeClasses[i].documentReady) {
        //        activeClasses[i].documentReady();
        //    }
        //}

        //appCommon.setAnchorsClick();

        $(window).off('click');
        $(window).on('click', function () {
            $('.popup-menu').hide();
            appCommon.hideSideMenu();
        });

        //$(window).on('resize', function () {
        //    $('.bx-resize-width').each(function () {
        //        if ($(this).css('display') === 'none' || $(this).css('opacity') !== 1) return;

        //        var classes = $(this).attr('class').split(' ');
        //        var bxWidthClass = '';
        //        for (var i = 0; i < classes.length; i++) {
        //            if (classes[i].startsWith('bx-width-')) {
        //                bxWidthClass = classes[i];
        //                break;
        //            }
        //        }
        //        if (bxWidthClass.length > 9) {
        //            var numbers = bxWidthClass.substr(9).split('-');
        //            //alert(JSON.stringify(numbers));
        //            switch (numbers.length) {
        //                case 1:
        //                    $(this).width(numbers[0]);
        //                    break;
        //                case 2:
        //                    var windowWidth = $(window).width();
        //                    $(this).width(windowWidth * numbers[0] / numbers[1]);
        //                    break;
        //                default:

        //            }
        //        }
        //    })
        //});

        //alert('document loaded');
    }

    return appCommon;
};

Array.prototype.move = function (from, to) {
    var item = this.splice(from, 1)[0];
    this.splice(to, 0, item);
};

Array.prototype.findIndex = function (value, key) {
    for (var i = 0; i < this.length; i++) {
        if (key ? (this[i][key] == value) : (this[i] == value)) {
            return i;
            break;
        }
    }
    return -1;
};

Array.prototype.findItem = function (value, key) {
    var index = this.findIndex(value, key);
    if (index >= 0) {
        return this[index];
    }
    return null;
};

Array.prototype.contains = function (value, key) {
    return (this.findIndex(value, key) >= 0);
};

Array.prototype.removeItem = function (value, key) {
    var index = this.findIndex(value, key);
    if (index >= 0) {
        this.splice(index, 1);
    }
};
