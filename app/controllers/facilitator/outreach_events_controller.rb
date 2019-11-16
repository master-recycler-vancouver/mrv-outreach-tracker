class Facilitator::OutreachEventsController < ApplicationController
  def index
    @outreach_events = policy_scope OutreachEvent.all
  end
end