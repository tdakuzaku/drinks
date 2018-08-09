module Api
	module V1
		class RecommendationsController < ApplicationController
			def index
				drinks = Drink.all.order(:created_at)
				render json: {status: 'SUCCESS', message:'Drinks recomendados', data:drinks}, status: :ok
			end
		end
	end
end