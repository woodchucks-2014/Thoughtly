
// $(window).on("scroll", function () {
//   if ($(this).scrollTop() > 50) {
//       $("header").fadeIn("slow").removeClass("show");
//   }
//   else {
//       $("header").fadeOut("slow").addClass("show");
//   }
// });          


$(function(){
	$('#start').click(function(e){
		e.preventDefault();
		$.ajax({
			type: "GET",
			url: "/users/signup",
			data: $("form").serialize(),
			success: function(data){
				$("welcome").html("")
				$("#welcome").html(data)
			}
		})
	})
})