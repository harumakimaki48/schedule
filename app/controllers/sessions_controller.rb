class SessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:user_number], params[:password])
    if @user
      # トークン生成と保存
      @user.generate_remember_token
      cookies.permanent.signed[:remember_token] = @user.remember_token

      redirect_to login_room_path, notice: "ログインに成功しました。"
    else
      flash.now[:alert] = "ログインに失敗しました。"
      redirect_to login_path
    end
  end

  def destroy
    # トークン削除とクッキー削除
    current_user&.clear_remember_token
    cookies.delete(:remember_token)

    logout
    redirect_to root_path, notice: "ログアウトしました。"
  end

  def line_callback
    auth = request.env["omniauth.auth"]

    if auth.nil?
      Rails.logger.error "OmniAuth認証情報が見つかりません: #{request.env.inspect}"
      redirect_to login_path, alert: "LINEログインに失敗しました。"
      return
    end

    user = User.find_or_initialize_by(uid: auth[:uid], provider: "line") do |u|
      u.user_name = auth[:info][:name]
      u.role = :user
    end

    if user.save(validate: false)
      auto_login(user)

      # トークン生成と保存
      user.generate_remember_token
      cookies.permanent.signed[:remember_token] = user.remember_token

      redirect_to login_room_path, notice: "LINEログインに成功しました。"
    else
      Rails.logger.error "ユーザー保存エラー: #{user.errors.full_messages.join(', ')}"
      redirect_to login_path, alert: "LINEログインに失敗しました。"
    end
  end

  def failure
    Rails.logger.error "OmniAuth Failure: #{params[:message]}"
    redirect_to login_path, alert: "ログインに失敗しました。#{params[:message]}"
  end
end
