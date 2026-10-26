class Contato < ActiveRecord::Base
  attr_accessible :nome, :sobrenome, :usuario_id
  belongs_to :usuario
  has_many :telefones

  validates :nome, presence: { message: "é obrigatório" }

  validates :sobrenome, presence: { message: "é obrigatório" }

  validates :usuario_id, presence: { message: "deve ser selecionado" }

  def self.buscar(parametro)
    if parametro.present?
      where("LOWER(nome) ILIKE :t OR LOWER(sobrenome) ILIKE :t", t: "%#{parametro.downcase}%")
    else
      scoped
    end
  end

  def id_nome_e_sobrenome
    "##{id} - #{nome} #{sobrenome}"
  end
end
