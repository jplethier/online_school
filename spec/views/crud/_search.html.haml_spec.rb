require 'spec_helper'

describe 'crud/_search.html.haml' do
  before do
    view.stub(search_path: 'search path')
    view.stub(new_path: 'new path')
  end

  it 'displays the search param' do
    view.stub(params: { search: 'search parameter' })
    render
    expect(rendered).to include("Resultados da busca por 'search parameter'")
  end
end
