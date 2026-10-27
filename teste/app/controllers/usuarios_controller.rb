class UsuariosController < ApplicationController
  skip_before_filter :exigir_login, only: [:new, :create]

  before_filter :carregar_contatos, only: [:new, :edit, :create, :update]

  def carregar_contatos
    @contatos = Contato.order(:id)
  end
  
  def index
    @usuarios = Usuario.buscar(params[:busca]).order("id asc")
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(params[:usuario])

    if @usuario.save
      redirect_to usuarios_path, notice: "sucesso_create"
    else
      flash.now[:error] = "erro_create"
      render :new
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])

    if @usuario.update_attributes(params[:usuario])
      redirect_to usuarios_path
    else
      render :edit
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    redirect_to usuarios_path, notice: "deletar_sucesso"
  end

  def muda_senha
  end

  def atualiza_senha
    if usuario_logado.senha != params[:senha_atual]
      flash.now[:alert] = "Senha atual incorreta"
      render :muda_senha
    elsif params[:nova_senha].blank?
      flash.now[:alert] = "Informe a nova senha"
      render :muda_senha
    elsif params[:nova_senha] != params[:confirmacao]
      flash.now[:alert] = "A confirmação de senhas não confere"
      render :muda_senha
    else
      usuario_logado.update_attribute(:senha, params[:nova_senha])
      redirect_to root_path, notice: "Senha alterada com sucesso!"
    end
  end
end
