OnlineSchool::Application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  root to: "application#index"
end