class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_in_path_for(resource)
    blogs_path
  end
end
