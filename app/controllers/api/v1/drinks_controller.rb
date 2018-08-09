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
			def recommend
				margin = 10
				minAbv = (params[:abv].to_i - margin).to_s
				minIbu = (params[:ibu].to_i - margin).to_s
				maxAbv = (params[:abv].to_i + margin).to_s
				maxIbu = (params[:ibu].to_i + margin).to_s
				query = "((alcohol_level >" + minAbv + " AND alcohol_level <= " + maxAbv + ")"
				query << " OR (ibu >" + minIbu + " AND ibu <= " + maxIbu + "))"
				query << " AND temperature =" + params[:temp]
				drinks = Drink.where(query)
				render json: {status: 'SUCCESS', message:'Resultado da busca', data:drinks}, status: :ok
			end
		end
	end
end