jQuery.fn.labelOver = function(overClass) {
    return this.each(function(){
        var label = jQuery(this);
        var f = label.attr('for');
        if (f) {
            var input = jQuery('#' + f);
            /*
            this.hide = function() {
              label.css({ textIndent: -10000 })
            }
            
            this.show = function() {
              if (input.val() == '') label.css({ textIndent: 0 })
            }
            */

            // handlers
            input.focus(function() {
                label.hide();
            });
            input.blur(function() {
                if (input.val() == '') {
                    label.show();
                } else {
                    label.hide();
                }
            });
            
            label.addClass(overClass).css({
                'margin-right': -label.width()-4,
                'padding-left': 4,
                'position': 'relative',
                'z-index': 1,
                'cursor': 'text'
            }).click(function(){ input.focus() });
            if (input.val() != '') label.hide(); 
        }
    });
};
