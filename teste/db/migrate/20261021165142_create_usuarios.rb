class CreateUsuarios < ActiveRecord::Migration
  def up
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :senha
      t.date :data_nascimento
    
      t.timestamps
    end
    
  end

  def down
    drop_table :usuarios
  end
end
