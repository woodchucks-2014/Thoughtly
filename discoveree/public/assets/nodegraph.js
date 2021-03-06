$(document).ready(function() {

    if ($("#viewport").is(":visible") == true) {
        var sys = arbor.ParticleSystem(20, 2000, .3 )
        sys.parameters({
            gravity: true
        })
        sys.renderer = Renderer("#viewport");

        function nodeCreate(parentNode, childNodes) {
            parentNode = sys.addNode(parentNode, {
                'color': 'goldenrod',
                'shape': 'rectangle',
                'label': parentNode
            });

            for (i = 0; i < childNodes.length; i++) {
                var childNode = sys.addNode(childNodes[i], {
                    'color': 'goldenrod',
                    'shape': 'rectangle',
                    'label': childNodes[i]
                });
                sys.addEdge(parentNode, childNode);
            };

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
                nodeCreate(data["main_category"], data['related_categories'])
            }
        }); // closes ajax

    }; //closes if viewport statment

}); //closes document ready function
