module Api
	module V1
		class DrinksController < ApplicationController
			def index
				drinks = Drink.all.order(:created_at)
				render json: {status: 'SUCCESS', message:'Lista de Drinks', data:drinks}, status: :ok
			end
		end
	end
end