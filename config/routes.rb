Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace 'api' do
  	namespace 'v1' do
  		resources :drinks, only: [:index]
  		resources :recommendations, only: [:index]
  	end
  end

  root to: 'drinks#index'

  resources :home, only: %i[index]
end
