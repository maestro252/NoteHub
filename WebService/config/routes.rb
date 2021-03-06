Rails.application.routes.draw do
  get 'root/index'
  root 'root#index'

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :notes

      resources :courses
      get 'courses/:id/notes', to: 'notes#index'
      post 'courses/:id/notes', to: 'notes#create'
      put 'courses/:id/notes/:note_id', to: 'notes#update'
      get 'users/usertoid/:id', to:'users#user_id_by_username'

      resources :users, only:[:index, :create, :update, :destroy, :show]
      resources :shares
      resources :schedules
      resources :groups
      resources :pals
      resources :reminders
      resources :usergroups

      post 'usergroups/:id/add', to: 'groups#add_user'
      get 'notes/group/:id', to: 'notes#index_group'

      put 'notes/:id/edit', to: 'notes#update2'
      delete 'usergroups/:id/:username', to: 'usergroups#destroy_2'
      match 'login', to: 'users#login', via: :post

    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
