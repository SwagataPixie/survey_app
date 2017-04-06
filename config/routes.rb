Rails.application.routes.draw do
  root to: 'admins#index'

  scope :admin do
    get :new_survey, to: 'admins#new_survey'
    post :update_survey, to: 'admins#update_survey'
    get :new_question, to: 'admins#new_question'
    post :update_question, to: 'admins#update_question'
    get :show_survey, to: 'admins#show_survey'
    get :show_surveys, to: 'admins#show_surveys'
  end

  resources :survey, only: [:show] do
    member do
      post :update
    end
  end
end
