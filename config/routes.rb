AppAnnie::Application.routes.draw do

	match ':controller(/:action(/:id(.:format)))', :via => :all
	root :to => "ranking#index"
	resources :rating
  # get "rating/scrape"=>"rating#scrape"
  # post "rating/scrape"=>"rating#scrape"
	resources :ranking
	resources :search
	resources :review
  get "review/scrape"=>"review#scrape"
  post "review/scrape"=>"review#scrape"
	resources :realapp
  get "realapp/scrape"=>"realapp#scrape"
  post "realapp/scrape"=>"realapp#scrape"
	resources :mockup
  get "mockup/rfscenario/:id"=>"mockup#rfscenario"
  post "mockup/rfscenario/:id"=>"mockup#rfscenario"
  put "mockup/rfscenario/:id"=>"mockup#rfscenario"

  get "mockup/applist/:id"=>"mockup#applist"
  post "mockup/applist/:id"=>"mockup#applist"
  put "mockup/applist/:id"=>"mockup#applist"

  get "mockup/detail/:esearch/:apporder"=>"mockup#detail"
  post "mockup/detail/:esearch/:apporder"=>"mockup#detail"
  put "mockup/detail/:esearch/:apporder"=>"mockup#detail"

  get "mockup/review/:esearch/:apporder"=>"mockup#review"
  post "mockup/review/:esearch/:apporder"=>"mockup#review"
  put "mockup/review/:esearch/:apporder"=>"mockup#review"

  get "mockup/survey/:esearch"=>"mockup#survey"
  post "mockup/survey/:esearch"=>"mockup#survey"
  put "mockup/survey/:esearch"=>"mockup#survey"

  get "mockup/endsurvey"=>"mockup#endsurvey"
  post "mockup/endsurvey"=>"mockup#endsurvey"
  put "mockup/endsurvey"=>"mockup#endsurvey"

  get "mockup/thankyou"=>"mockup#thankyou"
  post "mockup/thankyou"=>"mockup#thankyou"
  put "mockup/thankyou"=>"mockup#thankyou"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
