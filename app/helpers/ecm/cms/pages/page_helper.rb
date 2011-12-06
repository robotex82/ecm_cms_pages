module Ecm::Cms::Pages::PageHelper
  def cms_page_classes
    url_for().gsub("/", " ").strip!
  end
  
  def cms_page_stylesheets(namespace = nil)
    output = ""
    if namespace
      namespace_string = "#{namespace.to_s}/"
    else
      namespace_string = ""
    end
    url_for().split("/").each do |path_part|
      output << stylesheet_link_tag("#{namespace_string}#{path_part}.css", :media => 'screen') unless path_part.blank?
    end
    output.html_safe
  end      
  
  def cms_title(site_title = "Change me")
    if @_title
      return "#{site_title} - #{@_title}" 
    else  
      return site_title
    end  
  end
  
  def cms_meta_description_tag
    "<meta name=\"description\" content=\"#{@_meta_description}\" />".html_safe
  end  
end
