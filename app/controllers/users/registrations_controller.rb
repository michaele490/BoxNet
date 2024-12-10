class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      BoxerRegistrationService.create(resource) if resource.persisted?
    end
  end
end
