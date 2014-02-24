class ApplicationController < ActionController::Base
  protect_from_forgery
  
  config.filter_parameters = [:password, :password_confirmation]
  helper_method :current_user

  def not_authenticated
  redirect_to login_url, :alert => "First login to access this page."
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to terms_url
  end
end
