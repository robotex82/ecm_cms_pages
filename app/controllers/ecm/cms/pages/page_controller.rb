class Ecm::Cms::Pages::PageController < ApplicationController
  layout 'application'
#  layout :get_layout
#  
#  def get_layout
#    Ecm::Cms::Pages.config.layout
#  end

  #include ActionController::Rendering
  #include AbstractController::Helpers

  # append_view_path Ecm::Cms::Pages::TemplateResolver.instance
  append_view_path Ecm::Cms::Pages::PartialResolver.instance
  #helper CmsHelper
  
  def respond
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
