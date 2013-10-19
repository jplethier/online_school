class Settings::DataImportsController < AuthorizedController
  load_and_authorize_resource

  prepend_before_filter do
    params[:data_import] &&= data_import_params
  end

  def index
  end

  def new
  end

  def create
    if @data_import.save
      redirect_to settings_data_imports_path, success: 'Classe criada com sucesso'
    else
      flash.now[:error] = 'Não foi possível criar uma classe'
      render(:new)
    end
  end

  private

  def data_import_params
    params[:data_import].delete :file if params[:data_import][:file].blank?

    params.require(:data_import).permit(:file)
  end
end
