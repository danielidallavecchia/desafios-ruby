# Caixa eletrônico

=begin 
Crie um programa que simule o funcionamento de um caixa eletrônico.
O programa deve possuir uma classe chamada Caixa.

CAIXA:
O caixa contém cédulas de:
- R$100
- R$50
- R$20
- R$10
- R$5
- R$2
Inicialmente, o caixa contém zero cédulas.
O programa deve calcular automaticamente o valor total disponível no caixa a partir da quantidade de cédulas existentes.

SAQUE:
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

DEPÓSITO
Implemente um método depositar, responsável por realizar um depósito.

O usuário informa quantas cédulas de cada valor deseja depositar.
Esse valor informado pode ser maior ou igual a zero.
A quantidade de cada cédula deve ser atualizado, somando a quantidade informada pelo usuário.

Quando o depósito foi realizado com sucesso, deverá ser exibida uma mensagem semelhante a:
Notas de $50 depositadas: 2
Notas de $2 depositadas: 1
Sucesso! 
Agora o caixa possui R$2000

Caso o depósito não possa ser realizado, deverá ser exibida uma mensagem informando o motivo e, ao final:
Depósito interrompido!
=end

class Caixa
  attr_accessor :notas, :valores_notas

  def initialize
    @notas = [
      0, # qtd de notas de 100
      0, # qtd de notas de 50
      0, # qtd de notas de 20
      0, # qtd de notas de 10
      0, # qtd de notas de 5
      0, # qtd de notas de 2
    ]
    @valores_notas = [100, 50, 20, 10, 5, 2]
  end

  def valor_total
    v = @notas[0] * @valores_notas[0] 
    v += @notas[1] * @valores_notas[1]
    v += @notas[2] * @valores_notas[2] 
    v += @notas[3] * @valores_notas[3] 
    v += @notas[4] * @valores_notas[4] 
    v += @notas[5] * @valores_notas[5]
    return v
  end

  def notas_disponiveis
    return @notas
  end

  def sacar(valor)
    erro = ""
    notas = nil

    if valor_total < valor
      erro = "=> ERRO: saldo do caixa é insuficiente para esse saque."
    else
      notas = calcular_notas(valor, 0)

      if notas.nil? || notas.size == 0 
        erro = "=> ERRO: não é possível formar esse valor com as notas disponíveis."
      end
    end

    if erro != ""
      puts erro
      puts "\n=> Saque interrompido!"
      puts "Valor disponível: R$#{valor_total}"
    else
      puts "\n=> Sucesso!"
      retirar_notas(notas)
      exibir_notas_usadas(notas)
      puts "\nValor do saque: R$#{valor}"
      puts "Agora o caixa possui R$#{valor_total}"
    end
  end

  # calcular_notas retorna um array com a contagem de cada nota
  def calcular_notas(valor_restante, indice)
    if indice == @valores_notas.size
      if valor_restante == 0
        return []
      else
        return nil
      end
    end

    valor_nota = @valores_notas[indice]
    disponivel = @notas[indice]
    qtd_necessaria = (valor_restante / valor_nota).floor

    maximo = [qtd_necessaria, disponivel].min

    maximo.downto(0) do |qtd| # percorre de maximo até zero
      valor_retirado = qtd * valor_nota
      resto = calcular_notas(valor_restante-valor_retirado, indice+1)
      if !resto.nil?
        return [qtd] + resto #adicionando o maior sempre no inicio, quando desempilha
      end
    end

    return nil
  end

  def exibir_notas_usadas(notas)
    notas.each_with_index do |n, i|
      if n > 0
        puts "Notas de R$#{@valores_notas[i]} sacadas: #{n}"
      end
    end
  end

  def retirar_notas(notas)
    notas.each_with_index do |n, i|
      @notas[i] -= n
    end
  end

  def adicionar_notas(notas)
    notas.each_with_index do |n, i|
      @notas[i] += n
    end
  end

  def exibir_notas_inseridas(notas)
    notas.each_with_index do |n, i|
      if n > 0
        puts "Notas de R$#{@valores_notas[i]} depositadas: #{n}"
      end
    end
  end

  def depositar(valor)
    erro = ""
    valor.each do |v|
     if v < 0
        erro = "=> ERRO: quantia de cédula deve ser maior ou igual a zero."
      end
    end

    if erro != ""
      puts erro
      puts "\n=> Depósito interrompido!"
      puts "Valor disponível: R$#{valor_total}"
    else
      puts "\n=> Sucesso!"

      adicionar_notas(valor)
      exibir_notas_inseridas(valor)

      puts "Agora o caixa possui R$#{valor_total}"
    end
  end

end

$c = Caixa.new

def validar_input(valor, zero)
  if valor == "" || valor.empty?
    return "\n=> ERRO: valor deve ser informado."
  elsif valor =~ /\A-?\d+[.,]\d+\z/
    return "\n=> ERRO: valor informado deve ser um número inteiro."
  elsif valor !~ /\A-?\d+\z/
    return "\n=> ERRO: valor informado deve conter apenas números."
  elsif !zero && valor.to_i <=0 
    return "\n=> ERRO: valor informado deve ser maior que zero."
  elsif zero && valor.to_i < 0 
    return "\n=> ERRO: valor informado deve ser maior ou igual a zero."
  end
  return ""
end

def executa_saque
  puts "\nInforme o valor do saque: R$"
  valor = gets.chomp

  erro = validar_input(valor, false)
  if erro != ""
    puts "#{erro}\n=> Saque interrompido!"
    return
  end

  valor = valor.to_i
  $c.sacar(valor)
end

def executa_deposito
  valor = []
  somente_zeros = true

  puts "\nInforme a quantidade de cédulas para depositar: "

  $c.valores_notas.each do |nota|
    erro = "-"

    while erro != ""
       puts "de R$#{nota}"
      v = gets.chomp

      erro = validar_input(v, true)
      if erro != ""
        puts "#{erro} \n=> Informe novamente."
      end
    end

    if v.to_i > 0 
      somente_zeros = false
    end

    valor << v.to_i
  end

  if somente_zeros
    puts "\n=> ERRO: informe ao menos uma cédula para depositar."
    puts "\n=> Depósito interrompido!"
    return
  end

  $c.depositar(valor)
end

while true
  puts "\n-------------------------------------------------------"
  puts "\nO valor disponível é: R$#{$c.valor_total}"

  puts "\nNotas disponíveis: "
  puts "* R$100 = #{$c.notas_disponiveis[0]}"
  puts "* R$50 = #{$c.notas_disponiveis[1]}"
  puts "* R$20 = #{$c.notas_disponiveis[2]}"
  puts "* R$10 = #{$c.notas_disponiveis[3]}"
  puts "* R$5 = #{$c.notas_disponiveis[4]}"
  puts "* R$2 = #{$c.notas_disponiveis[5]}"

  puts "\nEscolha a operação.\nDigite 1 para depositar ou 2 para sacar ou 3 para sair: "
  entrada = gets.chomp

  if entrada != "1" && entrada != "2" && entrada != "3"
    puts "\n=> ERRO: operação inválida. Tente novamente."
    next
  end

  if entrada.to_i == 1
    executa_deposito
  elsif entrada.to_i == 2
    executa_saque
  else
    break
  end
end
 