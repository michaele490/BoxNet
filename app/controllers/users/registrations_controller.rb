class Users::RegistrationsController < Devise::RegistrationsController
=begin
  def create
    super do |resource|
      BoxerRegistrationService.create(resource) if resource.persisted?
    end
  end
=end
end
