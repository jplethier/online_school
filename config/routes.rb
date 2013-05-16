OnlineSchool::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root to: "application#index"

  get 'contact_form', to: 'application#contact_form', as: 'contact_form'

  resources :users

  resources :students
  resources :teachers
end