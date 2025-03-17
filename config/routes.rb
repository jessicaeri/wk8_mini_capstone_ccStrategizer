Rails.application.routes.draw do

  post '/login', to: 'sessions#create'

  post '/signup', to: 'users#create'
  #user authentication and profile 
  resources :users, only: [:show, :create, :update]
  #get /api/v1/users/:id - view own profile
  #post /api/vi/users - sign up
  #patch /api/v1/users/:id - update profile 

  namespace :api do
    namespace :v1 do
      #everyone category
      resources :categories, only: [:index]  
      #get /api/v1/categories - EVERYONE can view categories

       # User can add and delete categories from their own credit cards
      resources :user_categories, only: [:create, :destroy]

      # User can update points for their own categories
      patch 'user_categories/:id/update_points', to: 'user_categories#update_points'

      #user cc
      resources :credit_cards, only: [:index, :create, :destroy]
      #get /api/v1/credit_cards -view cc
      #post /api/v1/credit_cards - add cc
      #del /api/v1/credit_cards/:id - delete c
      
      get 'best_card/:category', to: 'best_card#best_card'
      #get /api/v1/best_card/:category →

      namespace :admin do
         #admin user management
        resources :users, only: [:index, :update, :destroy]
        #get/api/v1/admin/users - view all users
        #pat /api/v1/admin/users/:id - update any user
        #del /api/v1/admin/users/:id - delete user

        #admin category
        resources :categories, only: [:create, :update, :destroy]
        #post /api/v1/admin/categories - admin creates cat
        #post /api/v1/admin/categories/:id - admin updates cat
        #del /api/v1/admin/categories/:id - admin deletes

        #admin cc 
        resources :credit_cards, only: [:index, :create, :update, :destroy]
        # get/api/v1/admin/credit_cards - views all cc
        # post /api/v1/admin/credit_cards - admin can create cc for user
        # pat /api/v1/admin/credit_cards/:id - admin updates cc for user
        # delt /api/v1/admin/credit_cards/:id - admin deletes for user
      end
    end
  end

end
