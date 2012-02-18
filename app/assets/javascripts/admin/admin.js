var Admin = function () {
	var selectPlaceholder = function (event) {
			$("#available_placeholders").find(".selected").removeClass("selected");
			$(event.target).toggleClass("selected");
	};

	var addPlaceholder = function() {
		var layoutContiner = $("#page_layout");	
		var selected = $("#available_placeholders").find(".selected:first");
		
		if (activeRow().length == 0 || ((966 - activeRowFree()) == 0 ) )  {
			layoutContiner.append("<div class='row'></div>");
			activeRow().append(selected.clone().removeClass("selected"));
		}
		else if ((966 - activeRowFree()) >= selected.data("width"))  {
			activeRow().append(selected.clone().removeClass("selected"));
		}
		else {
			console.log("Select proper");
		}
	};

	
	var activeRow = function () {
		return $("#page_layout").find("div.row:last");
	};
	
	var activeRowFree = function() {
		var curWidth = 0;
		activeRow().children().each(function(index,element) {
		    curWidth += $(element).data("width");
		});
		curWidth += 8 * (activeRow().children().length - 1); 
		return curWidth;
	};
	
return {
	selectPlaceholder: selectPlaceholder,
	addPlaceholder: addPlaceholder
};
}();
