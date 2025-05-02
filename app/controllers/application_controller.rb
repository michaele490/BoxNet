class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    general_keys = [ :first_name, :last_name, :username ]

    devise_parameter_sanitizer.permit(:sign_up, keys: general_keys)

    if devise_resource_class == Boxer
      boxer_keys = general_keys + [ :overall_rating, :defence, :power, :speed, :iq, :weight_class, :stamina, :height, :reach, :nickname, :nationality, :gender ]
      devise_parameter_sanitizer.permit(:account_update, keys: boxer_keys)
    elsif devise_resource_class == Coach
      coach_keys = general_keys # Add extra coach variables later
      devise_parameter_sanitizer.permit(:account_update, keys: coach_keys)
    elsif devise_resource_class == Editor
      editor_keys = general_keys # Add extra editor variables later
      devise_parameter_sanitizer.permit(:account_update, keys: editor_keys)
    elsif devise_resource_class == Spectator
      spectator_keys = general_keys # Add extra spectator keys later
      devise_parameter_sanitizer.permit(:account_update, keys: spectator_keys)
    end
  end

  private

  def devise_resource_class
    resource_class = devise_mapping.to
    resource_class.is_a?(Class) ? resource_class : resource_class.constantize
  end
end
