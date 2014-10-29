// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
var str=location.href.toLowerCase();

if ($("body").height() <= $(window).height()) {
	$("#footer").animate({"bottom":0});
}

$(".navigation li a").each(function() {
if (str.indexOf(this.href.toLowerCase()) > -1) {
 $("li.highlight").removeClass("highlight");
$(this).parent().addClass("highlight");
}
 });

});

$(window).on("scroll", function() {
	var scrollHeight = $(document).height();
	var scrollPosition = $(window).height() + $(window).scrollTop();
	if ((scrollHeight - scrollPosition) / scrollHeight === 0) {
	    $("#footer").animate({"bottom":0});
	}
	else if(parseInt($("#footer").css("bottom"),10)==0)
	{
		$("#footer").animate({"bottom":-$("#footer").outerHeight(true)});
	}
});

$(function() {
    $("ul.tabs").tabs("div.panes > div");
});