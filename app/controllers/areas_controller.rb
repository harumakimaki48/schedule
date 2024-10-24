class AreasController < ApplicationController
    def by_park
      @areas = Area.where(park_id: params[:park_id])
      render json: @areas
    end
end
