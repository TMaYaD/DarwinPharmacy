# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def datatable(&block)
    concat javascript_include_tag('jquery.dataTables.min')
    concat stylesheet_link_tag('/themes/smoothness/jquery-ui-1.7.2.custom.css')
    concat "
          <script>
            $(document).ready(function() {
              $('#data').dataTable({
                'bJQueryUI': true,
                'sPaginationType': 'full_numbers',
                'bStateSave': true,
              });
            });
          </script>"
    concat "
        <table id='data'>"
    yield
    concat "</table>"
  end
end
