// JavaScript Document

$(function() {
	$('[href]').live('click', function() {
		window.location = $(this).attr('href');
	});
});