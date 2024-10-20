class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      render :new
    end
  end

  private

  def user_params
    if current_user.admin?  # 管理者のみroleを許可
      params.require(:user).permit(:user_number, :user_name, :password, :password_confirmation, :role)
    else
      params.require(:user).permit(:user_number, :user_name, :password, :password_confirmation)
    end
end
