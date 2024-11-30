Rails.application.config.sorcery.submodules = [ :external ]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [ :line ]

  config.line.key = ENV["LINE_CHANNEL_ID"] # LINEのチャネルID
  config.line.secret = ENV["LINE_CHANNEL_SECRET"] # LINEのチャネルシークレット
  config.line.callback_url = "#{ENV['APP_HOST']}/auth/line/callback" # コールバックURL
  config.line.scope = "profile openid email"
  config.line.user_info_mapping = { user_name: "name", uid: "sub" } # ユーザー情報マッピング


  # --- user config ---
  config.user_config do |user|
    user.username_attribute_names = [ :user_number ]
    user.email_attribute_name = nil
    user.stretches = 1 if Rails.env.test?
  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
