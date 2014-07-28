$(document).ready(function(){

	if($("#viewport").is(":visible") == true){

	var sys = arbor.ParticleSystem(1000, 30, 40)
	sys.parameters({gravity:true})
	sys.renderer = Renderer("#viewport");

	function nodeCreate(node_array){
	parentNode = sys.addNode(node_array[0],{'color':'blue', 'shape':'dot', 'label': node_array[1]});
	 for(i=0;i<node_array.length;i++){
		var childNode = sys.addNode(node_array[i],{'color':'blue', 'shape':'dot', 'label':node_array[i]});
		sys.addEdge(parentNode,childNode);
	 };
	};

	 $.ajax({
	 	url:"/categories/nodegraph",
	 	beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	 	type: "POST",
	 	dataType: 'json',
	 	data: {"name":$("#category_name").text()},
	 	success: function(data) {
	 		node_array = data['related_categories'];
	 		nodeCreate(node_array);
	 	}
	 });
	};
});
