class TelefonesController < ApplicationController

  def index
    @telefones = Telefone.buscar(params[:busca]).order("id asc")
  end

  def show
    @telefone = Telefone.find(params[:id])
  end

  def new
    @telefone = Telefone.new
  end

  def create
    @telefone = Telefone.new(params[:telefone])

    if @telefone.save
      redirect_to telefones_path
    else
      render :new
    end
  end

  def edit
    @telefone = Telefone.find(params[:id])
  end

  def update
    @telefone = Telefone.find(params[:id])

    if @telefone.update_attributes(params[:telefone])
      redirect_to telefones_path
    else
      render :edit
    end
  end

  def destroy
    @telefone = Telefone.find(params[:id])
    @telefone.destroy

    redirect_to telefones_path
  end
end
