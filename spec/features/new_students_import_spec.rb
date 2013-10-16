require 'spec_helper'

describe 'Importing students' do
  before { login_as_user admin }

  let(:admin) { FactoryGirl.create(:admin) }
  let(:new_students_import_page) { NewStudentsImportPage.visit(subdomain: admin.account.subdomain) }

  describe 'with a valid csv file' do
    context 'with all records valid' do
      let(:file) { fixture_file_path 'all_records_valid.csv' }

      it 'imports the file' do
        new_students_import_page.file = file
        new_students_import_page.import

        data_import = DataImport.last
        expect(data_import.file).to exist
      end

      it 'imports all students' do
      end
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
