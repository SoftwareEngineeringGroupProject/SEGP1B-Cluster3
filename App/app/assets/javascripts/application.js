// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.turbolinks

    $( "body" ).delegate( '#idofpagethatusesbelmont', 'pageinit', function() {
        $( 'select[name="state_choice"]' ).change( function() {
            var thisState = $( this ).val();
            var indexState = '#' + thisState;
            $( '.state' ).hide();
            $( indexState ).show();
        });
    })
  
  $(function() {
    $('#reload').click(function() {
      location.reload();
    });
  });

  

  $(function() {
    $( "#datepicker" ).datepicker();
  });

  $(function() { 
  
    $("#demo").change(function(){
    var chosen = $(this).find(":selected")
    $("textarea#project_desc").val(chosen.data("desc"));
    });
  });





 
 

  