Formgen::Engine.routes.draw do
  resources :forms do
    member do
      post 'mail', to: :send_mail
      get 'export', to: :export
      resources :answers, only: [:show, :create]
    end
  end
end
