module Api
	module V1
		class DrinksController < ApplicationController
			def index
				page = params[:current].to_i
				pageSize = params[:size].to_i
				if (page > 0)
					page = page - 1
				end
				drinks = Drink.all
											.order(:created_at)
											.limit(pageSize)
											.offset(page * pageSize)
				render json: {status: 'SUCCESS', data: drinks}, status: :ok
			end
			def total
				render json: {status: 'SUCCESS', data: Drink.count}, status: :ok
			end
			def search
				page = params[:current].to_i
				pageSize = params[:size].to_i
				if (page > 0)
					page = page - 1
				end
				# SQL Injection!!!
				search =  params[:search] + '%'
				drinks = Drink.where("lower(name) like ?", search.downcase)
											.order(name: :asc)
											.limit(pageSize)
											.offset(page * pageSize)
				render json: {status: 'SUCCESS', data: drinks}, status: :ok
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