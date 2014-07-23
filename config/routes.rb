Formgen::Engine.routes.draw do
  resources :forms do
    member do
      post 'mail', to: :send_mail
      resources :answers, only: [:show, :create]
    end
  end
end
