Custom::Application.routes.draw do
  resources :custom_videos
  resources :orders
  resources :item_categories
  #devise_for :performers
  devise_for :white_labels
  root :to => "orders#new"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  match 'get_image', to: 'home#get_image', via: [:get, :post]
  match "performers/update_amount", to: 'performers#update_amount', via: [:get, :post]
  match "performers/update_quality_amount", to: 'performers#update_quality_amount', via: [:get, :post]
  match "performers/update_duration_amount", to: 'performers#update_duration_amount', via: [:get, :post]
  match "performers/update_delivery_time_amount", to: 'performers#update_delivery_time_amount', via: [:get, :post]
  match "performers/performer_dashboard", to: 'performers#performer_dashboard', via: [:get, :post]
  match "admin_dashboard", to: 'home#admin_dashboard', via: [:get, :post]
  resources :performers
  #get 'performers/price', :controller => 'performers', :action => 'price'
end
