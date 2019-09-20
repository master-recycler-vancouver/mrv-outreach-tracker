class Admin::OutreachEventTypesController < ApplicationController
  before_action :get_outreach_event_type, only: [:show, :edit, :update]

  def index
    @outreach_event_types = policy_scope OutreachEventType.all
  end

  def new
    @outreach_event_type = authorize OutreachEventType.new
  end

  def create
    @outreach_event_type = authorize OutreachEventType.new(outreach_event_type_params)

    if @outreach_event_type.save
      redirect_to admin_outreach_event_types_path
    else
      render 'new'
    end
  end

  def edit
    authorize @outreach_event_type
  end

  def update
    authorize @outreach_event_type

    if @outreach_event_type.update(outreach_event_type_params)
      redirect_to admin_outreach_event_types_path
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def get_outreach_event_type
      @outreach_event_type = OutreachEventType.find params[:id]
    end

    def outreach_event_type_params
      params.require(:outreach_event_type).permit(
        :name
      )
    end
end