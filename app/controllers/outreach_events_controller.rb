class OutreachEventsController < ApplicationController
  def index
  	@outreach_events = policy_scope current_user.outreach_events
  end

  def show
  	@outreach_event = authorize OutreachEvent.find(params[:id])
  end

  def new
  	@outreach_event = authorize current_user.outreach_events.build
  end

  def edit
  	@outreach_event = authorize OutreachEvent.find(params[:id])
  end

  def create
    @outreach_event = authorize current_user.outreach_events.build(outreach_event_params)

    if @outreach_event.save
      flash[:success] = "Successfully created outreach event."
      redirect_to @outreach_event
    else
      flash.now[:error] = "Failed to create outreach event. Errors: #{error_messages(@outreach_event)}"
      render 'new'
    end
  end

  def update
    @outreach_event = authorize OutreachEvent.find(params[:id])

    if @outreach_event.update(outreach_event_params)
      flash[:success] = "Successfully updated outreach event."
      redirect_to @outreach_event
    else
      flash.now[:error] = "Failed to update. Errors: #{error_messages(@outreach_event)}"
      render 'edit'
    end
  end

	def destroy
		@outreach_event = authorize OutreachEvent.find(params[:id])
		@outreach_event.destroy
	
    redirect_to outreach_events_path     
  end

private
	def outreach_event_params
	  params.require(:outreach_event).permit(
			:date_range,
			:description,
			:duration_in_minutes,
			:people_reached,
      :notes,
      collaborator_ids: [],
      outreach_event_type_ids: []
  	)
	end

end
