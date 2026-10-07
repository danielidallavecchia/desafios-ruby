
# Classes em Ruby

=begin
Criar uma classe chamada Pessoa em que permita armazenar e manipular informações básicas de uma pessoa.
A classe deve possuir:
• Os atributos nome, sobrenome e idade.
• Métodos para definir e consultar o nome e o sobrenome.
• O atributo idade deve poder ser lido e alterado diretamente.
• Um método chamado nome_completo, que exiba a mensagem: Meu nome é Nome Sobrenome
• Um método chamado fazer_aniversário, que aumente a idade da pessoa em 1 ano e exiba: Parabéns! agora você tem X anos.
Ao final, crie um objeto da classe Pessoa, atribua nome, sobrenome e idade e teste os métodos nome_completo e fazer_aniversário.
=end 

class Pessoa
  attr_accessor :nome, :sobrenome, :idade 
  # attr_accessor é um helper que cria getter e setter automatico
  # outros tipos de atributo = attr_reader, attr_writer

  # construtor
  def initialize(nome, sobrenome, idade)
    @nome = nome
    @sobrenome = sobrenome
    @idade = idade
  end

  # # set e get (só criar como método se for necessário, pois o helper já cria automaticamente)
  # def nome= (nome)
  #   @nome = nome
  # end
  # def nome
  #   @nome
  # end

  # outros métodos
  def nome_completo
    "Meu nome é #{@nome} #{@sobrenome}."
  end

  def fazer_aniversário
    self.idade = idade + 1 # chama o set idade
    "Parabéns! Agora você tem #{@idade} anos."
  end

end

# Instanciando...

puts "\n"
p1 = Pessoa.new("Leli", "ndv", 22)

puts p1.nome_completo
puts p1.fazer_aniversário

puts p1.nome # get 
p1.sobrenome = "NDV" # set 
puts p1.nome_completo

puts "\n"
p2 = Pessoa.new("Xena", "do Nascimento", 11)

puts p2.nome_completo
puts p2.idade
puts p2.fazer_aniversário
