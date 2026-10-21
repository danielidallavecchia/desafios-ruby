class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.string :nome
      t.decimal :preco, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end