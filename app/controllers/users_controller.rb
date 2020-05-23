# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :get_user, only: :show

  def index
    @q = User.ransack(params[:q])
    @users = policy_scope @q.result(distinct: true).includes(:outreach_event_types, :cohort)
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
