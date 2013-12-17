Nubeporra::Application.routes.draw do

  resources :boxings do
  end

  devise_for :users

  resources :games do
    resources :bets
  end

  resources :scoretypes do
    resources :scoretypevalues
  end

  root :to =>            'static_pages#home'

  get '/home',     to: 'static_pages#home'

  get '/users/:id/bets',  to: 'bets#user'

  get '/boxing/:id/standing',  to: 'boxings#standing', as: :standing_boxing
  get '/boxing/:id/betting',  to: 'boxings#betting', as: :betting_boxing
  post '/boxing/:id/betting',  to: 'boxings#import', as: :boxing_import


  # Format of date is YYYY-MM-DD
  get '/scores/acb',  to: 'scoreapis#acb', as: :acb
  get '/scores/:date/acb/edit',  to: 'scoreapis#acb_edit', as: :acb_edit
  post '/scores/acb/edit',  to: 'games#import', as: :acb_import

  # Format of date is YYYY-MM-DD
  get '/scores/asobal',  to: 'scoreapis#asobal', as: :asobal
  get '/scores/:date/asobal/edit',  to: 'scoreapis#asobal_edit', as: :asobal_edit
  post '/scores/asobal/edit',  to: 'games#import', as: :asobal_import

 # Format of date is YYYY-MM-DD
  get '/scores/futsal',  to: 'scoreapis#futsal', as: :futsal
  get '/scores/:date/futsal/edit',  to: 'scoreapis#futsal_edit', as: :futsal_edit
  post '/scores/futsal/edit',  to: 'games#import', as: :futsal_import

  # Format of date is Offset from Today's date
  get '/scores/nba',  to: 'scoreapis#nba', as: :nba
  get '/scores/:date/nba/edit',  to: 'scoreapis#nba_edit', as: :nba_edit
  post '/scores/:date/nba/edit',  to: 'games#import', as: :nba_import

  # Format of date is YYYY-MM-DD
  get '/scores/football',  to: 'scoreapis#football', as: :football

# Format of date is YYYY-MM-DD
  get '/scores/:date/football/edit',  to: 'scoreapis#football_edit', as: :football_edit
  post '/scores/:date/football/edit',  to: 'games#import', as: :football_import

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
 
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
