$(function(){
	$('.container').click(function(){
	    $(this).animate({
	    	height: '6em'
	    }, 500);
	});
});	


$(function(){
	$('canvas').click(function(){
	    $(this).animate({
	    	height: $(window).height()
	    }, 500);
	});
});	