// $('.set-task > input').on('focus', function() {
		$('.set-deadline').show();
// });

// $('.set-deadline > input').on('focus', function() {
		$('.set-bounty').show();
		$('.create-task-btn').show();
// });

$(function () {
  $('.datetimepicker').datetimepicker({
  		minDate: moment(Date.today),
      sideBySide: true
  });
});