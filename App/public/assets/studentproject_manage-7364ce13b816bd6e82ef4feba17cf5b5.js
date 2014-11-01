//take in a trigger checkbox
function select_all(check_all) {

	// tranverse all inputs on same form as check_all
	var inputs = check_all.form.getElementsByTagName("input");
	for (var i = 0; i < inputs.length; i++) {

		//if check_all box is ticked, then select all checkboxes
		if (inputs[i].type == "checkbox") {
			if (check_all.checked == true) {
				inputs[i].checked = true;
			}
			//if check_all box is not ticked, then deselect all checkboxes
			else {
				inputs[i].checked = false;
			}
		}
	}
}

//the function is used to expand or collapse a modulo
$(".header-expand").click(function() {
	$header = $(this);
	//getting the next element
	$content = $header.next();
	//open up the content needed - toggle the slide- if visible, slide up, if not slidedown.
	$content.slideToggle(500, function() {
		//execute this after slideToggle is done
		//change text of header based on visibility of content div
		$header.text(function() {
			//change text based on condition
			return $content.is(":visible") ? "Collapse" : "Expand";
		});
	});
}); 

$('.majorpointslegend').click(function(){
    
    if($(this).text()=='Expand'){
        $('#mylist').show();
        $(this).text('Colapse');
    }else{
        $('#mylist').hide();
        $(this).text('Expand');
    } 
});
