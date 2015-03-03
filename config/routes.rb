TestLinkedin::Application.routes.draw do
  get "home/index"

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

# Home page
scope :controller => :home do
    match 'candidate'       => :candidate
    match 'submit_resume'   => :submit_resume
    match 'resume_sent'     => :resume_sent
    match 'enquiry'         => :enquiry
    match 'enquire'         => :enquire
    match 'post_a_job'      => :post_a_job
    match 'post_job'        => :post_job
    match 'posted'          => :posted
    match 'about'           => :about
    match 'history'         => :history
    match 'employer'        => :employer
    match 'submit_linkedin_resume'    => :submit_linkedin_resume
    match 'submit_linkedin_resume_cb' => :submit_linkedin_resume_cb
    match 'terms'           => :terms
    match 'privacy'         => :privacy
    match 'contact'         => :contact
end



  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "home#index"
  # See how all your routes lay out with "rake routes"
  resources :home

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
