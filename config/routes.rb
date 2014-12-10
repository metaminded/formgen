Formgen::Engine.routes.draw do
  resources :forms do
    member do
      post 'mail', action: :send_mail
      get 'export', action: :export
      resources :answers, only: [:show, :create]
    end
  end
end
