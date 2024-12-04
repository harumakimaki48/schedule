class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  protect_from_forgery with: :exception

  before_action :auto_login_from_cookies

  private

  def auto_login_from_cookies
    return if logged_in? # 既にログイン中の場合はスキップ

    if cookies.signed[:remember_token]
      user = User.find_by(remember_token: cookies.signed[:remember_token])
      auto_login(user) if user
    end
  end

  def require_login
    unless logged_in? # `logged_in?` メソッドは Sorcery または独自の認証で提供
      flash[:alert] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
