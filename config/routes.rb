Issues::Engine.routes.draw do
  root :to => 'application#index'

  resources :projects do
    resources :issues
  end
end
