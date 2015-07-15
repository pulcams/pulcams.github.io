function loadPlumb () {
    
    $("input[type='text']").each(function () {
        $(this).addClass("form-control");
    });
    $("textarea").each(function () {
        $(this).addClass("form-control");
    });
    
    var className;
    
    $("#resource-repeat > .xforms-repeat-item").each(function () {
        className = $(this).children().attr("typeof");
        $(this).addClass(className);
    });
    
    // list of possible anchor locations for the blue source element
    var sourceAnchors =[[0, 1, 0, 1],[0.25, 1, 0, 1],[0.5, 1, 0, 1],[0.75, 1, 0, 1],[1, 1, 0, 1]];
    
    var instance = window.instance = jsPlumb.getInstance({
        // set default anchors.  the 'connect' calls below will pick these up, and in fact setting these means
        // that you also do not need to supply anchor definitions to the makeSource or makeTarget functions.
        Anchors:[sourceAnchors, "TopCenter"],
        // drag options
        DragOptions: {
            cursor: "pointer", zIndex: 2000
        },
        // default to blue at source and green at target
        EndpointStyles:[ {
            fillStyle: "#0d78bc"
        }, {
            fillStyle: "#558822"
        }],
        // blue endpoints 7 px; green endpoints 11.
        Endpoints:[[ "Dot", {
            radius: 7
        }],[ "Dot", {
            radius: 11
        }]],
        // default to a gradient stroke from blue to green.  for IE provide all green fallback.
        PaintStyle: {
            gradient: {
                stops:[[0, "#0d78bc"],[1, "#558822"]]
            },
            strokeStyle: "#558822",
            lineWidth: 10
        }
    });
    
    
    
    //instance.Defaults.container = "resource-repeat";
    instance.setContainer($("#resource-repeat"));
    
    var basicType = {
        connector: "StateMachine",
        paintStyle: {
            strokeStyle: "red", lineWidth: 4
        },
        hoverPaintStyle: {
            strokeStyle: "blue"
        },
        overlays:[
        "Arrow"]
    };
    
    instance.registerConnectionType("basic", basicType);
    
    var forms = $("#resource-repeat > .xforms-repeat-item");
    
    instance.draggable(forms);
    
    tars = forms.children("div");
    
    console.log(tars);
    
    var connect = instance.getSelector(".connect");
    
    var $connects = $(".connect");
    
    console.log(connect);
    
    
    // suspend drawing and initialise.
    instance.batch(function () {
        
        instance.makeTarget(tars, {
            anchor: "TopCenter", // you could supply this if you want, but it was set in the defaults above.
            dropOptions: {
                hoverClass: "hover"
            },
            allowLoopback: false
        });
        
        instance.makeSource(connect, {
            //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
            maxConnections: -1
        });
    });
    
    
    
    var $container = $("#resource-repeat");
    
    
    
    $container.packery({
    });
    
    // get item elements, jQuery-ify them
    var $itemElems = $("#resource-repeat > .xforms-repeat-item");
    // make item elements draggable
    $itemElems.draggable();
    // bind Draggable events to Packery
    $container.packery('bindUIDraggableEvents', $itemElems);
    
    $container.packery('on', 'dragItemPositioned', function (pckryInstance, draggedItem) {
        if (typeof src !== "undefined" && typeof tar !== "undefined") {
            //instance.repaint(src.id);
            //instance.repaint(tar.id);
            //instance.repaintEverything();
            console.log(srcArray);
        }
    });
    $container.packery('on', 'layoutComplete', function (pckryInstance, laidOutItems) {
        //instance.repaintEverything();
        if (typeof src !== "undefined" && typeof tar !== "undefined") {
            //instance.repaint(src.id);
            //instance.repaint(tar.id);
        }
    });
    
    var lastItem;
    var newSource;
    
    $(document).on("click", ".xforms-trigger", function () {
        $container.packery();
        //console.log($connects[0]);
    });
    
    $(document).on("click", "span[oldid='trigger-new-resource'], #add-new", function () {
        
        GreenTurtle.attach(document);
        
        
        
        
        
        newSource = $(this).closest(".xforms-repeat-item").find(".connect");
        
        if (newSource.length != 0) {
            instance.makeSource(newSource, {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        }
        
        lastItem = $("#resource-repeat").children(".xforms-repeat-item").last();
        
        className = lastItem.children().attr("typeof");
        console.log(className);
        lastItem.removeClass("Work");
        lastItem.removeClass("Instance");
        lastItem.addClass(className);
        
        if (lastItem.hasClass("Annotation")) {
            lastItem.addClass("show");
        }
        
        instance.draggable(lastItem);
        lastItem.draggable();
        
        $(lastItem).find(".thumbs-up").empty();
        
        $container.packery("prepended", lastItem);
        $container.packery('bindUIDraggableEvents', lastItem);
        
        newSource = $(lastItem).find(".connect");
        if (newSource.length != 0) {
            instance.makeSource(newSource, {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        }
        instance.makeTarget(lastItem, {
            //anchor: "TopCenter",
            dropOptions: {
                hoverClass: "hover"
            }
        });
    });
    
    
    
    $(document).on("click", "span[oldid='trigger-show-subform-switch']", function () {
        
        $(this).closest(".xforms-repeat-item").height("auto");
        
        newSource = $(this).closest(".xforms-repeat-item").find(".connect");
        if (newSource.length != 0) {
            instance.makeSource(newSource, {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        }
        
        $container.packery();
    });
    
    $(document).on("click", "span[oldid='trigger-hide-subform-switch']", function () {
        
        $(this).closest(".xforms-repeat-item").height("auto");
        
        newSource = $(this).closest(".xforms-repeat-item").find(".connect");
        if (newSource.length != 0) {
            instance.makeSource(newSource, {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        }
        
        $container.packery();
    });
    
    
    $(document).on("click", ".resource-repeat", function () {
        $(".connect").each(function () {
            instance.makeSource($(this), {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        });
    });
    
    $(document).on("click", ".trigger-show-resource", function () {
        console.log(document.data.graph);
        $container.packery();
    });
    
    $(document).on("click", ".trigger-hide-resource", function () {
        
        $container.packery();
    });
    
    
    $(document).on("click", "#toggle-hide-plumbing", function () {
        $("._jsPlumb_endpoint").addClass("hiding");
        //$("svg").attr("class", "hiding");
    });
    
    $(document).on("click", "#toggle-show-plumbing", function () {
        $("._jsPlumb_endpoint").removeClass("hiding");
        $("svg").attr("class", "showing");
    });
    
    
    $(document).on("click", "._jsPlumb_endpoint", function () {
        $(this).siblings("svg").toggle();
    });
    
    $(document).on("click", ".resource", function (event) {
        $(this).addClass('highlight').removeClass('background').siblings().removeClass('highlight').addClass('background');
        if (typeof src !== "undefined" && typeof tar !== "undefined") {
            for (var i = 0; i < srcArray.length; i++) {
                instance.repaint(srcArray[i].srcId);
                instance.repaint(srcArray[i].tarId);
            }
        }
    });
    
    var i2w;
    var hm2i;
    var hi2hm;
    var a2w;
    var srcArray =[];
    //var tarArray = new Array();
    var src;
    var tar;
    var initWork = $("#work-repeat").children(".xforms-repeat-item").attr("id");
    var initInstance = $("#instance-repeat").children(".xforms-repeat-item").attr("id");
    var initHeldMaterial = $("#heldmaterial-repeat").children(".xforms-repeat-item").attr("id");
    var initHeldItem = $("#helditem-repeat").children(".xforms-repeat-item").attr("id");
    var initAnnotation = $("#annotation-repeat").children(".xforms-repeat-item").attr("id");
    
    // and finally connect a couple of small windows, just so its obvious what's going on when this demo loads.
    /*
    i2w = instance.connect({
    source: initInstance, target: initWork
    });
    hm2i = instance.connect({
    source: initHeldMaterial, target: initInstance
    });
    hi2hm = instance.connect({
    source: initHeldItem, target: initHeldMaterial
    });
    a2w = instance.connect({
    source: initAnnotation, target: initWork
    });
    
    var i = $(i2w.source).closest(".xforms-repeat-item").index();
    
    srcArray.push({
    srcNode: i2w.source,
    srcId: i2w.source.id,
    srcIndex: i
    });
     */
    
    var subj =[];
    var srcIndex;
    var subjCount = 1;
    
    $(document).on("click", ".work-subject-add", function () {
        subjCount++;
    });
    
    $(document).on("click", ".work-subject-rm", function () {
        subjCount--;
    });
    
    var text;
    
    instance.bind("connection", function (info, originalEvent) {
        src = info.source;
        tar = info.target;
        
        //$(src).attr("resource", $(tar).attr("resource"));
        
        var srcParentIndex = $(src).closest(".xforms-switch").parent().parent().index();
        
        //var subjTest = $(src).parents(".work-subject");
        
        console.log(src);
        console.log(tar);
        console.log(srcParentIndex);
        console.log(subjCount);
        
        
        if ($(".work-subject").children().length > 2) {
            srcIndex = $(src).closest(".form-group").index() + $(src).parent().index();
            console.log(srcIndex);
        } else {
            srcIndex = $(src).closest(".form-group").index();
            console.log(srcIndex);
        }
        var dataTest = $(src).parent().parent()[0];
        //console.log(dataTest.data.getValues("isb")[0]);
        
        document.data.implementation.attach(document);
        
        document.data.setMapping("bf", "http://bibframe.org/vocab/");
        
        var works = document.getElementsByType("bf:Text");
        for (var i = 0; i < works.length; i++) {
            console.log(works[i].data.getValues("http://id.loc.gov/vocabulary/relators/isb")[0]);
        }
        
        
        console.log(works);
        
        //console.log(document.data.getSubject(text));
        console.log(document.data.graph);
        
        srcArray.push({
            srcNode: src,
            srcId: src.id,
            srcParentIndex: srcParentIndex,
            srcIndex: srcIndex,
            subjCount: subjCount,
            tarId: tar.id
        });
        
        /*
        console.log(subj);
        console.log(srcIndex);
        console.log(src.id);
        console.log(subjCount);
        console.log(srcIndex - subjCount);
         */
        //console.log(srcArray);
        
        getSourceTargetInfo(src, tar, srcParentIndex, srcIndex, "add");
        $("svg").attr("class", "hiding");
        instance.repaintEverything();
    });
    
    var cId =[];
    
    $(document).on("click", ".detach-plumb", function () {
        console.log($(this));
        
        $(this).siblings(".connect").each(function () {
            var srcMatch = detachConnector($(this).attr("id"), srcArray);
            
            console.log($(this).attr("id"));
            console.log(srcArray);
            
            /*
            if (typeof srcMatch !== "undefined") {
            if ($("#" + srcMatch.srcId).hasClass("connect-subject")) {
            if (subjCount > srcMatch.subjCount) {
            var offset = subjCount - srcMatch.subjCount;
            srcMatch.srcIndex += offset;
            }
            }
            
            getSourceTargetInfo(srcMatch.srcNode, null, srcMatch.srcParentIndex, srcMatch.srcIndex, "remove");
            instance.detachAllConnections(srcMatch.srcId);
            $("#" + srcMatch.tarId).children(".thumbs-up").empty();
            //instance.repaintEverything();
            
            console.log(srcMatch.srcId);
            } else {
            
            var ctr = $(this).siblings(".connected-to-resource").text();
            $(".connect-id").each(function () {
            if ($(this).children(".current-id").text() == ctr) {
            $(this).siblings(".thumbs-up").empty();
            }
            });
            getSourceTargetInfo(null, $(this).siblings(".connected-to-resource"), null, null, "remove");
            }
             */
        });
        var ctr = $(this).siblings(".connected-to-resource").text();
        
        var cId = $(".xforms-repeat-item").children().children(".connect-id").children(".current-id");
        console.log(cId);
        for (i = 0; i < cId.length; i++) {
            
            console.log(ctr);
            console.log($(cId[i]).text());
            
            if ($(cId[i]).text() === ctr) {
                console.log($(cId[i]).text());
                $(cId[i]).parent().prev(".thumbs-up").empty();
                console.log($(cId[i]).parent().prev(".thumbs-up"));
            }
        }
        
        
        
        
        
        
        
        /*
        $(".connect-id").each(function () {
        
        if ($(this).find(".current-id").text() == ctr) {
        console.log(ctr);
        $(this).prev(".thumbs-up").empty();
        }
        });
         */
        
        getSourceTargetInfo(null, $(this).siblings(".connected-to-resource"), null, null, "remove");
        
        
        
        
        
        
        
        //console.log(srcArray[i].srcNode.id.substring(0, 15));
        //console.log(srcArray[i].srcIndex);
        //console.log(subjCount);
        //console.log($(srcArray[i].srcNode).attr("oldid"));
    });
    
    
    function detachConnector(detach, src) {
        for (var i = 0;
        i < src.length;
        i++) {
            if (detach == src[i].srcId) {
                return src[i];
            }
        }
    }
    
    
    
    function getSourceTargetInfo(source, target, parentInt, int, action) {
        
        if (source == null) {
            // Get current XForms model
            var model = document.getElementById("bf-model");
            
            var instanceNameVal = "all";
            
            var instanceDoc = model.getInstanceDocument(instanceNameVal);
            
            var targetURI = $(target).text();
            
            console.log(target);
            
            var getParentName = $(target).siblings(".connect-id").children(".instance-name").children(".xforms-control").find(".xforms-value").text();
            
            var getParentNode = instanceDoc.getElementsByTagNameNS("*", getParentName);
            
            console.log(getParentNode[0]);
            
            for (var i = 0;
            i < getParentNode[0].childNodes.length;
            i++) {
                if (getParentNode[0].childNodes[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource") != null) {
                    if (getParentNode[0].childNodes[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource").nodeValue !== "") {
                        if (targetURI == getParentNode[0].childNodes[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource").nodeValue) {
                            break;
                        }
                    }
                }
            }
            var node = getParentNode[0].childNodes[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
            console.log(node);
            
            var value = "";
            
            
            // Update XForms instance with link
            XsltForms_globals.openAction();
            
            // Pass in node and value
            XsltForms_browser.setValue(node, value || "");
            document.getElementById(XsltForms_browser.getMeta(node.ownerDocument.documentElement, "model")).xfElement.addChange(node);
            // Output to debug console
            // XsltForms_browser.debugConsole.write("Setvalue " + XsltForms_browser.name2string(node) + " = " + value);
            // Must refresh the form
            
            XsltForms_globals.refresh();
            XsltForms_globals.closeAction();
        } else {
            
            
            
            // Get current XForms model
            var model = document.getElementById("bf-model");
            
            // Get name of current instance to link from
            //var instanceName = $(source).siblings(".connect-id").children(".instance-name").children(".xforms-control").find(".xforms-value");
            //var instanceNameVal = instanceName[0].childNodes[0].nodeValue;
            var instanceNameVal = "all";
            
            // Get instance doc
            var instanceDoc = model.getInstanceDocument(instanceNameVal);
            
            // Get parent
            var getParentName = $(source).siblings(".connect-id").children(".instance-name").children(".xforms-control").find(".xforms-value").text();
            
            //console.log(getParentName);
            //console.log(parentInt);
            //console.log(int);
            
            //var getParentNode = instanceDoc.getElementsByTagNameNS("*", getParentName);
            
            //console.log(getParentNode);
            
            //var instanceEl = getParentNode[parentInt];
            
            var instanceEl = instanceDoc.childNodes[0].childNodes[parentInt];
            
            console.log(instanceEl);
            
            // Get name of current property
            var instancePropName = $(source).siblings(".connect-id").children(".prop-name").children(".xforms-control").find(".xforms-value");
            
            var instancePropNameVal = instancePropName[0].childNodes[0].nodeValue;
            
            // Select property element in instance doc
            //var instanceProp = instanceEl.getElementsByTagNameNS("*", instancePropNameVal);
            var instanceProp = instanceEl.childNodes[ int];
            //var instancePropRdfResource = new Array();
            
            console.log(instanceProp);
            
            var node;
            //var propLength = instanceProp.length;
            
            //for (var i = 0; i < propLength; i++) {
            //    if (! instanceProp[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource")) break;
            //node = instanceProp[int].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
            node = instanceProp.getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
            //}
            
            // Get target URI to insert link
            if (target != null) {
                var targetId = $(target).find(".connect-id").children(".current-id").children(".xforms-control").find(".xforms-value");
                console.log(targetId);
                var targetIdVal = targetId[0].childNodes[0].nodeValue;
            }
            
            
            
            // Select @rdf:resource attribute to modify with target URI
            //var node = instancePropNode.getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
            
            //   if (!node.trim()) {
            //    instanceProp2 = instanceDoc.getElementsByTagNameNS("*", instancePropNameVal)[1];
            //    node = instanceProp2.getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
            //   }
            
            
            // Pass in the value of target URI on "connection," else an empty string when detached
            if (action == "add") {
                var value = targetIdVal;
                $(target).find(".thumbs-up").text("\uD83D\uDC4D");
            } else {
                var value = "";
                $(target).find(".thumbs-up").text("");
            }
            
            //console.log(parentInt);
            //console.log(instanceProp);
            
            
            //console.log($(model));
            //console.log(instanceDoc);
            console.log(node);
            console.log(source);
            console.log(target);
            
            
            
            
            
            // Update XForms instance with link
            XsltForms_globals.openAction();
            
            // Pass in node and value
            XsltForms_browser.setValue(node, value || "");
            document.getElementById(XsltForms_browser.getMeta(node.ownerDocument.documentElement, "model")).xfElement.addChange(node);
            // Output to debug console
            // XsltForms_browser.debugConsole.write("Setvalue " + XsltForms_browser.name2string(node) + " = " + value);
            // Must refresh the form
            
            XsltForms_globals.refresh();
            XsltForms_globals.closeAction();
        }
    }
    
    function workTitle(title) {
        var i = title.indexOf(" ");
        var str = title.substring(0, i);
        switch (str) {
            case "El":
            case "La":
            case "Los":
            case "Las":
            case "Un":
            case "Una":
            case "Unos":
            case "Unas":
            case "The":
            case "A":
            case "An":
            var l = str.length;
            var newTitle = title.substring(l + 1);
            var newTitleCap = newTitle.substring(0, 1).toUpperCase();
            title = newTitleCap.concat(newTitle.substring(1));
            return title;
            break;
            default:
            return title;
        }
    }
    
    function savePlumb() {
        /*
        var nodes =[]
        
        $(".resource").each(function (idx, elem) {
        var $elem = $(elem);
        var endpoints = jsPlumb.getEndpoints($elem.attr('id'));
        //console.log('endpoints of ' + $elem.attr('id'));
        //console.log(endpoints);
        nodes.push({
        blockId: $elem.attr('id'),
        nodetype: $elem.attr('data-nodetype'),
        nodeName: $elem.prop("tagName"),
        positionX: parseInt($elem.css("left"), 10),
        positionY: parseInt($elem.css("top"), 10)
        });
        });
         */
        
        
        var connections =[];
        $.each(jsPlumb.getConnections(), function (idx, connection) {
            connections.push({
                connectionId: connection.id,
                pageSourceId: connection.sourceId,
                //parentId: document.getElementById(connection.sourceId).parentNode.id,
                pageTargetId: connection.targetId
            });
        });
        
        var plumbData = {
        };
        //plumbData.nodes = nodes;
        plumbData.connections = connections;
        //plumbData.numberOfElements = numberOfElements;
        
        //var plumbDataJson = JSON.stringify(plumbData);
        //console.log(plumbData.connections[0].pageTargetId);
        
        return plumbData;
        
        //$('#jsonOutput').val(plumbDataJson);
    }
}