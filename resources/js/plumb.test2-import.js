jsPlumb.ready(function () {
    
    $("input[type='text']").each(function () {
        $(this).addClass("form-control");
    });
    $("textarea").each(function () {
        $(this).addClass("form-control");
    });
    /*
    $("#content").children(".xforms-repeat").each(function () {
    $(this).addClass("hiding");
    });
     */
    $(document).on("click", "#toggle-hide-work-content", function () {
        $(".work").addClass("hiding");
        instance.hide(".work", true);
    });
    $(document).on("click", "#toggle-show-work-content", function () {
        $(".work").removeClass("hiding");
        instance.show(".work");
    });
    $(document).on("click", "#toggle-hide-instance-content", function () {
        $(".instance").addClass("hiding");
        instance.hide(".instance", true);
    });
    $(document).on("click", "#toggle-show-instance-content", function () {
        $(".instance").removeClass("hiding");
        instance.show(".instance");
    });
    $(document).on("click", "#toggle-hide-heldmaterial-content", function () {
        $(".heldmaterial").addClass("hiding");
        instance.hide(".heldmaterial", true);
    });
    $(document).on("click", "#toggle-show-heldmaterial-content", function () {
        $(".heldmaterial").removeClass("hiding");
        instance.show(".heldmaterial");
    });
    $(document).on("click", "#toggle-hide-helditem-content", function () {
        $(".helditem").addClass("hiding");
        instance.hide(".helditem", true);
    });
    $(document).on("click", "#toggle-show-helditem-content", function () {
        $(".helditem").removeClass("hiding");
        instance.show(".helditem");
    });
    $(document).on("click", "#toggle-hide-annotation-content", function () {
        $(".annotation").addClass("hiding");
        instance.hide(".annotation", true);
    });
    $(document).on("click", "#toggle-show-annotation-content", function () {
        $(".annotation").removeClass("hiding");
        instance.show(".annotation");
    });
    $(document).on("click", "#toggle-hide-topic-content", function () {
        $(".topic").addClass("hiding");
        instance.hide(".topic", true);
    });
    $(document).on("click", "#toggle-show-topic-content", function () {
        $(".topic").removeClass("hiding");
        instance.show(".topic");
    });
    $(document).on("click", "#toggle-hide-place-content", function () {
        $(".place").addClass("hiding");
        instance.hide(".place", true);
    });
    $(document).on("click", "#toggle-show-place-content", function () {
        $(".place").removeClass("hiding");
        instance.show(".place");
    });
    $(document).on("click", "#toggle-hide-temporal-content", function () {
        $(".temporal").addClass("hiding");
        instance.hide(".temporal", true);
    });
    $(document).on("click", "#toggle-show-temporal-content", function () {
        $(".temporal").removeClass("hiding");
        instance.show(".temporal");
    });
    $(document).on("click", "#toggle-hide-person-content", function () {
        $(".person").addClass("hiding");
        instance.hide(".person", true);
    });
    $(document).on("click", "#toggle-show-person-content", function () {
        $(".person").removeClass("hiding");
        instance.show(".person");
    });
    $(document).on("click", "#toggle-hide-family-content", function () {
        $(".family").addClass("hiding");
        instance.hide(".family", true);
    });
    $(document).on("click", "#toggle-show-family-content", function () {
        $(".family").removeClass("hiding");
        instance.show(".family");
    });
    $(document).on("click", "#toggle-hide-jurisdiction-content", function () {
        $(".jurisdiction").addClass("hiding");
        instance.hide(".jurisdiction", true);
    });
    $(document).on("click", "#toggle-show-jurisdiction-content", function () {
        $(".jurisdiction").removeClass("hiding");
        instance.show(".jurisdiction");
    });
    $(document).on("click", "#toggle-hide-meeting-content", function () {
        $(".meeting").addClass("hiding");
        instance.hide(".meeting", true);
    });
    $(document).on("click", "#toggle-show-meeting-content", function () {
        $(".meeting").removeClass("hiding");
        instance.show(".meeting");
    });
    $(document).on("click", "#toggle-hide-organization-content", function () {
        $(".organization").addClass("hiding");
        instance.hide(".organization", true);
    });
    $(document).on("click", "#toggle-show-organization-content", function () {
        $(".organization").removeClass("hiding");
        instance.show(".organization");
    });
    $(document).on("click", "#toggle-hide-identifier-content", function () {
        $(".identifier").addClass("hiding");
        instance.hide(".identifier", true);
    });
    $(document).on("click", "#toggle-show-identifier-content", function () {
        $(".identifier").removeClass("hiding");
        instance.show(".identifier");
    });
    $(document).on("click", "#toggle-hide-provider-content", function () {
        $(".provider").addClass("hiding");
        instance.hide(".provider", true);
    });
    $(document).on("click", "#toggle-show-provider-content", function () {
        $(".provider").removeClass("hiding");
        instance.show(".provider");
    });
    $(document).on("click", "#toggle-hide-title-content", function () {
        $(".title").addClass("hiding");
        instance.hide(".title", true);
    });
    $(document).on("click", "#toggle-show-title-content", function () {
        $(".title").removeClass("hiding");
        instance.show(".title");
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
    
    instance.setContainer(document.getElementById("content"));
    
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
    
    var forms = $(".select").children(".xforms-repeat-item").children(".xforms-repeat").children(".xforms-repeat-item");
    
    $(document).on("click", ".select.xforms-repeat-item.xforms-repeat.xforms-repeat-item", function () {
        var dragForm = $(this).css({
            "float": "none", "position": "absolute"
        });
        console.log(dragForm);
        instance.draggable(dragForm);
    });
    
    instance.draggable(forms);
    
    var connect = instance.getSelector(".connect");
    
    // suspend drawing and initialise.
    instance.batch(function () {
        
        instance.makeSource(connect, {
            //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
            
            //maxConnections: -1
        });
        
        instance.makeTarget(forms, {
            anchor: "TopCenter", // you could supply this if you want, but it was set in the defaults above.
            dropOptions: {
                hoverClass: "hover"
            },
            allowLoopback: false
        });
    });
    
    var lastItem;
    var lastItemIndex;
    var newSource;
    
    $(document).on("click", "#add-new", function () {
        
        $(".select").each(function () {
            $(this).children(".xforms-repeat-item").each(function () {
                lastItem = $(this).last();
                lastItemIndex = $(lastItem).index();
            });
            newSource = $(lastItem).children(".xforms-switch").children(".xforms-case").children(".form-group").find(".connect");
            instance.draggable(lastItem);
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
    });
    
    
    $(document).on("click", ".resource-repeat", function () {
        $(".connect").each(function () {
            instance.makeSource($(this), {
                //anchor: "TopCenter" // you could supply this if you want, but it was set in the defaults above.
                
                //maxConnections: -1
            });
        });
        instance.repaintEverything();
    });
    
    $(document).on("click", ".repaint", function () {
        instance.repaintEverything();
    });
    
    
    $(document).on("click", "#toggle-hide-plumbing", function () {
        $("._jsPlumb_endpoint").addClass("hiding");
        $("svg").attr("class", "hiding");
    });
    
    $(document).on("click", "#toggle-show-plumbing", function () {
        $("._jsPlumb_endpoint").removeClass("hiding");
        $("svg").attr("class", "showing");
    });
    
    /*
    $(document).on("click", ".toggle-hide-resource", function () {
    $("._jsPlumb_endpoint").addClass("hiding");
    $("svg path").attr("class", "hiding");
    });
    
    $(document).on("click", ".toggle-show-resource", function () {
    $("._jsPlumb_endpoint").removeClass("hiding");
    $("svg path").attr("class", "_jsPlumb_connector");
    });
     */
    
    $(document).on("click", "._jsPlumb_endpoint", function () {
        $(this).siblings("svg").toggle();
    });
    
    var startPos =[];
    
    
    $(".select").delegate(".xforms-repeat-item .xforms-repeat .jsplumb-draggable", "dblclick", function () {
        
        $(this).addClass("highlight").siblings().removeClass("highlight").addClass("background");
        
        var dragItem = $(".highlight");
        $(dragItem).offset({
            top: 400, left: 430
        });
        instance.repaintEverything();
        
        /*
        var pos = $(dragItem).offset();
        
        $(window).scroll(function () {
        
        if ($(window).scrollTop() > pos.top) {
        $(dragItem).offset({
        top: 700, left: 430
        });
        } else {
        $(dragItem).offset({
        top: 200, left: 430
        });
        }
        });
         */
    });
    /*
    $(".jsplumb-draggable").each(function () {
    startPos.push({
    id: $(this).attr("id"),
    top: $(this).offset().top,
    left: $(this).offset().left
    });
    });
    $(document).on("dblclick", ".background", function () {
    
    for (var i = 0; i < startPos.length; i++) {
    if ($(this).attr("id") == startPos[i].id) {
    console.log(startPos[i].id);
    $(this).offset({
    top: startPos[i].top, left: startPos[i].left
    });
    }
    }
    });
     */
    
    
    
    /*
    $(".select").children(".xforms-repeat-item").children(".xforms-repeat").children(".xforms-repeat-item").on('dblclick', function (event) {
    $(this).addClass('highlight').siblings().removeClass('highlight');
    $(this).offset({top: 200, left: 430});
    
    });
     */
    
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
    
    instance.bind("connection", function (info, originalEvent) {
        src = info.source;
        tar = info.target;
        
        var srcParentIndex = $(src).closest(".xforms-switch").parent().index();
        
        var subjTest = $(src).parents(".work-subject");
        
        if (subjTest.length != 0) {
            srcIndex = $(src).closest(".xforms-repeat-item").index() + subjCount;
        } else {
            srcIndex = $(src).closest(".xforms-repeat-item").index();
        }
        
        srcArray.push({
            srcNode: src,
            srcId: src.id,
            srcParentIndex: srcParentIndex,
            srcIndex: srcIndex,
            subjCount: subjCount
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
    
    $(document).on("click", ".detach-plumb", function () {
        $(this).siblings(".connect").each(function () {
            var srcMatch = detachConnector($(this).attr("id"), srcArray);
            if (typeof srcMatch !== "undefined") {
                if (srcMatch.srcId.substring(0, 15) == "connect-subject") {
                    if (subjCount > srcMatch.subjCount) {
                        var offset = subjCount - srcMatch.subjCount;
                        srcMatch.srcIndex += offset;
                    }
                }
                getSourceTargetInfo(srcMatch.srcNode, null, srcMatch.srcParentIndex, srcMatch.srcIndex, "remove");
                instance.detachAllConnections(srcMatch.srcId);
                instance.repaintEverything();
                
                console.log(srcMatch.srcId);
            }
        });
        
        
        //console.log(srcArray[i].srcNode.id.substring(0, 15));
        //console.log(srcArray[i].srcIndex);
        //console.log(subjCount);
        //console.log($(srcArray[i].srcNode).attr("oldid"));
    });
});

function detachConnector(detach, src) {
    for (var i = 0; i < src.length; i++) {
        if (detach == src[i].srcId) {
            return src[i];
        }
    }
}

function newResource() {
    
    
    
    
    
    var form = $("#results-repeat").children(".xforms-repeat-item-selected");
    $(form).addClass("select");
    var connect = $("#results-repeat").children(".xforms-repeat-item-selected").children(".xforms-repeat").children(".xforms-repeat-item").children(".connect");
    
    instance.draggable(form);
    
    //$('<div>').attr('id', 'state' + i).addClass('item');
    
    //var title = $('<div>').addClass('title').text('State ' + i);
    //var connect = $('<div>').addClass('connect');
    
    form.css({
        'top': e.pageY,
        'left': e.pageX
    });
    
    //newState.append(title);
    //newState.append(connect);
    
    //$('#content').append(newState);
    
    instance.makeTarget(form, {
        anchor: 'Continuous'
    });
    
    instance.makeSource(connect, {
        parent: form,
        anchor: 'Continuous'
    });
    
    /*
    instance.addEndpoint(connect, {
    connectionType: "basic",
    isSource: true
    });
     */
}


function getSourceTargetInfo(source, target, parentInt, int, action) {
    
    
    
    // Get current XForms model
    var model = document.getElementById("bf-model");
    
    // Get name of current instance to link from
    var instanceName = $(source).siblings(".connect-id").children(".instance-name").children(".xforms-control").find(".xforms-value");
    var instanceNameVal = instanceName[0].childNodes[0].nodeValue;
    
    // Get instance doc
    var instanceDoc = model.getInstanceDocument(instanceNameVal);
    
    var instanceEl = instanceDoc.childNodes[0].childNodes[parentInt];
    
    // Get name of current property
    var instancePropName = $(source).siblings(".connect-id").children(".prop-name").children(".xforms-control").find(".xforms-value");
    var instancePropNameVal = instancePropName[0].childNodes[0].nodeValue;
    
    // Select property element in instance doc
    var instanceProp = instanceEl.getElementsByTagNameNS("*", instancePropNameVal);
    //var instancePropRdfResource = new Array();
    var node;
    //var propLength = instanceProp.length;
    
    //for (var i = 0; i < propLength; i++) {
    //    if (! instanceProp[i].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource")) break;
    node = instanceProp[ int].getAttributeNodeNS("http://www.w3.org/1999/02/22-rdf-syntax-ns#", "resource");
    //}
    
    // Get target URI to insert link
    if (target != null) {
        var targetId = $(target).children(".xforms-switch").children(".xforms-case").children(".connect-id").children(".current-id").children(".xforms-control").find(".xforms-value");
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
    } else {
        var value = "";
    }
    
    //console.log(parentInt);
    //console.log(instanceProp);
    
    
    //console.log($(model));
    //console.log(instanceDoc);
    //console.log(node);
    //console.log(instancePropNameVal);
    //console.log(targetIdVal);
    
    
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

function savePlumb() {
    /*
    var nodes =[]
    
    $(".select").each(function (idx, elem) {
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