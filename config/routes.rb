Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admins do
    resources :sessions, only: [] do
      collection do
        post :sign_in
        post :sign_out
      end
    end
  end
end
