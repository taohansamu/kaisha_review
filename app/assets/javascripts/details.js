// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
$(document).ready(function() {
	console.log(1);
	$('.navigation__item').click(function(){
	    if($(this).hasClass('overview')) {
	    	$('.overview').addClass('active');
	    	$('.overview').removeClass('disable');
	    	$('.review-tab').addClass('disable');
	    	$('.review-tab').removeClass('active');
	    } else {
	    	$('.review-tab').addClass('active');
	    	$('.review-tab').removeClass('disable');
	    	$('.overview').addClass('disable');
	    	$('.overview').removeClass('active');
	    }
	    ;
	});
 } );