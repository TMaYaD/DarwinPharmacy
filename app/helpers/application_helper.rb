# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_remove_fieldset(name, f)
    f.input(:_destroy, :as => :hidden) + link_to_function(name, "remove_fieldset(this)")
  end
  def link_to_add_fieldset(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fieldset = capture {
      f.inputs(:for => ["#{association}_attributes][new_#{association}", new_object], :class => 'item') do |builder|
        render(association.to_s.pluralize + "/inputs", :f => builder)
      end
    }
    link_to_function(name, h("add_fieldset(this, \"#{association}\", \"#{escape_javascript(fieldset)}\")"))
  end
end
