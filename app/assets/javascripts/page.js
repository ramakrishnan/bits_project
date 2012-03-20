var Page = function () {
	var initFourSlider = function(event) {
		var slide = 4;
		var target = $(event.currentTarget);
		slideItems(slide, target);
	};
	
	var slideItems = function(slide, target) {
		var direction = target.hasClass("slide_right") ? "right" : "left";
		var container = target.parent().parent().next();
		var totalItems = container.children().length;
		var item = container.children().first();
		var width = item.outerWidth();
		var currentLeft = parseInt(container.css("left"),10);
		
		var hasMoreItems = ( (currentLeft/width) + totalItems > 4 );
		if (direction == "right" && currentLeft == 0) {
			return;
		}
		else if (direction == "left" && !hasMoreItems ) {
			return
		}
		currentLeft+= direction == "left" ? (-1)*width : width
		container.animate(
    		{ left: currentLeft },
    		{ duration: 'slow' });
	};
	return {
		initFourSlider: initFourSlider
	}
}();	