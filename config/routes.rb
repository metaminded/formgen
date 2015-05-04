Formgen::Engine.routes.draw do
  resources :forms do
    member do
      post 'mail', action: :send_mail
      get 'export', action: :export
      resources :answers, only: [:show, :create] do
        collection do
          delete 'destroy_all', action: :destroy_all
        end
      end
    end
  end
end
