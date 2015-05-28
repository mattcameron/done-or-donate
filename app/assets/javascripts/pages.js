// $('.set-task > input').on('focus', function() {
		$('.set-deadline').show();
// });

// $('.set-deadline > input').on('focus', function() {
		$('.set-bounty').show();
		$('.create-task-btn').show();
// });

$(function () {
  $('.datetimepicker').datetimepicker({
  		defaultDate: moment().add(7, 'days'),
  		minDate: moment(Date.today),
      sideBySide: true
  });
});