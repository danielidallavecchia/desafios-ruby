class Telefone < ActiveRecord::Base
  attr_accessible :ddd, :numero, :contato_id
  belongs_to :contato

  def self.buscar(parametro)
    if parametro.present?
      where("ddd ILIKE :t OR numero ILIKE :t", t: "%#{parametro}%")
    else
      scoped
    end
  end
end
