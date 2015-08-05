ready = ->
  $('.bkgdevil-datepicker').pickadate()
  $('.bkgdevil-timepicker').pickatime()
$(document).ready(ready)
$(document).on('page:load', ready)
