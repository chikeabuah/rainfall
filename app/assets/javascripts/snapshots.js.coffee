# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready(()->
	snapshots = []
	$("#submit-solution").click((e)->
		e.preventDefault()
		snap = $("#snapshot-area").val()
		time = (new Date).getTime()
		snapshots.push({body: snap, time: time})
		$.ajax
	        dataType: 'text'
	        url: '/snapshots/create'
	        type: 'POST'
	        data:
	         	session_id: 2 #TODO
	         	body: snapshots
	        success: (res) -> window.location = '/users/new'
	)
	$("#snapshot-area").keypress((e) -> 
		keycode = if e.keyCode then e.keyCode else e.which
		if keycode == 13
			snap = $("#snapshot-area").val()
			time = (new Date).getTime()
			snapshots.push({body: snap, time: time})
	)

)