class CreateContatos < ActiveRecord::Migration
  def up
    create_table :contatos do |t|
      t.string :nome
      t.string :sobrenome
      t.integer :usuario_id
    
      t.timestamps
    end
    
    add_index :contatos, :usuario_id
  end

  def down
  end
end
