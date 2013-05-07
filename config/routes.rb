OnlineSchool::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: 'registrations' }

  ActiveAdmin.routes(self)

  root to: 'application#index'
end
