class PageController < ApplicationController
  layout 'application'
#  layout :get_layout
#  
#  def get_layout
#    Ecm::Cms::Pages.config.layout
#  end

  #include ActionController::Rendering
  #include AbstractController::Helpers

  # append_view_path Ecm::Cms::Pages::TemplateResolver.instance
  append_view_path Ecm::Cms::Pages::TemplateResolver.instance
  #helper CmsHelper
  
  def respond
    page = params[:page]
    
    prefix = page.split("/")[1..-1]
    name = page.split("/").last
    partial = false
    details = {
      :formats => Mime::SET.symbols.map(&:to_s),
      # :locale => I18n.available_locales.map(&:to_s),
      :locale => [I18n.locale.to_s],
      :handlers => ActionView::Template::Handlers.extensions.map(&:to_s)
    }

    @_title, @_meta_description = Ecm::Cms::Pages::TemplateResolver.instance.find_template_meta(name, prefix, partial, details)
    
    render :template => params[:page]
  end
  
#  unless ActionController::Base.consider_all_requests_local  
#    rescue_from ActionView::MissingTemplate do |exception|
#      render_404
#    end
#  end
  
  
  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end

    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end    
