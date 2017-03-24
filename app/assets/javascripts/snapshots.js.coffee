# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready(()->
	snapshots = []
	$("#submit-solution").click((e)->
		e.preventDefault()
		editor = ace.edit("snapshot-area")
		snap = editor.getValue()
		access_key = $("#access_key").val()
		time = (new Date).getTime()
		snapshots.push({body: snap, time: time})
		$.ajax
	        dataType: 'text'
	        url: '/snapshots/create'
	        type: 'POST'
	        data:
	         	access_key: access_key
	         	body: snapshots
	        success: (res) -> window.location = "/users/new?access_key=#{access_key}"
	        error: (res) -> window.location = "/"
	)
	$("#snapshot-area").keypress((e) -> 
		keycode = if e.keyCode then e.keyCode else e.which
		if keycode == 13
			editor = ace.edit("snapshot-area")
			snap = editor.getValue()
			time = (new Date).getTime()
			snapshots.push({body: snap, time: time})
	)

)