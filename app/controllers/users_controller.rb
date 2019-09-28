class UsersController < ApplicationController
  
  def show
    authorize current_user
  end

  def edit
    authorize current_user
  end

  def update
    authorize current_user
    if current_user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  private

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

        outreach_event_type_ids: []
      )
    end

end
