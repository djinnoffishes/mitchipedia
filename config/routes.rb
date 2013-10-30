Mitchipedia::Application.routes.draw do

  devise_for :users

  resources :wikis do
    resources :collaborators
  end
  get "wikis/:id/manage", to: "wikis#manage", as: "manage_wiki"


  match 'about' => 'welcome#about', via: :get

  root to: "welcome#index"

end