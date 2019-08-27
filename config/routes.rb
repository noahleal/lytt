Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :sessions do
        resources :messages, only: [:create, :show]
        resources :replies, only: [:create, :index, :show]
      end
    end
  end
end
