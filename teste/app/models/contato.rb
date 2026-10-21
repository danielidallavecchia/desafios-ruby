class Contato < ActiveRecord::Base
  attr_accessible :nome, :sobrenome, :usuario_id
  belongs_to :usuario
  has_many :telefones

  def self.buscar(parametro)
    if parametro.present?
      where("LOWER(nome) ILIKE :t OR LOWER(sobrenome) ILIKE :t", t: "%#{parametro.downcase}%")
    else
      scoped
    end
  end
end
