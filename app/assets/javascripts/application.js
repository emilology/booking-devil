// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require pickadate/picker
//= require pickadate/picker.date
//= require pickadate/picker.time
//= require_tree .

(function () {
    $(document).ready(function () {
        return $('#header-handle').click(function () {
            return $('header').toggleClass('expanded');
        });
    });
}.call(this));

var buttonpusher = function() {

  var $button = $(this);
  var oldValue = $button.parent().find("input").val();

  if ($button.text() == "+") {
    var newVal = parseFloat(oldValue) + 1;
  } else {
   // Don't allow decrementing below zero
    if (oldValue > 0) {
      var newVal = parseFloat(oldValue) - 1;
    } else {
      newVal = 0;
    }
  }
  console.log(
    "HI GUYS!"
  );
  $button.parent().find("input").val(newVal);

};

// $(function() {
var done = false || done;
if(!done){
  $(document).on("click", ".button", buttonpusher);
  done = true;
}
// });
