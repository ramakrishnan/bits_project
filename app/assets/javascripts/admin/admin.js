var Admin = function () {
	
	var page = function() {

	var initilize = function () {
		$("#available_placeholders div").click(selectPlaceholder);
		$("#add_placeholder").click(addPlaceholder);
		$("#save_page").click(collectPlaceholders);
	};
	
	var initPlaceWidget = function () {
		hideWidgetsOptions("");
		$("#placeholder").change(function(event) {
			var reqWidth = $("#placeholder option:selected").data("width")
			hideWidgetsOptions(reqWidth);
		});	
	};
	
	var hideWidgetsOptions = function(width) {
			$("#widget option").hide();
			$("#widget option[data-width="+width+"]").show();
			$("#widget").val("");		
	};
	
	var collectPlaceholders = function () {
		if (activeRowWidth() < 966) {
			alert("You have an incomplete row");
			return false;
		}
		var plaxeHolder = $("#placeholders");
		
		plaxeHolder.empty();
		var rows = $("#page_layout div.row");
		rows.each(function (rIndex, row) {
			rIndex++;
			$(row).find("div").each(function (cIndex, column) {
				$('<input>').attr({
				    type: 'hidden',
				    name: 'row['+rIndex+'][]',
				    value: $(column).data('template_id'),
				}).appendTo(plaxeHolder);				
			});
		});
		return confirm("Are you sure");	
	};
	
	var selectPlaceholder = function (event) {
		$("#available_placeholders").find(".selected").removeClass("selected");
			$(event.target).toggleClass("selected");
	};

	var addPlaceholder = function() {
		var layoutContiner = $("#page_layout");	
		var selected = $("#available_placeholders").find(".selected:first");
		
		if (activeRow().length == 0 || ((966 - activeRowWidth()) == 0 ) )  {
			layoutContiner.append("<div class='row'></div>");
			activeRow().append(selected.clone().removeClass("selected"));
		}
		else if ((966 - activeRowWidth()) >= selected.data("width"))  {
			activeRow().append(selected.clone().removeClass("selected"));
		}
		else {
			alert("Select proper");
		}
	};

	
	var activeRow = function () {
		return $("#page_layout").find("div.row:last");
	};
	
	var activeRowWidth = function() {
		var curWidth = 0;
		activeRow().children().each(function(index,element) {
		    curWidth += $(element).data("width");
		});
		curWidth += 8 * (activeRow().children().length - 1); 
		return curWidth;
	};
	
	return {
		initilize: initilize,
		initPlaceWidget: initPlaceWidget
		}	
	}();

	
return {
	page: page
};
}();
