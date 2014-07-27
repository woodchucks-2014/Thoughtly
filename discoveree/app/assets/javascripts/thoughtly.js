$(document).ready(function(){
	$("#sign_up").click(function(e){
		e.preventDefault();
		alert("Success");
	});
});


$(function(){
	$('#start').click(function(e){
		e.preventDefault();
		$.ajax({
			type: "GET",
			url: "/users/signup",
			data: $("form").serialize(),
			success: function(data){
				$("#welcome").html(data)
			}
		})
	})

	// $('.signin').click(function(e){
	// 	e.preventDefault();
	// 	$.ajax({
	// 		type: "GET",
	// 		url: "/users/signin",
	// 		data: $("form").serialize(),
	// 		success: function(data){
	// 			$("#welcome").html(data)
	// 		}
	// 	})
	// })







})
