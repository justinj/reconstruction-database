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

  var renderItem = function(item, escape) {
    return '<div>' +
      (item.name ? "<span class='name'>" + escape(item.name) + "</span>" : "") +
      '</div>';
  };

  var renderOption = function(item, escape) {
    var label = item.name || item.email;
    var caption = item.name ? item.email : null;
    return "<div>" +
      "<span class='select-result'>" + escape(label) + "</span>" +
      (caption ? "<span class='caption'>" + escape(caption) + "</span>" : "") +
      "</div>";
  };

  // annoyingly selectize doesn't seem to allow you to add things that aren't in the list
  var vals = $("#search-box").val().split(",");
  for (var i = 0; i < vals.length; i++) {
    searchableOptions.push(vals[i]);
  }

  $("#search-box").selectize({
      persist: false,
      maxItems: null,
      valueField: "name",
      labelField: "name",
      searchField: ["name"],
      options: searchableOptions.map(function(name) {
        return {name: name};
      }),
      render: {
        item: renderItem,
        option: renderOption
      },
      create: function(input) {
        return {name: input};
      }
  });
});
