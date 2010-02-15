$.require(['jquery.livequery.js', 'jquery.labelover.js', 'jquery.autocomplete.min.js']);
$(document).ready(function() {
  $('li>label').livequery( function() {
    $(this).labelOver();
  });
  $('input[autocomplete]').livequery( function() {
    $this = $(this);
    function get_ac_params() {
        var ac_params = {};
        $.each( eval($this.attr('ac_params')) || [], function(index, param) {
	  ac_params[param] = function() {
	    // The selector below is rather eloborate. I don't like it!
	    return $this.parent().prev('[id*='+param+']').children('input').val();
	  };
	});
	return ac_params;
    };
    $this.autocomplete( $this.attr('autocomplete'), {
      autoFill: true,
      max: 10,
      minChars: ($this.attr('ac_minChars') ? $this.attr('ac_minChars') : 3),
      selectFirst: true,
      extraParams: get_ac_params(),
    }).result( function (event, data, formatted) {
      if (data) {
        $(this).parent().next().find('input[type=hidden]').val(data[1]);
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

