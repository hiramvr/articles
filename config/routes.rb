Rails.application.routes.draw do
  # Cargar rutas de Devise
  devise_for :users

  # Ruta raíz para usuarios autenticados
  authenticated :user do
    root "articles#index", as: :authenticated_root
  end

  # Ruta raíz para usuarios no autenticados
  unauthenticated do
    devise_scope :user do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  # Rutas disponibles siempre (pero protegidas en el controlador)
  resources :articles do
    collection do
      post :scrape
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
