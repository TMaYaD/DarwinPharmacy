# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def datatable(&block)
    concat javascript_include_tag('jquery.dataTables.min')
    concat stylesheet_link_tag('/themes/smoothness/jquery-ui-1.7.2.custom.css')
#   toolbar_class = 'fg-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper.clearfix'
#               'sDom': '<lfr>t<<\"ui-icon ui-icon-plusthick\">pi>',
    concat "
          <script>
            $(document).ready(function() {
              $('#data').dataTable({
                'bJQueryUI': true,
                'sPaginationType': 'full_numbers',
                'bStateSave': true,
              });
              $('#add_new').remove().prependTo('div.fg-toolbar:last');
            });
          </script>"
    concat "
        <table id='data'>"
    yield
    concat "</table>"
  end
end
