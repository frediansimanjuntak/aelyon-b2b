Rails.application.routes.draw do
  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to
  # Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the
  # :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being
  # the default of "spree".
  mount Spree::Core::Engine, at: '/'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  Spree::Core::Engine.add_routes do
    namespace :admin, path: Spree.admin_path do
      resources :departments

    end

    devise_scope :spree_user do
      get '/signup/user/company' => 'user_registrations#new_user_company', :as => :signup_user_company
      post '/signup/user/company' => 'user_registrations#create_user_company', :as => :registration_user_company
      get '/signup/user/personal' => 'user_registrations#new_user_personal', :as => :signup_user_personal
      post '/signup/user/personal' => 'user_registrations#create_user_personal', :as => :registration_user_personal
    end
  end
end
