Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  root to: 'application#index'

  scope :admin do
    get :dashboard, to: 'admins#dashboard'
    get :new_survey, to: 'admins#new_survey'
    post :create_survey, to: 'admins#create_survey'
    get :new_question, to: 'admins#new_question'
    post :create_question, to: 'admins#create_question'
    get :show_surveys, to: 'admins#show_surveys'
    post :filter_surveys, to: 'admins#filter_surveys'
    get :show_survey, to: 'admins#show_survey'
  end

  resources :surveys, only: [:show] do
    member do
      resources :questions, only: [] do
        get :show
        post :update
      end
    end
  end
end
