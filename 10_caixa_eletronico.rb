# Caixa eletrônico

=begin 
Crie um programa que simule o funcionamento de um caixa eletrônico.

O programa deve possuir uma classe chamada Caixa.
Ao ser criado, o caixa deve iniciar com 10 notas de cada valor:
- R$100
- R$50
- R$20
- R$10
- R$5
- R$2
O programa deve calcular automaticamente o valor total disponível no caixa a partir da quantidade de notas existentes.

Implemente um método chamado sacar, responsável por realizar um saque.
Ao realizar um saque, o programa deve:
- Mostrar o valor total disponível no caixa.
- Solicitar ao usuário o valor que deseja sacar.
- Verificar se o valor informado é maior que zero.
- Verificar se o valor solicitado não é maior que o dinheiro disponível no caixa.
- Verificar se existe uma combinação das notas disponíveis capaz de formar exatamente o valor solicitado.
- Utilizar apenas notas que ainda estejam disponíveis no caixa.
- Informar quantas notas de cada valor foram utilizadas no saque.
- Atualizar a quantidade de notas disponíveis.
- Atualizar o valor total existente no caixa.

O caixa não possui notas ou moedas de R$1. Portanto, valores que não possam ser formados utilizando as notas disponíveis devem ser recusados.
Por exemplo, valores como: R$1 e R$3 não podem ser sacados.
Também devem ser considerados casos em que, apesar de existir dinheiro suficiente no caixa, as notas disponíveis não permitem formar o valor solicitado.
Por exemplo, se restarem apenas determinadas notas e o usuário solicitar R$65, o programa deverá verificar se existe alguma combinação 
  das notas restantes que resulte exatamente em R$65.
Caso o programa comece a separar notas e descubra posteriormente que não é possível completar o saque, nenhuma nota deve 
  ser retirada do caixa. Todas as alterações realizadas durante aquela tentativa devem ser desfeitas.

Quando o saque for realizado com sucesso, deverá ser exibida uma mensagem semelhante a:
Notas de R$50 sacadas: 1
Notas de R$10 sacadas: 1
Notas de R$5 sacadas: 1
Sucesso! 
Agora o caixa possui R$1805

Caso o saque não possa ser realizado, deverá ser exibida uma mensagem informando o motivo e, ao final:
Saque interrompido!
=end

class Caixa
  attr_accessor :nota100, :nota50, :nota20, :nota10, :nota5, :nota2

  def initialize
    @nota100 = 10 # 1000
    @nota50 = 10 # 500
    @nota20 = 10 # 200
    @nota10 = 10 # 100
    @nota5 = 10 # 50
    @nota2 = 10 # 20
  end

  def valor_total
    v = @nota100 * 100 + @nota50 * 50 + @nota20 * 20 + @nota10 * 10 + @nota5 * 5 + @nota2 * 2
    v.to_f.round(2)
  end

  def sacar(valor)
    erro = ""

    if valor <= 0 
      erro = "=> ERRO: valor informado deve ser maior que zero"
    elsif valor_total < valor
      erro = "=>ERRO: saldo do caixa é insuficiente para esse saque"
    end

    ## TODO:
    # verificar se notas disponiveis conseguem formar o valor, se não retornar erro

    ## TODO
    # exibir quantas notas de cada tipo foram sacadas

    if erro != ""
      puts erro
      puts "Saque interrompido!"
    else
      puts "Sucesso!"
      puts "Valor do saque: R$#{valor}"
      puts "Agora o caixa possui R$#{valor_total}"
    end
  end

end

c = Caixa.new

puts "\nO valor disponível é: R$#{c.valor_total}"

puts "\nInforme o valor do saque: R$"
valor = gets.chomp.to_f

puts "\n-------------------------------------------------------"
puts "Iniciando saque...\n\n"

c.sacar(valor)

puts "\n-------------------------------------------------------"
