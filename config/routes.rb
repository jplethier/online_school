OnlineSchool::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }, skip: :sessions

  post 'find_account', to: 'accounts#find_account'

  get  'contact_form', to: 'home#contact_form', as: 'contact_form'
  post 'send_contact_email', to: 'home#send_contact_email', as: 'send_contact_email'

  constraints subdomain: /^(?!www\b)(\w+)/ do
    devise_for :users, only: :sessions

    get 'dashboard', to: 'dashboard#index'

    resources :students
    resources :teachers
    resources :users

    root to: 'dashboard#index', as: :authenticated_root
  end

  root to: 'home#index'
end
