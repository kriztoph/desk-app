Rails.application.routes.draw do
  root :to => redirect('/agent')

  get  '/desk/templates/*template_path' => 'desk_templates#find'
  get '/agent' => 'agent#index'

  namespace :api do
    namespace :v1 do
      resources :filters, format: :json, only: :index do
        resources :cases, only: :index
      end
      resources :cases
      resources :labels, only: [:create, :index]
    end
  end
end
