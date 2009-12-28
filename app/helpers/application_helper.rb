# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def datatable(&block)
    concat javascript_include_tag('jquery.dataTables.min'), block.binding
    concat stylesheet_link_tag('/themes/smoothness/jquery-ui-1.7.2.custom.css'), block.binding
    concat "
          <script>
            $(document).ready(function() {
              $('#data').dataTable({
                'bJQueryUI': true,
                'sPaginationType': 'full_numbers',
                'bStateSave': true,
              });
            });
          </script>", block.binding
    concat "
        <table id='data'>", block.binding
    yield
    concat "</table>", block.binding
  end
end
