class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :exigir_login

  helper_method :usuario_logado, :logado?

  def usuario_logado
    @usuario_logado ||= Usuario.find_by_id(session[:usuario_id]) if session[:usuario_id]
  end

  def logado?
    usuario_logado.present?
  end

  def exigir_login
    redirect_to login_path, alert: "Faça login para continuar" unless logado?
  end
end
