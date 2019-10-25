class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update]

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

    def get_user
      @user = params[:id].present?  ? User.find(params[:id]) : current_user
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
        interest_list: [],
        outreach_event_type_ids: []
      )
    end

end
