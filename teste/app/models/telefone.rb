class Telefone < ActiveRecord::Base
  attr_accessible :ddd, :numero, :contato_id
  belongs_to :contato

  validates :ddd, presence: { message: "é obrigatório" },
    format: { 
      with: /\A[0-9]+\z/, 
      message: "deve conter apenas números" 
    }
  
  validates :numero, presence: { message: "é obrigatório" },
    format: { 
      with: /\A[0-9]+\z/, 
      message: "deve conter apenas números" 
    }

  validates :contato_id, presence: { message: "deve ser selecionado" }

  def self.buscar(parametro)
    if parametro.present?
      where("ddd ILIKE :t OR numero ILIKE :t", t: "%#{parametro}%")
    else
      scoped
    end
  end
end
