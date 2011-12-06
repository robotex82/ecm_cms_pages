require 'rails/generators/migration'

module Ecm
  module Cms
    module Pages
      module Generators
        class MigrationsGenerator < Rails::Generators::Base
          include Rails::Generators::Migration
          
          desc "Generates the pages migration."
          
          source_root File.expand_path('../templates', __FILE__)

          def self.next_migration_number(path)
            unless @prev_migration_nr
              @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
            else
              @prev_migration_nr += 1
            end
            @prev_migration_nr.to_s
          end
 
#          def generate_layouts_migration
#            migration_template "create_cms_layouts.rb", "db/migrate/create_cms_layouts.rb"
#          end
          
          def generate_templates_migration
            migration_template "create_cms_templates.rb", "db/migrate/create_cms_templates.rb"
          end
          
#          def generate_partials_migration
#            migration_template "create_cms_partials.rb", "db/migrate/create_cms_partials.rb"
#          end          
#          
#          def generate_page_fragments_migration
#            migration_template "create_page_fragments.rb", "db/migrate/create_page_fragments.rb"
#          end
        end
      end
    end
  end
end
