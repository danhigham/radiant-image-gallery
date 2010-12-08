$(document).ready(function (){
	$('a.modal').colorbox({width:"800", height:"600"});

	$('a.delete-image').click(function() {
		if (confirm('Remove image from collection?')) {
			var link = $(this);
		
			$.ajax({
	    		type: "POST",
	    		url: '/image_gallery/delete_image',
	    		data: {image_id: link.siblings("input").val()},
	    		dataType: "text",
	    		success: function(status){
					//remove item from list
			
					if (status == "1") {
						var list_item = link.parent().parent(); 
					
						list_item.hide({duration : 100});
						//Change this to remove on success event of list_item.hide
						list_item.remove();
					}
	  			}
	  		});
		}
	});
	
	$('a.delete-collection').click(function() {
		if (confirm('Remove image collection?')) {
			var link = $(this);
		
			$.ajax({
	    		type: "POST",
	    		url: '/image_gallery/delete_collection',
	    		data: {collection_id: link.siblings("input").val()},
	    		dataType: "text",
	    		success: function(status){
					//remove item from list
			
					if (status == "1") {
						var list_item = link.parent().parent(); 
					
						list_item.hide({duration : 100});
						//Change this to remove on success event of list_item.hide
						list_item.remove();
					}
	  			}
	  		});
		}
	});
	
});