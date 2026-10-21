class ProdutosController < ApplicationController

  def index
    @produtos = Produto.order("id ASC")
  end

  def show
    @produto = Produto.find(params[:id])
  end

  def create
    produto = Produto.new(
      :nome => params[:nome],
      :preco => params[:preco]
    )

    if produto.save
      redirect_to "/produtos"
    else
      render :text => produto.errors.full_messages.join(", "),
            :status => 422
    end
  end

  def update
    produto = Produto.find(params[:id])

    if produto.update_attributes(
      :nome => params[:nome],
      :preco => params[:preco]
    )
      redirect_to "/produtos/#{produto.id}"
    else
      render :text => produto.errors.full_messages.join(", "),
             :status => 422
    end
  end

  def destroy
    produto = Produto.find(params[:id])
    produto.destroy

    redirect_to "/produtos"
  end

  def new
  end

  def edit
    @produto = Produto.find(params[:id])
  end

  def update
    produto = Produto.find(params[:id])

    if produto.update_attributes(
      :nome => params[:nome],
      :preco => params[:preco]
    )
      redirect_to "/produtos"
    else
      render :text => produto.errors.full_messages.join(", "),
            :status => 422
    end
  end

end
