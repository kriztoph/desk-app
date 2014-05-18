Rails.application.routes.draw do
  root to: 'agent#index' 

  get  '/desk/templates/*template_path' => 'desk_templates#find'
  get '/agent' => 'agent#index'
end
