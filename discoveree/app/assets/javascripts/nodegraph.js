<<<<<<< HEAD
if($"#viewport").visible() == true){
=======
$(document).ready(function(){

	if($("#viewport").is(":visible") == true){
>>>>>>> upstream/master
	alert("JQuery Connected, Arbor.js Connected");

	var sys = arbor.ParticleSystem(1000, 30, 40)
	sys.parameters({gravity:true})
	sys.renderer = Renderer("#viewport");

	function nodeCreate(node_array){
	parentNode = sys.addNode(node_array[1],{'color':'blue', 'shape':'dot', 'label': node_array[1]});
	 for(i=1;i<node_array.length;i++){
		var childNode = sys.addNode(node_array[i],{'color':'blue', 'shape':'dot', 'label':node_array[i]});
		sys.addEdge(parentNode,childNode);
	 };
	};

	 $.ajax({
	 	url:"/categories/nodegraph",
	 	type: "get",
	 	success: function(data) {
	 		node_array = data['related_categories'];
	 		nodeCreate(node_array)
	 	}
	 });
	// var red = sys.addNode('Red',{'color':'red', 'shape':'dot', 'label':'red'});
	// var blue = sys.addNode('Blue',{'color':'blue', 'shape':'dot', 'label':'blue'});
	// 	sys.addEdge(red, blue);

	// var green = sys.addNode('Green',{'color':'green', 'shape': 'dot', 'label':'green', 'link':"http://www.wikipedia.org/"});
	// 	sys.addEdge(red, green);
<<<<<<< HEAD

};
=======
	};
});
>>>>>>> upstream/master
