Mitchipedia::Application.routes.draw do

  devise_for :users

  resources :wikis do
    resources :pages, except: [:index]
    resources :collaborators, except: [:index] do
      match "/make-editor", to: "collaborators#make_editor", via: [:patch], as: :make_editor
      match "/make-reader", to: "collaborators#make_viewer", via: [:patch], as: :make_viewer
    end
  end
  get "wikis/:id/manage", to: "wikis#manage", as: "manage_wiki"


  match 'about' => 'welcome#about', via: :get

  root to: "welcome#index"

end