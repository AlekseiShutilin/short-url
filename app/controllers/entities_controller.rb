class EntitiesController < ApplicationController

	def new
		@entity = Entity.new
	end

	def create
		@entity = Entity.new(entity_params)
		if @entity.save
			redirect_to @entity
		else
			render 'new'
		end
	end

	def show
		@entity = Entity.find_by(id: params[:id])
	end

	def redirect
		@entity = Entity.find_by(short_url: params[:short_url])
		if @entity.present?
			redirect_to @entity.url.to_s
		else
			render file: 'public/404.html'
		end
	end

	private

	def entity_params
		params.require(:entity).permit(:url, :short_url)
	end
end
