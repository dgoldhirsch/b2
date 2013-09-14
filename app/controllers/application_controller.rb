class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_user

  # Rescue from load_and_authorize_resource calls in controllers
  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

private

  def get_user
    @user = current_user
  end
  
end
