class UsuariosController < ApplicationController
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
      redirect_to usuarios_path
    else
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

    redirect_to usuarios_path
  end
end
