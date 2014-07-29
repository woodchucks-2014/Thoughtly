$(document).ready(function() {

    if ($("#viewport").is(":visible") == true) {
        var sys = arbor.ParticleSystem(937, 20, 40)
        sys.parameters({
            gravity: true
        })
        sys.renderer = Renderer("#viewport");

        function nodeCreate(parentNode, childNodes) {
            parentNode = sys.addNode(parentNode, {
                'color': 'blue',
                'shape': 'square',
                'label': parentNode
            });

            for (i = 0; i < childNodes.length; i++) {
                var childNode = sys.addNode(childNodes[i], {
                    'color': 'blue',
                    'shape': 'square',
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