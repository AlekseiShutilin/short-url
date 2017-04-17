class Api::EntitiesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
    @entities = Entity.all
    render json: @entities
  end

  def create

    @entity = Entity.new entity_params
    if @entity.save
      render json: @entity
    else
      render json: @entity.errors.full_messages
    end
  end

  private
  def entity_params
    params.require(:data).require(:entity).permit(:url, :short_url)
  end

end