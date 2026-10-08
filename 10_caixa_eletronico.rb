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
  attr_accessor :notas, :valores_notas

  def initialize
    @notas = [
      10, # notas de 100
      10, # notas de 50
      10, # notas de 20
      10, # notas de 10
      10, # notas de 5
      10, # notas de 2
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

  def sacar(valor)
    erro = ""
    notas = nil

    if valor <= 0 
      erro = "=> ERRO: valor informado deve ser maior que zero."
    elsif valor_total < valor
      erro = "=> ERRO: saldo do caixa é insuficiente para esse saque."
    else
      notas = calcular_notas(valor, 0)

      if notas.nil? || notas.size == 0 
        erro = "=> ERRO: não é possível formar esse valor com as notas disponíveis."
      end
    end

    if erro != ""
      puts erro
      puts "\nSaque interrompido!"
      puts "Valor ddisponível: R$#{valor_total}"
    else
      retirar_notas(notas)
      exibir_notas_usadas(notas)

      puts "\nSucesso!"
      puts "Valor do saque: R$#{valor}"
      puts "Agora o caixa possui R$#{valor_total}"
    end
  end

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

    # valor_retirado = maximo * valor_nota
    # if qtd_necessaria < 1 
    #   valor_retirado = 0
    # else
    #   @notas[indice] -= maximo
    #   @qtd_notas_usadas[indice] = @qtd_notas_usadas[indice] + maximo
    # end

    maximo.downto(0) do |qtd| # percorre de maximo até zero
      valor_retirado = qtd * valor_nota
      resto = calcular_notas(valor_restante-valor_retirado, indice+1)
      if !resto.nil?
        return [qtd] + resto
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

end

c = Caixa.new

puts "\n-------------------------------------------------------"
puts "\nO valor disponível é: R$#{c.valor_total}"

puts "\nInforme o valor do saque: R$"
valor = gets.chomp.to_f

puts "\n=> Iniciando saque...\n\n"

c.sacar(valor)
