class SettingsController < AuthorizedController
  def show
    authorize! :show, :settings
  end
end
