class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [
                                        :username,
                                        :first_name,
                                        :last_name,
                                        :email,
                                        :role,
                                        :terms_of_service,
                                        :password,
                                        :password_confirmation,
                                        :image
                                      ])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [
                                        :username,
                                        :first_name,
                                        :last_name,
                                        :email,
                                        :role,
                                        :terms_of_service,
                                        :password,
                                        :password_confirmation,
                                        :image
                                      ])
  end
end
