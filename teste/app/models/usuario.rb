class Usuario < ActiveRecord::Base
  attr_accessible :nome, :email, :senha, :data_nascimento ## accessible = quais colunas do banco podem ser salvas em massa
  has_many :contatos

  validate :valida_data_nascimento

  validates :nome, presence: { message: "é obrigatório" }

  validates :email, presence: { message: "é obrigatório" }, 
    uniqueness: { message: "já existe" }, 
    format: { 
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
      message: "não é um e-mail válido" }

  validates :senha, length: { minimum: 4, message: "deve ter pelo menos 4 caracteres" }

  def self.buscar(parametro)
    if parametro.present?
      where("LOWER(nome) ILIKE :t OR LOWER(email) ILIKE :t", t: "%#{parametro.downcase}%")
    else
      scoped
    end
  end

  def valida_data_nascimento
    if data_nascimento.present? && data_nascimento > Date.today
      errors.add(:data_nascimento, "não pode ser no futuro")
    end
  end

end
