$(function(){
	$('#get_started').click(function(e){
		e.preventDefault();
		$.ajax({
			type: "GET",
			url: "/users/signup",
			data: $("form").serialize(),
			success: function(data){
				$("#welcome").html(data);
			}
		})
	})

	$('#welcome').on("click", '.event', function(e){
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

})
