Rails.application.routes.draw do
  resources :articles do
    collection do
      post :scrape
    end
  end


  root "articles#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # PWA comments (puedes dejarlos igual)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
