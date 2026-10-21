class Usuario < ActiveRecord::Base
  attr_accessible :nome, :email, :senha, :data_nascimento
  has_many :contatos

  def self.buscar(parametro)
    if parametro.present?
      where("LOWER(nome) ILIKE :t OR LOWER(email) ILIKE :t", t: "%#{parametro.downcase}%")
    else
      scoped
    end
  end
  
end
