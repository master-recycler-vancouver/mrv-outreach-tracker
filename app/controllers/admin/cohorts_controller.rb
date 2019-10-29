class Admin::CohortsController < ApplicationController
  def edit
  end

  def update
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
  end

  private

    def cohort_params
      params.require(:cohort).permit(:name)
    end
end