var Page = function () {
	var initFourSlider = function(event) {
		var slide = 4;
		var target = $(event.currentTarget);
		slideItems(slide, target);
	};
	
	var slideItems = function(slide, target) {
		var direction = target.hasClass("slide_right") ? "right" : "left";
		var container = target.parents().find(".widget_title").next();
		var totalItems = container.children().length;
		var item = container.children().first();
		var width = parseInt(item.css("width"),10);
		var currentLeft = parseInt(container.css("left"),10);
		var hasMoreItems = ( (currentLeft/width) + totalItems > 4 );
		if (direction == "right" && currentLeft == 0) {
			return;
		}
		else if (direction == "left" && !hasMoreItems ) {
			return
		}
		currentLeft+= direction == "left" ? (-1)*width : width
		container.css("left",currentLeft);
	};
	return {
		initFourSlider: initFourSlider
	}
}();	