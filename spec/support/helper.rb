module Helper
  FIXTURE_FOLDER = Rails.root + 'spec/fixtures'

  def fixture_file(filename)
    File.new(fixture_file_path filename)
  end

  def fixture_file_path(filename)
    FIXTURE_FOLDER + filename
  end
end
