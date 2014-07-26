$(window).on("scroll", function () {
          if ($(this).scrollTop() > 15) { //Any number you want
              $("header").fadeIn().removeClass("show");
          }
          else {
              $("header").fadeOut().addClass("show");
          }