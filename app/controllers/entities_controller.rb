class EntitiesController < ApplicationController
	def new
		@entity = Entity.new
	end

	def create
		@entity = Entity.new(entity_params)
		byebug
	end

	def show

	end

	private

	def entity_params
		params.require(:entity).permit(:url, :short_url)
	end
end
