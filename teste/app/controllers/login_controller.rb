class LoginController < ApplicationController
  skip_before_filter :exigir_login, only: [:index, :create]

  def index
  end

  def create
    usuario = Usuario.where(email: params[:email], senha: params[:senha]).first

    if !usuario.blank?
      session[:usuario_id] = usuario.id
      redirect_to agenda_path, notice: "login_sucesso"
    else
      flash.now[:alert] = "credenciais_erradas"
      render :index
    end
  end

  def destroy
    session[:usuario_id] = nil
    flash[:notice] = "saiu"
    redirect_to login_path
  end
end
