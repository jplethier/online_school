module Helper
  FIXTURE_FOLDER = Rails.root + 'spec/fixtures'

  def fixture_image(filename)
    FIXTURE_FOLDER + filename
  end
end
