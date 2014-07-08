class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  require 'csv'

  def authenticate_active_admin_user!
    unless current_user.administrator?
      flash[:error] = t('messages.forbidden')
      redirect_to root_path
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'La page que vous cherchez n\'existe pas'
  end

end
