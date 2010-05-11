require 'factory_girl'
Dir[File.expand_path(File.join(Rails.root,'spec', 'factories', '*.rb'))].each {|f| require f}
# TODO: Migrate these over to spec
Dir[File.expand_path(File.join(Rails.root,'test', 'factories', '*.rb'))].each {|f| require f}


