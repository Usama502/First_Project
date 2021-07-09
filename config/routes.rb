Rails.application.routes.draw do
  
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  #devise_for :members, :controllers => { :registrations => "registrations" }

  resources :projects
  resources :bugs

end
