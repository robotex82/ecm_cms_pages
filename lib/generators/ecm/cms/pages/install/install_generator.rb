module Ecm
  module Cms
    module Pages
      module Generators
        class InstallGenerator < Rails::Generators::Base
          desc "Generates the initializer"
               
          source_root File.expand_path('../templates', __FILE__)
          
          def generate_initializer
            copy_file "initializers_ecm_cms_pages.rb", "config/initializers/ecm_cms_pages.rb"
          end   
        end
      end
    end
  end
end          
