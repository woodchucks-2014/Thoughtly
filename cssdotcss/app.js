$(document).ready(function() {

        		var Overlay = function(removeButton, overLay, arrowDown) {
        			this.removeButton = $(removeButton);
        			this.overLay = $(overLay);
        			this.arrowDown = $(arrowDown);
        		}

        		Overlay.prototype.raiseOverlay = function(){
        			this.overLay.addClass("active");
        			this.arrowDown.css("display", "block");
						}

						Overlay.prototype.lowerOverlay = function(){
							this.overLay.removeClass("active");
							this.arrowDown.fadeOut(100);
						}

        		myOverlay = new Overlay('#remove-button', '#overlay', '#arrow-down')

        		myOverlay.removeButton.click(function() {
        			myOverlay.raiseOverlay();
        		})

       			myOverlay.arrowDown.click(function(){
       				myOverlay.lowerOverlay();
       			})
       			