class Boxers::RegistrationsController < Devise::RegistrationsController
  protected

  # This ensure that once a new boxer signs up, they are
  # redirected to the page where they can enter further details of themself
  def after_sign_up_path_for(resource)
    boxer_details_path
  end
end 