$(document).ready(function() {

    if ($("#viewport").is(":visible") == true) {

        var sys = arbor.ParticleSystem(1000, 30, 40)
        sys.parameters({
            gravity: true
        })
        sys.renderer = Renderer("#viewport");

        function nodeCreate(parentNode, childNodes) {
            parentNode = sys.addNode(parentNode, {
                'color': 'blue',
                'shape': 'dot',
                'label': parentNode
            });
            console.log(childNodes);
            for (i = 0; i < childNodes.length; i++) {
                var childNode = sys.addNode(childNodes[i], {
                    'color': 'blue',
                    'shape': 'dot',
                    'label': childNodes[i]
                });
                console.log(childNode)
                sys.addEdge(parentNode, childNode);
            };
        };

        // $(sys).mousedown(function(e) {
        //     var pos = $(this).offset();
        //     var p = {
        //         x: e.pageX - pos.left,
        //         y: e.PageY - pos.top
        //     }
        //     selected = nearest = dragged = particleSystem.nearest(p);

        //     if (selected.node !== null) {
        //         dragged.node.fixed = true;
        //     }
        //     return false;
        // });


        function childNodeCreate(main_node, childnodes) {
            $('Node').click(function() {
                alert("Shuff");
            });
        };

        $.ajax({
            url: "/categories/nodegraph",
            beforeSend: function(xhr) {
                xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            },
            type: "post",
            dataType: 'json',
            data: {
                "name": $("#category_name").text()
            },
            success: function(data) {
                console.log(data)
                nodeCreate(data["main_category"], data['related_categories'])
            }
        }); // closes ajax

    }; //closes if viewport statment


    $.ajax({
        url: "/categories/childnodes",
        type: "get",
        success: function(data) {
            childNodeCreate(data)
        }
    });

}); //closes document ready function