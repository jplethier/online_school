require 'spec_helper'

describe 'teachers/index.html.haml' do
  context 'when there are teachers' do
    it 'displays all the teachers' do
      assign(:teachers, [stub_model(User), stub_model(User)])
      render
      expect(view).to render_template(partial: '_teacher', count: 2)
    end
  end

  context 'when no teachers are found' do
    it 'does not try to display any teacher' do
      assign(:teachers, [])
      render
      expect(view).to render_template(partial: '_teacher', count: 0)
    end

    it 'displays a not found message' do
      assign(:teachers, [])
      render
      expect(rendered).to include('Nenhum professor encontrado.')
    end
  end
end
