Rails.application.routes.draw do
  root to: 'drinks#index'

  get 'api/v1/drinks/', :to => 'api/v1/drinks#index'
  get 'api/v1/drinks/total/', :to => 'api/v1/drinks#total'
  get 'api/v1/drinks/search/', :to => 'api/v1/drinks#search'
  post 'api/v1/drinks/recommend/', :to => 'api/v1/drinks#recommend'

  resources :home, only: %i[index]
end
