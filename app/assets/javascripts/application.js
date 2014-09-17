// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require vendor

$(".bmk-container").hover( function() {
  var parent, id;

  parent = $(this);
  id = parent.data("id");
  console.log(id);

  $("#bmk-actions-" + id).toggleClass("hidden");
});

$(".content-head-actions a").click( function(event) {
  event.preventDefault();

  $.ajax({
    url: $(this).data("url") + ".json",
    type: "GET",
    success: function(data) {
      $(".content-data").html(data);
    }
  });

  return false;
});
