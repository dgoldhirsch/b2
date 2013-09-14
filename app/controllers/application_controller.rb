class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :get_user

private

  def get_user
    @user = current_user
  end
  
end
