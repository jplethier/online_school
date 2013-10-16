require 'spec_helper'

describe 'Importing students' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_students_import_page) { NewStudentsImportPage.visit(subdomain: admin.account.subdomain) }

  context 'with a valid csv file' do
    context 'with all records valid' do
      it 'imports all students'
    end

    context 'but with a few invalid records' do
      it 'imports all valid students'
      it 'displays the amount of invalid records'
      it 'displays the reason why each record is invalid'
    end
  end

  context 'with an invalid file' do
    it 'displays the reason why the file is invalid'
    it 'does not import any student'
  end
end
