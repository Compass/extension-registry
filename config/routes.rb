ExtensionRepo::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :extensions do
    get 'page/:page', :action => :index, :on => :collection
  end
  root :to => "extensions#index"
end
