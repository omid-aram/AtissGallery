function CollectionList() {
    var self = this;

    self.deleteCollection = function (sender, event) {
        var _collection = JSON.parse($(sender).parents('#loopItem').attr('collection-json'));

        if (_collection && confirm('Are you sure to delete this media?')) {

            $(sender).parents('#loopItem').parent().remove();

            $.post("/api/Collection/DeleteCollection/", _media)
                .done(function (data) {
                    //alert("Success");
                }).fail(function (data) {
                    debugger;
                    alert("Collection cannot be deleted because it is maybe in use. \n\n\nFor more detail: \n" + JSON.stringify(data.responseText));
                });
        }

        event.stopPropagation()
    };

    self.addCollection = function (sender, event) {
        //mediaEditor.showDialog(sender, '#mediaEditorDialog', event, mediaSelector.getNewFiles)
    };

    return self;
}

var collectionList = new CollectionList();