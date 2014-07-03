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

  function setupDropdown(name) {
    $("#" + name).hide()
    $("#" + name + "-header").click(function() {

      $("#" + name).slideToggle();

      tradeClass($("#" + name + "-arrow"), "glyphicon-chevron-right", "glyphicon-chevron-down");
    });
  }

  setupDropdown("video");
  setupDropdown("roofpig");


  $("#stat-sections").sortable();
  $(".delete-stat").click(function(e) {
      $(e.target).parent().remove();
  });

  $("#editform").submit(function() {
     $("#stats-input").val($("#stat-sections").sortable("serialize")); 
     return true;
  });
});
