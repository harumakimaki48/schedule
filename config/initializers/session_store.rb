Rails.application.config.session_store :cookie_store,
  key: "_myapp_session",
  expire_after: 30.minutes,
  same_site: :lax, # LINEログインではstrictよりlaxが安全で互換性あり
  secure: Rails.env.production?
