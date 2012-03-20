class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :http_authenticate if Rails.env.production?

protected

  def http_authenticate
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == "spongebob" && password == "squarepants"
    end
    warden.custom_failure! if performed?
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
end
