Rails.application.routes.draw do
  resources :orders, only: %i|show|
end
