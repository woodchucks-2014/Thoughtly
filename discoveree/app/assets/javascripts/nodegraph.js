$(document).ready(function(){

	alert("JQuery Connected, Arbor.js Connected");

	var sys = arbor.ParticleSystem(50, 30, 40)
	sys.parameters({gravity:true})
	sys.renderer = Renderer("#viewport");

	var red = sys.addNode('Red',{'color':'red', 'shape':'dot', 'label':'red'});
	var blue = sys.addNode('Blue',{'color':'blue', 'shape':'dot', 'label':'blue'});
		sys.addEdge(red, blue);

	nodes:{"shuff":{color:CLR.branch, shape:"dot", alpha:1},{"soghoian":{color:CLR.branch, shape:"dot", alpha:1}, {"baer":{color:CLR.branch, shape:"dot", alpha:1}}

	var green = sys.addNode('Green',{'color':'green', 'shape': 'dot', 'label':'green', 'link':"http://www.wikipedia.org/"});
		sys.addEdge(red, green);



});