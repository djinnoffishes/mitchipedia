Mitchipedia::Application.routes.draw do
  get "welcome/index"
  get "welcome/about"

  match 'about' => 'welcome#about', via: :get
  root to: "welcome#index"
end
