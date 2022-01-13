class ApplicationController < ActionController::Base
  before_action :set_locale
  # Este metodo le dice a los usuarios que solo los usuarios autenticados puedan ingresar a las rutas
  before_action :authenticate_user!
  
  # puede capturar la expecion y darle un mejor manejoa a la misma
  rescue_from CanCan::AccessDenied do |expection|
    redirect_to root_path
  end

  
  def set_locale
    I18n.locale = 'es'
  end
end
