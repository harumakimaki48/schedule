class UsersController < ApplicationController
  def new
    @user = User.new
    @user.user_number = nil
  end

  def create
    @user = User.new(user_params)
    Rails.logger.debug "User Params: #{user_params.inspect}"
    if @user.save
      redirect_to root_path, notice: "ユーザー登録が完了しました"
    else
      Rails.logger.debug "User Errors: #{@user.errors.full_messages}"
      # flashメッセージはエラーメッセージをフィールドごとに集約
      flash.now[:alert] = @user.errors.full_messages.join("<br>").html_safe
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    if current_user&.admin?  # current_userが存在し、かつ管理者であればroleを許可
      params.require(:user).permit(:user_number, :user_name, :password, :password_confirmation, :role)
    else
      params.require(:user).permit(:user_number, :user_name, :password, :password_confirmation)
    end
  end
end
