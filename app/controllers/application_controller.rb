class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :search
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def search
    @q = Board.ransack(activated: true)
  end
end
