Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
  	namespace 'v1' do
  		resources :drinks, only: [:index]
  	end
  end

  root to: 'drinks#index'

  get 'api/v1/drinks/total/', :to => 'api/v1/drinks#total'
  get 'api/v1/drinks/search/:query', :to => 'api/v1/drinks#search'
  post 'api/v1/drinks/recommend/', :to => 'api/v1/drinks#recommend'

  resources :home, only: %i[index]
end
