$(document).ready(function(){
	alert("JQuery Connected, Arbor.js Connected");

	 $.ajax({
	 	url:"/categories/nodegraph",
	 	type: "get",
	 	success: function(data) {
	 		node_array = data['related_categories'];
	 	}
	 })


	var sys = arbor.ParticleSystem(50, 30, 40)
	sys.parameters({gravity:true})
	sys.renderer = Renderer("#viewport");

	// for(i=0;i<node_array.length;)

	// var red = sys.addNode('Red',{'color':'red', 'shape':'dot', 'label':'red'});
	// var blue = sys.addNode('Blue',{'color':'blue', 'shape':'dot', 'label':'blue'});
	// 	sys.addEdge(red, blue);

	// var green = sys.addNode('Green',{'color':'green', 'shape': 'dot', 'label':'green', 'link':"http://www.wikipedia.org/"});
	// 	sys.addEdge(red, green);

});
