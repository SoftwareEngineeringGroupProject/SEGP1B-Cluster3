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