class DashboardController < AuthorizedController
  def index
    authorize! :index, :dashboard
  end
end
