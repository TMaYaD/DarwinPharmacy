$.require(['jquery.dataTables.min.js', 'jquery-ui-1.7.2.custom.min.js']);
//   toolbar_class = 'fg-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper.clearfix'
//               'sDom': '<lfr>t<<\"ui-icon ui-icon-plusthick\">pi>',
$(document).ready(function() {
    $('#data').dataTable({
        'bJQueryUI': true,
        'sPaginationType': 'full_numbers',
        'aoColumns': [{'sName': colName} for each (colName in sColumns)],
        'bStateSave': true,
        'bServerSide': true,
        'sAjaxSource': document.location,
        'fnServerData': function ( sSource, aoData, fnCallback ) {
          $.getJSON( sSource, aoData, function ( data, textStatus) {
            aoData = {
              'sColumns': sColumns.join(','),
              'sEcho': data['sEcho'],
              'iTotalRecords': data['iTotalRecords'],
              'iTotalDisplayRecords': data['iTotalDisplayRecords'],
            };
            aoData['aaData'] = [ [ record[tName][colName] for each (colName in sColumns) ] for each (record in data['ajData']) ];
            fnCallback(aoData, textStatus);
          });
        },
    });
    $('#add_new').remove().prependTo('div.fg-toolbar:last');
});
