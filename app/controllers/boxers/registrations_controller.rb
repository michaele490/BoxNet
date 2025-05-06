class Boxers::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    boxer_details_path
  end
end 