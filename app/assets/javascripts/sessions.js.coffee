# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(()->
	snapshots = []
	$("#submit-survey").click((e)->
		email = $("#email").val()
		$.ajax
	        dataType: 'text'
	        url: '/users/create'
	        type: 'POST'
	        data:
	         	email: email
	        # success: (res) -> window.location = '/sessions'
	)

)
