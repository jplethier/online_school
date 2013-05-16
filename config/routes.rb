OnlineSchool::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root to: "home#index"

  get  'contact_form', to: 'home#contact_form', as: 'contact_form'
  post 'send_contact_email', to: 'home#send_contact_email', as: 'send_contact_email'

  resources :users

  resources :students
  resources :teachers
end