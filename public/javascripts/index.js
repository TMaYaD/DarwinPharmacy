$.require(['jquery.dataTables.min.js', 'jquery-ui-1.7.2.custom.min.js']);
//   toolbar_class = 'fg-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper.clearfix'
//               'sDom': '<lfr>t<<\"ui-icon ui-icon-plusthick\">pi>',
$(document).ready(function() {
    $('#data').dataTable({
        'bJQueryUI': true,
        'sPaginationType': 'full_numbers',
        'bStateSave': true,
    });
    $('#add_new').remove().prependTo('div.fg-toolbar:last');
});
