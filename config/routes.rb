ExtensionRepo::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    match '/sign_in' => redirect('/users/auth/github'), :as => 'sign_in'
    match '/users/sign_in' => redirect('/users/auth/github')
  end
  resources :extensions do
    get 'page/:page', :action => :index, :on => :collection
  end
  root :to => "extensions#index"
end
