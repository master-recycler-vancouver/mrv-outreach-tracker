class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def skip_pundit?
    devise_controller?
  end

  def home_controller?
    is_a?(::HomeController)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
