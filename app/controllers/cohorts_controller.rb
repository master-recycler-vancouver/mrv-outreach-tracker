class CohortsController < ApplicationController
  def index
    @cohorts = policy_scope Cohort.all
  end

  def show
    @cohort = authorize Cohort.find(params[:id])
  end
end