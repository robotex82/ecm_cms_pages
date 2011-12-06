module Ecm
  module Cms
    module Pages
      class CmsTemplate < ActiveRecord::Base
        # belongs_to :cms_layout
        
        validates :path, :presence => true
        # 1) Allow nil on format validation
        validates :format,  :inclusion   => Mime::SET.symbols.map(&:to_s),
                            :allow_nil   => true, 
                            :allow_blank => true
        validates :locale,  :inclusion   => I18n.available_locales.map(&:to_s)
        validates :handler, :inclusion   => ActionView::Template::Handlers.extensions.map(&:to_s)

        def name
          "#{path}.#{locale}.#{format}.#{handler}"
        end  

        def partial
          false
        end  

        after_save do
          TemplateResolver.instance.clear_cache
        end
        
        after_initialize :init
        
        def init
          self.locale  ||= I18n.locale
          self.format  ||= "html"
          self.handler ||= "markerb"
        end
        
        
        def self.find_by_path(path)
          where(:path => path).first
        end
        
#        def cms_layout_path
#          if !cms_layout.nil? && !cms_layout.path.empty?
#            cms_layout.path
#          else
#            "application"
#          end    
#        end

        rails_admin do
          edit do
            field :title
            field :meta_description
            field :path
            field :format, :enum do
              enum do
                Mime::SET.symbols.map(&:to_s)
              end
            end
            field :locale, :enum do
              enum do
                I18n.available_locales.map(&:to_s)
              end
            end  
            field :handler, :enum do
              enum do
                ActionView::Template::Handlers.extensions.map(&:to_s) 
              end
            end  
            field :body 
          end
        end
        
      end
    end
  end
end      
