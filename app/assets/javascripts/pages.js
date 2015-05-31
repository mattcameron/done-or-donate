$('.datetimepicker').datetimepicker({
		format: "dddd, MMMM Do, h:mm a",
		minDate: moment(),
    sideBySide: true
});

$('#task_title').focus();


var offset = new Date().getTimezoneOffset();
$('#task_timezone_offset').val(offset);