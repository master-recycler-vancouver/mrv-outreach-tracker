class UsersController < ApplicationController
  
  def profile
    authorize current_user
  end

  def index
  	@users = policy_scope User.all
  end
	
  def show
  	@user = authorize User.find(params[:id])
  end

end
