class Admin::CohortsController < ApplicationController
  before_action :get_cohort, only: [:edit, :update, :destroy]

  def edit
    authorize @cohort
  end

  def update
    authorize @cohort
    if @cohort.update(cohort_params)
      redirect_to cohorts_path
    else
      render :edit
    end
  end

  def new
    @cohort = authorize Cohort.new
  end

  def create
    @cohort = authorize Cohort.new(cohort_params)

    if @cohort.save
      redirect_to cohorts_path
    else
      render :new
    end
  end

  def destroy
    authorize @cohort
    if @cohort.destroy
      flash[:success] = "Successfully deleted cohort #{@cohort.name}"
    else
      flash[:error] = "Failed to delete cohort. #{error_messages(@cohort)}."
    end

    redirect_to cohorts_path
  end

  private

    def cohort_params
      params.require(:cohort).permit(:name)
    end

    def get_cohort
      @cohort = Cohort.find(params[:id])
    end
end