
$(document).ready(function() {
	var i = 0;
	var studentField = $("#add_student");
	var wrapper = $("#add_student_field")


	//disable add course text field based on the course option
	$("select[name*='course']").change(function() {
		if ($("select[name*='course']").val() == ""){
		    $(":text[name*='course']").prop('disabled', false);
		} else {
			$(":text[name*='course']").prop('disabled', true);
		}
	});

	$(studentField).click(function () {
		$(wrapper).append()
	});

});