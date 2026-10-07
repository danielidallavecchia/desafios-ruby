
# Classe Carro
=begin
Crie uma classe chamada carro que simule o funcionamento básico de um veículo. 
O carro deve possuir nome, cor, velocidade máxima, quantidade de marchas, estado ligado ou desligado, velocidade atual e marcha atual. 
Implemente métodos para ligar o carro, acelerar, frear e desligar. 
O carro deve iniciar desligado, parado e na primeira marcha.
O carro só poderá ser desligado quando estiver parado e quando estiver ligado. 
O carro só poderá ser ligado quando estiver desligado.
Ao acelerar, a velocidade deve aumentar de 10 em 10 km/h, respeitando a velocidade máxima e realizando 
  a troca de marchas quando necessário(a marcha troca de 20 em 20). 
A velocidade máxima que o carro pode atingir é a velocidade máxima informada pelo usuário.
Ao frear, a velocidade deve diminuir de 10 em 10 km/h e a marcha deve ser reduzida quando necessário. 
Sempre que acelerar ou frear, devem ser exibidas a marcha atual e a velocidade atual do veículo.
Ao final, criar objetos da classe Carro e testar os métodos.
Plus: classes pneu (agregação) e motor (composição) relacionadas ao carro

Interação via terminal:
* solicitar ao usuário nome, cor, velocidade máxima e quantidade de marchas 
* loop que solicite ao usuário comandos para mover o carro: 
  ligar
  desligar
  acelerar
  frear
=end

ACELERACAO = 10
MARCHA = 20

class Carro
   attr_accessor :velocidade_maxima, :qtd_marchas, :nome, :cor, 
    :ligado, :velocidade_atual, :marcha_atual, :pneus, :motor
  
  def initialize(nome, cor, velocidade_maxima , qtd_marchas, tipo_motor)
    @nome = nome
    @cor = cor
    @velocidade_maxima = velocidade_maxima
    @qtd_marchas = qtd_marchas
    @ligado = false
    @velocidade_atual = 0
    @marcha_atual = 1

    @pneus = []
    @motor = Motor.new(tipo_motor)
  end

  def imprime
    aux = @ligado ? "sim" : "não"
    puts "\nNome: #{@nome} \nCor: #{@cor} \nVelocidade Maxima: #{@velocidade_maxima} km/h \nQtd marcha: #{@qtd_marchas}"
    puts "Ligado: #{aux} \nVelocidade atual: #{@velocidade_atual} km/h \nMarcha atual: #{@marcha_atual} \n"
  end

  def imprime_carro
    puts "\nNome: #{@nome} \nCor: #{@cor} \nVelocidade Maxima: #{@velocidade_maxima} km/h \nQtd marcha: #{@qtd_marchas}"
    puts "Ligado: #{@ligado} \nVelocidade atual: #{@velocidade_atual} km/h \nMarcha atual: #{@marcha_atual} \n"
    puts "Motor: tipo #{@motor.tipo}"

    p = []
    for i in 0...@pneus.size
      p << "aro #{@pneus[i].aro} marca #{@pneus[i].marca}"
    end

    puts "Pneus: [#{p.join(", ")}]"
  end

  def ligar
    if @ligado
      puts "\nINFO: O carro já está ligado."
      imprime_estado("")
    else
      @ligado = true
      imprime_estado(" ligou")
    end
  end

  def desligar
    if !@ligado
      puts "\nINFO: O carro já está desligado."
      imprime_estado("")
    elsif @velocidade_atual > 0
      puts "\nERRO: O carro só pode ser desligado quando estiver parado."
      imprime_estado("")
    else 
      @ligado = false
      imprime_estado(" desligou")
    end
  end

  def acelerar
    if !@ligado
      puts "\nERRO: ligue o carro antes de acelerar."
      imprime_estado("")
      return
    end
    
    if @velocidade_atual >= @velocidade_maxima
      puts "\nINFO: velocidade máxima (#{formata(@velocidade_maxima)} km/h) não pode ser excedida."
      imprime_estado("")
      return
    end

    nova_velocidade = @velocidade_atual + ACELERACAO
    @velocidade_atual = [nova_velocidade, @velocidade_maxima].min
    trocar_marcha

    if @velocidade_atual == @velocidade_maxima
      puts "\nINFO: velocidade máxima (#{formata(@velocidade_maxima)} km/h) atingida!"
    end

    imprime_estado(" acelerou")
  end

  def frear
    if !@ligado
      puts "\nERRO: ligue o carro antes de frear."
      imprime_estado("")
      return
    end

    if @velocidade_atual == 0
      puts "\n=> Não pode frear, o carro já está parado. Velocidade atual: #{@velocidade_atual} | Marcha atual: #{@marcha_atual}"
      return
    end

    nova_velocidade = @velocidade_atual - ACELERACAO
    @velocidade_atual = [nova_velocidade, 0].max

    trocar_marcha
    imprime_estado(" freou")
  end

  def instalar_pneus(p1, p2, p3, p4)
    @pneus[0] = p1
    @pneus[1] = p2
    @pneus[2] = p3
    @pneus[3] = p4
  end

  def imprime_estado(acao)
    puts "=> Carro '#{@nome}'#{acao}. Velocidade atual: #{formata(@velocidade_atual)} | Marcha atual: #{@marcha_atual} | Ligado: #{@ligado ? "sim" : "não"}"
  end

  private

  attr_writer :ligado, :velocidade_atual, :marcha_atual

  def trocar_marcha
    nova_marcha = @velocidade_atual.to_i / MARCHA + 1
    # puts "nova_marcha = #{nova_marcha}"

    if nova_marcha <= 0 
      nova_marcha = 1
    end

    @marcha_atual = [nova_marcha, @qtd_marchas].min
  end

  def formata(valor)
    valor == valor.to_i ? valor.to_i : valor.round(2)
  end
end

class Pneu
  attr_accessor :aro, :marca

  def initialize(aro, marca)
    @aro = aro
    @marca = marca
  end
end

class Motor
  attr_accessor :tipo

  def initialize(tipo)
    @tipo = tipo
  end
end

# Interação

puts "\n------------------------------------------------------"
puts "\n------------------Monte seu carro---------------------"
puts "\n------------------------------------------------------"

puts "\nInforme nome do carro: "
nome = gets.chomp.to_s

puts "Informe cor do carro: "
cor = gets.chomp.to_s

puts "Informe a velocidade máxima (km/h): "
velocidade = gets.chomp.to_f

puts "Informe a quantidade de marchas: "
marchas = gets.chomp.to_i

erro = false
if velocidade <= 0 
  puts "\n=> Erro: informe uma velocidade máxima maior que zero"
  erro = true
end

if !erro
  carro = Carro.new(nome, cor, velocidade, marchas, "teste")
  carro.imprime

  puts "\nMovimente seu carro: "
  puts "Opções disponíveis: 'ligar', 'desligar', 'acelerar', 'frear', 'sair'"

  while true
    puts "\n------------------------------------------------------"
    acao = gets.chomp.downcase

    if acao == "sair" || acao == ""
      break
    end

    if acao == "ligar"
      carro.ligar

    elsif acao == "desligar"
      carro.desligar

    elsif acao == "acelerar"
      carro.acelerar

    elsif acao == "frear"
      carro.frear

    else 
      puts "\nERRO: ação inválida."
    end

  end

end

# # Testes manuais:
# puts "\n-------------------------------------------------------"
# c1 = Carro.new("sandero", "vermelho", 100, 5, "flex")
# c1.desligar
# c1.ligar
# c1.imprime_carro
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.frear
# c1.acelerar
# c1.frear
# c1.acelerar
# c1.acelerar
# c1.frear
# c1.frear
# c1.frear
# c1.desligar
# c1.acelerar
# c1.frear
# c1.frear
# c1.desligar
# c1.ligar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.acelerar
# c1.desligar
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.frear
# c1.desligar

# puts "\n-------------------------------------------------------"
# c2 = Carro.new("fusca", "azul", 40, 3, "flex")
# c2.imprime_carro
# c2.ligar
# c2.ligar
# c2.acelerar
# c2.acelerar
# c2.acelerar
# c2.acelerar
# c2.acelerar
# c2.desligar
# c2.frear
# c2.frear
# c2.frear
# c2.frear
# c2.frear
# c2.desligar
# c2.desligar
# # c2.velocidade_atual = 999 # não deve permitir pq atributo é private

# puts "\n-------------------------------------------------------"
# c3 = Carro.new("mobi", "branco", 90, 5, "diesel")
# c3.imprime_carro
# p1 = Pneu.new(15, "Pirelli")
# p2 = Pneu.new(15, "Goodyear")
# p3 = Pneu.new(15, "Pirelli")
# p4 = Pneu.new(15, "Pirelli")

# c3.instalar_pneus(p1, p2, p3, p4)
# c3.imprime_carro
