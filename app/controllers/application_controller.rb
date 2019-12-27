class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  before_action :set_search

  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def skip_pundit?
    devise_controller?
  end

  def home_controller?
    is_a?(::HomeController)
  end

  def error_messages(obj)
    obj.errors.full_messages.join(", ")
  end

  def set_search
    @q=User.search(params[:q])
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
