Rails.application.routes.draw do

  namespace :admin do
    devise_for :users

    post 'cameras/upload_excel'
    post 'locations/upload_excel'

    resources :banks
    resources :people

    resources :locations
    resources :location_events

    resources :cameras
    resources :camera_captures

    resources :events
    resources :event_cameras

    resources :uploads

    resources :portrait_searches

    resources :problems
    resources :problem_categories

    resources :admins
    resources :engines
    resources :portraits
    get 'dashboard/index'
    root 'dashboard#index'
  end

  namespace :api do

    get 'auth/current'
    post 'auth/validate_username_password'
    post 'auth/validate_email_password'

    resources :events, only: [:index]
    resources :cameras, only: [:update]
    resources :camera_captures, only: [:create]
    resources :location_events, only: [:create, :update]
    resources :locations, only: [:index]
    resources :engines, only: [:index]
    resources :portraits, only: [:index]
  end

end
