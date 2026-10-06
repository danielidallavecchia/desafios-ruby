
# Herança:
# Classe animal e classe cachorro

class Animal
  attr_accessor :nome
  attr_reader :idade
  attr_reader :vacina_vencida # publico

  def initialize(nome)
    @nome = nome
    @idade = 0
    @vacina_vencida = false
  end

  # set idade
  def idade= (idade)
    if idade < 0
      puts "Erro: idade inválida"
    else 
      @idade = idade
    end 
  end

  def respirar
    puts "Respirando..."
  end

  def emitir_som
    puts "Algum som..."
  end

  # metodos publico que controla como o valor muda
  def vencer_vacina
    self.vacina_vencida = true  # self é obrigatório em setters
  end

  def renovar_vacina
    self.vacina_vencida = false
  end

  private
  # tudo abaixo daqui é privado e só pode ser acessado dentro da classe
  attr_writer :vacina_vencida # privado
end

class Cachorro < Animal # cachorro extends animal
  def initialize(nome, idade)
    super(nome)
    @idade = idade
  end

  def latir
    puts "Au au!"
  end

  def emitir_som
    # super() ## visita o metodo na classe pai primeiro
    puts latir
  end
end

class Gato < Animal
  def initialize(nome)
    super(nome)
  end

  def emitir_som
    puts "Miau miau!"
  end
end

# Instanciando...

a = Animal.new("animal genérico")

puts "\n"
puts a.idade
a.idade = 10
puts a.idade
puts a.nome
a.respirar
a.emitir_som

c = Cachorro.new("cachorrinho", 5)

puts "\n"
puts c.nome
puts c.idade
c.respirar
c.latir
c.emitir_som

g = Gato.new("gatinho")
puts g.nome
g.idade = 2
puts g.idade
g.emitir_som

puts g.vacina_vencida
g.vencer_vacina
# g.vacina_vencida = true # não permite alterar pois atributo é private e não existe método set publico
puts g.vacina_vencida 
