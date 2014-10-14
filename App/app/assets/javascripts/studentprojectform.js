// $(function(){
//     $(".course_text").hide();
//     if ($("student.course").val() == 'Add Course')
// 	    $(".course_text").show();
// });

$(document).ready(function() {
    // $(".course_text").hide();

	$("select[id='student_project_students_attributes_0_course']").change(function() {
		if ($("select[id='student_project_students_attributes_0_course").val() == ""){
		    $(":text[id=student_project_students_attributes_0_course]").prop('disabled', false);
		} else {
			$(":text[id=student_project_students_attributes_0_course]").prop('disabled', true);
		}
	});
	$("select[id='student_project_students_attributes_1_course']").change(function() {
		if ($("select[id='student_project_students_attributes_1_course").val() == ""){
		    $(":text[id=student_project_students_attributes_1_course]").prop('disabled', false);
		} else {
			$(":text[id=student_project_students_attributes_1_course]").prop('disabled', true);
		}
	});
	$("select[id='student_project_students_attributes_2_course']").change(function() {
		if ($("select[id='student_project_students_attributes_2_course").val() == ""){
		    $(":text[id=student_project_students_attributes_2_course]").prop('disabled', false);
		} else {
			$(":text[id=student_project_students_attributes_2_course]").prop('disabled', true);
		}
	});
/*	$("#student_project_students_attributes_0_course").change(function() {
		if ($("#student_project_students_attributes_0_course").val() == "Add Course"){
		    $("#course_text").show();
		} else {
			$("#course_text").hide();
		}
	});
*/

	// $(".select_course").change(function() {
	// 	if ($(".select_course").val() == "Add Course"){
	// 	    $("#course_text").show();
	// 	} else {
	// 		$("#course_text").hide();
	// 	}
	// });
});

// $(function(){
//     $('input[name="course_text"]').hide();
//     // $('input[name="course"]').change(function() {
//     //   $('input[name="source_other"]').toggle(  $(this).val()=="Other" );

//     // });
// });