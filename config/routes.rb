Rails.application.routes.draw do
  
  root "projects#index"

  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  
  #devise_for :members, :controllers => { :registrations => "registrations" }

  resources :projects
  resources :bugs
  resources :pages

end
