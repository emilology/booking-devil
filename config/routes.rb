Rails.application.routes.draw do
  devise_for :admins, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  resources :admins, except: :destroy
  resources :bookings
  root :to => "bookings#new"
  # get 'bookings/:id' =>'booking#show'

# SimpleCms::Application.routes.draw do
  get 'pages/admin'
  get 'welcome/index'
  get 'layouts/application'
  get 'number/number'

end

#
#   resources :bookings
#   resources :tables
#   root :to => "tables#home"
#
# end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  # get 'pages/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: booking.id)
  #   get 'bookings/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :bookings

  # Example resource route with options:
  #   resources :bookings do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

 #Bookings

  # Example resource route with sub-resources:
  #   resources :bookings do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :bookings do
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
