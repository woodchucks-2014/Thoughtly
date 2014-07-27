$(window).on("scroll", function () {
  if ($(this).scrollTop() > 15) {
      $("header").fadeIn().removeClass("show");
  }
  else {
      $("header").fadeOut().addClass("show");
  }
});          