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
//= require jquery
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require toastr
//= require bootstrap
//= require jquery.validate
//= require jquery.validate.additional-methods

$(document).on("turbolinks:load", function () {
  new Recipe.App();
});

// $(document).on('ready page:load', function () {
//   new Recipe.App();
// });

// $(document).ready(function () {
//   // executes when HTML-Document is loaded and DOM is ready
//   console.log("(document).ready was called - document is ready!");
// });

// $(document).on("load", function () {
//   console.log("page yen has loaded oooo")
// });

// $(window).load(function () {
//   // executes when complete page is fully loaded, including all frames, objects and images
//   console.log("(window).load was called - window is loaded!");
// });
