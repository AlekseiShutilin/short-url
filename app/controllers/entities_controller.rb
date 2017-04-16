class EntitiesController < ApplicationController
	def new
		@entity = Entity.new
	end

	def create
		@entity = Entity.new(entity_params)
		@errors_short_url = []
		@errors_url = []
		if @entity.check_fields
			if @entity.save
				flash[:info] = "Short url #{@entity.short_url} for #{@entity.url} has been successfully created"
				redirect_to root_path
			else
				@errors_short_url << @entity.errors.full_messages
				render 'new'
			end
		else
			@errors_url << 'Incorrect URL, the response should to has 200 or 302 code'
			render 'new'
		end

	end

	def show

	end

	private

	def entity_params
		params.require(:entity).permit(:url, :short_url)
	end
end
