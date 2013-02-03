# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$('#backup_date').datepicker({
		format: 'dd/mm/yyyy'
	})
	$('#backup_time').timepicker()