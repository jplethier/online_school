class CitiesController < ApplicationController
  def get_cities_by_uf
    @cities = City.find_by_uf(params[:uf]).select(:name).order(:name)
    render json: @cities.to_json
  end
end
