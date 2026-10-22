class ContatosController < ApplicationController

  before_filter :carregar_usuarios, only: [:new, :edit, :create, :update]

  def carregar_usuarios
    @usuarios = Usuario.order(:id) 
  end

  def index
    @contatos = Contato.buscar(params[:busca]).order("id asc")
  end

  def show
    @contato = Contato.find(params[:id])
  end

  def new
    @contato = Contato.new
    @contato.usuario_id = session[:usuario_id]
  end

  def create
    @contato = Contato.new(params[:contato])
    @contato.usuario_id = session[:usuario_id]

    if @contato.save
      redirect_to contatos_path
    else
      render :new
    end
  end

  def edit
    @contato = Contato.find(params[:id])
    @contato.usuario_id = session[:usuario_id]
  end

  def update
    @contato = Contato.find(params[:id])
    @contato.usuario_id = session[:usuario_id]

    if @contato.update_attributes(params[:contato])
      redirect_to contatos_path
    else
      render :edit
    end
  end

  def destroy
    @contato = Contato.find(params[:id])
    @contato.destroy

    redirect_to contatos_path
  end
end
