Rails.application.config.session_store :cookie_store, 
  key: '_myapp_session', 
  expire_after: 30.minutes, 
  same_site: Rails.env.production? ? :strict : :lax, 
  secure: Rails.env.production?