Rails.application.routes.draw do
  # sessions_controllers
  root "sessions#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # line_login
  get "/auth/line/callback", to: "sessions#line_callback", as: :line_callback

  # rooms_controllers の login ルートをトップレベルに定義
  get "/rooms/login", to: "rooms#login", as: "login_room"
  post "/rooms/login", to: "rooms#login_process", as: "login_room_process"

  # users_controllers
  resources :users, only: [ :new, :create ]

  # rooms_controllers
  resources :rooms, only: [ :new, :create ] do
    # foods_controllers
    resources :foods, only: [ :index, :new, :create, :edit, :update, :destroy ]
    # resources_controllers
    resources :payments
    # users_rooms_controllers
    resources :users_rooms, only: [ :index, :destroy ]
    # outfits_controllers
    resources :outfits, only: [ :index, :new, :create, :edit, :update, :destroy ]



    # schedules_controllers for each room
    resources :schedules do
      collection do
        get "select_date", to: "schedules#select_date", as: "select_date"
        post "choose_date", to: "schedules#choose_date", as: "choose_date"
      end
    end

    # rooms_menber_sharelink
    member do
      get :share_link
      get :how_to_use # ログイン後の使い方ページ
    end
  end

  # shop_controllers
  resources :shops

  # 動的にParkに関連するAreaを取得
  resources :areas, only: [] do
    get "by_park/:park_id", on: :collection, to: "areas#by_park"
  end

  # Reveal health status on /up
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

   # how_to_use_ログイン前
   get "how_to_use", to: "pages#how_to_use_guest"
end
