class CreateTelefones < ActiveRecord::Migration
  def up
    create_table :telefones do |t|
      t.string :ddd
      t.string :numero
      t.integer :contato_id
    
      t.timestamps
    end
    
    add_index :telefones, :contato_id
  end

  def down
    drop_table :telefones
  end
end
