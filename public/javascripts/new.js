$.require(['jquery.livequery.js', 'jquery.labelover.js', 'jquery.autocomplete.min.js']);
$(document).ready(function() {
  $('li>label').livequery( function() {
    $(this).labelOver();
  });
  $('input[autocomplete]').livequery( function() {
    $this = $(this);
    $this.autocomplete( $this.attr('autocomplete'), {
      autoFill: true,
      max: 10,
      minChars: 3,
      selectFirst: true,
    });
  });
});
function remove_fieldset(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("fieldset").hide();
}

function add_fieldset(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).before(content.replace(regexp, new_id));
}

