Formgen::Engine.routes.draw do
  resources :forms do
    member do
      resources :answers, only: [:show, :create]
    end
  end
end
