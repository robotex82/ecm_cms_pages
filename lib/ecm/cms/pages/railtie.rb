# require 'will_paginate'
module Ecm
  module Cms
    module Pages
      class Engine < Rails::Engine
        config.to_prepare do
          ApplicationController.helper(Ecm::Cms::Pages::PageHelper)
        end  
        
#	      initializer 'ecm_cms_pages.add_catch_all_page_route', :after=> :build_middleware_stack do |app|
#          app.routes.draw do |map|
#            get "/*page", :to => "view#respond", :as => :template
#          end
#	      end        
      end
      
      def self.config(&block)
        @@config ||= Engine.config
        yield @@config if block
        return @@config
      end
    end  
  end  
end
