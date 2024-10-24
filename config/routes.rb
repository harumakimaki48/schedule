Rails.application.routes.draw do
  get "shops/index"
  get "shops/new"
  get "shops/create"
  get "shops/edit"
  get "shops/update"
  get "shops/destroy"
  # sessions_controllers
  root "sessions#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # users_controllers
  resources :users, only: [ :new, :create ]

  # rooms_controllers
  resources :rooms, only: [ :new, :create ]
  get "/rooms/login", to: "rooms#login", as: "login_room"
  post "/rooms/login", to: "rooms#login_process", as: "rooms_login_process"

  # shop_controllers
  resources :shops

  # schedules_controllers for each room
  resources :rooms do
    resources :schedules do
      collection do
        get "select_date", to: "schedules#select_date", as: "select_date"
        post "choose_date", to: "schedules#choose_date", as: "choose_date"
      end
    end
  end

  # 動的にParkに関連するAreaを取得
  resources :areas, only: [] do
    get "by_park/:park_id", on: :collection, to: "areas#by_park"
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
