# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :get_user, only: :show

  def index
    @q = User.ransack(params[:q])
    @users = policy_scope @q.result(distinct: true).includes(:outreach_event_types, :cohort)

    respond_to do |format|
      format.html
      format.csv { 
        authorize @users, :to_csv?
        send_data User.to_csv(@users), filename: "mrv-users.csv"
      }
    end
  end

  def show
    authorize current_user
  end

  def profile
    @user = current_user
    authorize current_user
    render :show
  end

  def edit
    @user = current_user
    authorize current_user
  end

  def update
    @user = current_user
    authorize current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def batch_invite
    authorize current_user
  end

  def import
    authorize current_user

    filetype = params[:file].content_type
    if filetype != 'text/csv'
      flash[:error] = "File provided was a #{filetype}. Please upload a CSV and try again."
      redirect_to users_batch_invite_path
      return
    end

    begin
      imported_users = User.invite_from_csv(params[:file])
      flash.now[:success] = 'Successfully created (or updated) and invited the following users:'
      render :review_invites, locals: { users: imported_users }
    rescue ActiveRecord::InvalidForeignKey => e
      # throw error if cohort doesn't exist (assumes cohort_id is the only foreign key)
      flash[:error] = "Oops! Failed to import users. One or more users was assigned a cohort that doesn't exist. Please create the cohort or assign the student to an existing cohort."
      redirect_to users_batch_invite_path
    rescue ActiveRecord::RecordInvalid => e
      # This is probably being thrown because cohorts_id is nil
      flash[:error] = 'Oops! Some information provided for one or more students was invalid or missing. For example, do all students have cohorts assigned? Please review the CSV and try again.'
      redirect_to users_batch_invite_path
    rescue StandardError => e
      # For all other errors, output the error
      flash[:error] = "Something went wrong: #{e}. Please review the CSV and ensure all data is valid."
      redirect_to users_batch_invite_path
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :about_me,
      :facebook_handle,
      :instagram_handle,
      :linkedin_handle,
      :twitter_handle,
      :picture,
      interest_list: [],
      outreach_event_type_ids: []
    )
  end
end
