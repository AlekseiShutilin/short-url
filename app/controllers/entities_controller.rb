class EntitiesController < ApplicationController

	def home
		byebug
	end

	def new
		@entity = Entity.new
	end

	def create
		@entity = Entity.new(entity_params)
		@errors_short_url = []
		@errors_url = []
		if @entity.check_fields.blank?
			if @entity.save
				flash[:info] = "Short url #{@entity.short_url} for #{@entity.url} has been successfully created"
				redirect_to root_path
			else
				@errors_short_url << @entity.errors.full_messages
				render 'new'
			end
		else
			@errors_url << @entity.check_fields
			render 'new'
		end

	end

	def show

	end

	def redirect
		@entity = Entity.find_by(short_url: params[:short_url])
		if @entity.present?
			redirect_to @entity.url.to_s
		else
			redirect_to root_path
		end
	end

	private

	def entity_params
		params.require(:entity).permit(:url, :short_url)
	end
end
