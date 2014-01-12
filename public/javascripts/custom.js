$(function(){

  function tradeClass($elem, class1, class2) {
    if ($elem.hasClass(class1)) {
      $elem.removeClass(class1);
      $elem.addClass(class2);
    } else {
      $elem.removeClass(class2);
      $elem.addClass(class1);
    }
  }

  $("#video").hide()
  $("#video-header").click(function() {

    $("#video").slideToggle();

    tradeClass($("#video-arrow"), "glyphicon-chevron-right", "glyphicon-chevron-down");
  });


  $("#stat-sections").sortable();
  $(".delete-stat").click(function(e) {
      $(e.target).parent().remove();
  });

  $("#editform").submit(function() {
     $("#stats-input").val($("#stat-sections").sortable("serialize")); 
     return true;
  });
});
