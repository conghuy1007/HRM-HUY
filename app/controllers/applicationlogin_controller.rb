class ApplicationloginController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    include SessionsHelper
    helper_method :current_user, :is_admin?
    protect_from_forgery with: :exception

    def validate_login
      unless current_user.nil?
        redirect_to index_path
      end
    end
  end
  