module Api
	module V1
		class DrinksController < ApplicationController
			def index
				drinks = Drink.all.order(:created_at)
				render json: {status: 'SUCCESS', message:'Lista de Drinks', data:drinks}, status: :ok
			end
			def show
				# SQL Injection!!!
				search =  params[:id] + '%'
				drinks = Drink.where("lower(name) like ?", search.downcase)
				render json: {status: 'SUCCESS', message:'Resultado da busca', data:drinks}, status: :ok
			end
		end
	end
end