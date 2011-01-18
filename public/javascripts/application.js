// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
  $("#links th a, #links .pagination a").live("click", function() {
     $.getScript(this.href);
     return false;
  });
  $("#links_search input").keyup(function() {
     $.get($("#links_search").attr("action"), $("#links_search").serialize(), null, "script");
     return false;
  });
});

