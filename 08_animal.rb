
# Herança: superclasse animal com subclasses cachorro e gato
# Relacões: classe coleira (agregação) e classe veterinario (associação)

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

class Coleira
  attr_accessor :cor, :tamanho
  attr_reader :animal

  def initialize(cor, tamanho, animal)
    @cor = cor
    @tamanho = tamanho
    @animal = animal
  end

  def imprime
    puts "\nColeira #{@tamanho} cor #{@cor}."
  end
end

class Veterinario
  attr_accessor :nome

  def initialize(nome)
    @nome = nome
  end

  def iniciar_atendimento(animal)
    puts "\nVeterinário #{@nome} iniciou atendimento de #{animal.nome}"
  end

  def encerrar_atendimento(animal)
    puts "Veterinário #{@nome} encerrou o atendimento de #{animal.nome}"
  end
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

# Acessa métodos da superclasse
puts g.vacina_vencida
g.vencer_vacina
# g.vacina_vencida = true # não permite alterar pois atributo é private e não existe método set publico
puts g.vacina_vencida 

# Agregação
cl = Coleira.new("preta", "P", c)
puts "\nColeira #{cl.cor} pertence ao: #{cl.animal.nome}"

cl2 = Coleira.new("rosa", "M", g)
puts "Coleira #{cl2.cor} pertence ao: #{cl2.animal.nome}"

# Associação
v = Veterinario.new("vet")
v.iniciar_atendimento(c)
v.encerrar_atendimento(c)
