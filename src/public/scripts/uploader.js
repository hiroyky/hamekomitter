/**
 * @file uploader.js
 * @author Hirokazu Yokoyama
 * */

$(document).ready(function() {
	$("#UploadSubmitButton").bind("click", uploadImageFile);
});


var uploadEnteredImageFile = function() {
	
		
	var form = new FormData($("form")[0]);
	$.ajax({
		url: $("#UploadForm").attr("action"),
		type: 'POST',
//		csrfmiddlewaretoken: csrf,
		processData: false,
		contentType: false,
		data: form,
		dataType: 'json',
		success: function(jsonData) {
			var data = $.parseJSON(jsonData);
			
		},
		error: function(data) {
			alert(data.toString());
		}
	});
	
	$("#ResultView").html(string.loading);
	return false;
};

/**
 * 
 * */
var showCreatedImage = function(data) {
	var img = document.createElement("img");
	$(img).attr("", "");
	$("#ResultView")
}
