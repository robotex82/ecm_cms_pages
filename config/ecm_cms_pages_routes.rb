Rails.application.routes.draw do # |map|
  # get "/:locale/*page", :to => "ecm/cms/pages/view#respond", :as => :template
  get "/*page", :to => "page#respond", :as => :template
end
