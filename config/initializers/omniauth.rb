Rails.application.config.middleware.use OmniAuth::Builder do
    provider :line, ENV["LINE_CHANNEL_ID"], ENV["LINE_CHANNEL_SECRET"]

    # 許可するリクエストメソッド
    OmniAuth.config.allowed_request_methods = %i[get post]
    OmniAuth.config.silence_get_warning = true

    # エラーログの出力
    OmniAuth.config.on_failure = Proc.new { |env|
      error_message = env["omniauth.error"]&.message || "不明なエラー"
      error_type = env["omniauth.error.type"] || "不明なエラータイプ"
      error_strategy = env["omniauth.error.strategy"]&.inspect || "不明なストラテジー"

      Rails.logger.error "LINEログイン失敗: #{error_message}"
      Rails.logger.error "エラー詳細: #{error_type}"
      Rails.logger.error "エラー内容: #{error_strategy}"

      SessionsController.action(:failure).call(env)
    }
  end
