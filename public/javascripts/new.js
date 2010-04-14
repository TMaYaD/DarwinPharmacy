$.require(['jquery.livequery.js', 'jquery.labelover.js', 'jquery.autocomplete.min.js']);
$(document).ready(function() {
  $('li>label').livequery( function() {
    $(this).labelOver();
  });
  $('input[autocomplete]').livequery( function() {
    $this = $(this);
    function get_ac_params($ac_field) {
      var ac_params = {};
      $.each( eval($ac_field.attr('ac_params')) || [], function(index, param) {
	      ac_params[param] = function() {
	        // The selector below is rather eloborate. I don't like it!
	        return $ac_field.parent().prevAll('[id*='+param+']').children('input').val();
	      };
	    });
	    return ac_params;
    };
    $this.autocomplete( $this.attr('autocomplete'), {
      autoFill: true,
      cacheLength: 1,
      max: 10,
      minChars: ($this.attr('ac_minChars') ? $this.attr('ac_minChars') : 3),
      selectFirst: true,
      extraParams: get_ac_params($this),
    }).result( function (event, data, formatted) {
      if (data) {
        $ac_field = $(this)
        // set the extra data
        additional_fields = eval(data[1]) || {};
        $.each(eval(data[1]) || {}, function(param, value) {
          $ac_field.parent().nextAll('[id*='+param+']').children('input').val(value);
        });
      };
    });
  });
});
function remove_fieldset(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("fieldset").hide();
}

function add_fieldset(link, association, content) {
  var new_id = new Date().getTime();
  var regex = new RegExp("new_" + association, "g");
  $content = $(content.replace(regex, new_id));
  $(link).before($content);
  $('html,body').animate({scrollTop: $content.offset().top-[50]},500);
  $('input:first', $content).focus();
}

