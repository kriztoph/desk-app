Rails.application.routes.draw do
  root to: 'agent#index' 

  get  '/desk/templates/*template_path' => 'desk_templates#find'
  get '/agent' => 'agent#index'

  namespace :api do
    namespace :v1 do
      get '/filters' => 'filters#index', format: :json
      get '/cases' => 'cases#index', format: :json
    end
  end
end
