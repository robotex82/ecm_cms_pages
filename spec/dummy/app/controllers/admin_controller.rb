class AdminController < ApplicationController
  layout 'ecm/admin'
  before_filter :authenticate_admin!
  def index
  end

end
