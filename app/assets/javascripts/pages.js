$('.set-task > input').on('focus', function() {
		$('.set-deadline').show();
});

$('.set-deadline > input').on('focus', function() {
		$('.set-bounty').show();
});

$('.set-bounty > select').on('focus', function() {
		$('.create-task-btn').show();
});
