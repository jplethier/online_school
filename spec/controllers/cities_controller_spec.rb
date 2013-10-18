require 'spec_helper'

describe CitiesController do
  describe 'getting cities by uf' do
    let(:city)    { stub_model(City) }
    let(:params)  { { uf: 'UF' } }

    it 'should populate @cities' do
      City.stub(:name_list) { [city] }

      get :get_cities_by_uf, params
      expect(assigns :cities).to eq [city]
    end
  end
end
