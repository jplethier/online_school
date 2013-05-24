require 'spec_helper'

describe 'students/index.html.haml' do
  context 'when there are students' do
    it 'displays all the students' do
      assign(:students, [stub_model(User), stub_model(User)])
      render
      expect(view).to render_template(partial: '_student', count: 2)
    end
  end

  context 'when no students are found' do
    it 'does not try to display any student' do
      assign(:students, [])
      render
      expect(view).to render_template(partial: '_student', count: 0)
    end

    it 'displays a not found message' do
      assign(:students, [])
      render
      expect(rendered).to include('Nenhum aluno encontrado.')
    end
  end
end
