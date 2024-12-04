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
    permitted_params = [ :user_number, :user_name, :password, :password_confirmation ]
    permitted_params << :role if current_user&.admin?

    params.require(:user).permit(*permitted_params)
  end
end
