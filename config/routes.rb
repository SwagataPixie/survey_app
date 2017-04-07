Rails.application.routes.draw do
  # root to: 'application#index', defaults: { format: 'html' }

  scope :admin do
    get :dashboard, to: 'admins#dashboard'
    get :new_survey, to: 'admins#new_survey'
    post :create_survey, to: 'admins#create_survey'
    get :new_question, to: 'admins#new_question'
    post :create_question, to: 'admins#create_question'
    get :show_survey, to: 'admins#show_survey'
    get :show_surveys, to: 'admins#show_surveys'
  end

  resources :survey, only: [:show] do
    member do
      post :update
      resources :questions do
        get :show
        post :update
      end
    end
  end
end
