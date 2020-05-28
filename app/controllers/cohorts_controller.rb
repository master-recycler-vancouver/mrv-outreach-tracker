class CohortsController < ApplicationController
  def index
    @cohorts = policy_scope Cohort.all
  end

  def show
  	@q = User.ransack(params[:q])
    @cohort = authorize Cohort.find(params[:id])
    @users =  @cohort.users

    respond_to do |format|
      format.html
      format.csv {
        authorize @users, :to_csv?
        send_data User.to_csv(@users), filename: "mrv-cohort-#{@cohort.name}-users.csv" 
      }
    end
  end
end