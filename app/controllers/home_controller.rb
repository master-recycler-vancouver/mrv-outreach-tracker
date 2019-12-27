class HomeController < ApplicationController
  def index
    skip_policy_scope

    if current_user.admin?
  		redirect_to admin_outreach_events_path
		elsif current_user.facilitator?
  		redirect_to facilitator_outreach_events_path
		elsif current_user.student?
  		redirect_to outreach_events_path
		end
  end
end