var $container = $('#content').imagesLoaded(function () {
        // initialize Packery after all images have loaded
        $container.packery({
            columnWidth: 80,
            rowHeight: 80,
            containerStyle: null,
            gutter: 10
        });
        
        // get item elements, jQuery-ify them
        var $itemElems = $container.find('.resource > .xforms-repeat-item');
        // make item elements draggable
        $itemElems.draggable();
        // bind Draggable events to Packery
        $container.packery('bindUIDraggableEvents', $itemElems);
    });