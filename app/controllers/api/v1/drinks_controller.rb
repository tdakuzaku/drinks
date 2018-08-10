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
											.order(name: :asc)
											.limit(pageSize)
											.offset(page * pageSize)
				render json: {status: 'SUCCESS', data: drinks}, status: :ok
			end

			def total
				search = params[:search].downcase
				drinks = Drink.where("lower(name) like '#{search}%'").count
				render json: {status: 'SUCCESS', data: drinks}, status: :ok
			end

			def search
				page = params[:current].to_i
				pageSize = params[:size].to_i
				if (page > 0)
					page = page - 1
				end
				search =  params[:search].downcase
				drinks = Drink.where("lower(name) like '#{search}%'")
											.order(name: :asc)
											.limit(pageSize)
											.offset(page * pageSize)
				render json: {status: 'SUCCESS', data: drinks}, status: :ok
			end

			def recommend
				abv = params[:abv].to_i
				ibu = params[:ibu].to_i
				temp = params[:temp]
				target = Drink.calculate_score(abv, ibu)

				drinks = Drink.where("temperature = '#{temp}'").to_a
				# Calculates the difference between the target score
				drinks.map! {|drink|
					drink.rating_avg = target - drink.rating_avg
					drink
				}
				result = drinks.sort_by { |drink| drink.rating_avg }
				render json: {status: 'SUCCESS', data: result.reverse}, status: :ok
			end
		end
	end
end