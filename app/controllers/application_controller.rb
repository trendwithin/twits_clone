class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def after_sign_in_path_for(resource)
    if current_user.role == 'admin' || current_user.role == 'registered'
      blogs_path
    else
      root_path
    end
  end

  private
    def user_not_authorized
      flash[:alert] = 'Something Went Wrong.  Contact Admin if you believe this an error'
      redirect_to(request.referrer || root_path)
    end
end
