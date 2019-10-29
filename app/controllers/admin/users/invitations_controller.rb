class Admin::Users::InvitationsController < Devise::InvitationsController
  before_action :configure_permitted_parameters

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: [
        :first_name,
        :last_name
      ])
      devise_parameter_sanitizer.permit(:invite, keys: [
        :cohort_id,
        :first_name,
        :last_name,
        :role
      ])
    end
end