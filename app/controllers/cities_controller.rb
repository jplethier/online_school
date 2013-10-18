class CitiesController < ApplicationController
  def get_cities_by_uf
    @cities = City.name_list(params[:uf])
    render json: @cities.to_json
  end
end
