class LoginController < ApplicationController
  skip_before_filter :exigir_login, only: [:index, :create]

  def index
  end

  def create
    usuario = Usuario.where(email: params[:email], senha: params[:senha]).first

    if usuario
      session[:usuario_id] = usuario.id
      redirect_to root_path, notice: "Bem-vindo, #{usuario.nome}!"
    else
      flash.now[:alert] = "E-mail ou senha inválidos"
      render :index
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to login_path, notice: "Você saiu."
  end
end
