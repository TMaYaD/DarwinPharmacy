$.require(['jquery.dataTables.min.js', 'jquery-ui-1.7.2.custom.min.js']);
//   toolbar_class = 'fg-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper.clearfix'
//               'sDom': '<lfr>t<<\"ui-icon ui-icon-plusthick\">pi>',
$(document).ready(function() {
    $('.data').dataTable({
        'bJQueryUI': true,
        'sPaginationType': 'full_numbers',
        'aoColumns': [{'sName': colName} for each (colName in sColumns)],
        'bStateSave': true,
        'bServerSide': true,
        'sAjaxSource': document.location,
        'fnServerData': function ( sSource, aoData, fnCallback ) {
          aoData.push({
            'name': 'sSort',
            'value': [
              sColumns[item[0]] + ' ' + item[1]
              for each(item in $(this).dataTableSettings[0].aaSorting)
              ].join(',')
          });

          $.getJSON( sSource, aoData, function ( data, textStatus) {
            asData = {
              'sColumns': sColumns.join(','),
              'sEcho': data['sEcho'],
              'iTotalRecords': data['iTotalRecords'],
              'iTotalDisplayRecords': data['iTotalDisplayRecords'],
            };
            asData['aaData'] = [ [ record[tName][colName] || '' for each (colName in sColumns) ] for each (record in data['ajData']) ];
            fnCallback(asData, textStatus);
          });
        },
    });
    $('#add_new').remove().prependTo('div.fg-toolbar:last');
});
