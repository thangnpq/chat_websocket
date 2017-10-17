class UsersController < ApplicationController

  def show
    @user=current_user
  end
  def edit
    @user= current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated."
      redirect_to chatrooms_path
    else
      render "edit"
    end

  end
  private
    def user_params
      params.require(:user).permit(:email, :avatar)
    end
end
