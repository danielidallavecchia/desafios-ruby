
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
Ao frear, a velocidade deve diminuir de 10 em 10 km/h e a marcha deve ser reduzida quando necessário. 
Sempre que acelerar ou frear, devem ser exibidas a marcha atual e a velocidade atual do veículo.
Ao final, criar objetos da classe Carro e testar os métodos.
=end

ACELERACAO = 10

class Carro
  attr_accessor :velocidade_máxima, :qtd_marchas, :ligado, :velocidade_atual, :marcha_atual
  attr_reader :nome, :cor
  
  def initialize(nome, cor, velocidade_máxima , qtd_marchas)
    @nome = nome
    @cor = cor
    @velocidade_máxima = velocidade_máxima
    @qtd_marchas = qtd_marchas
    @ligado = false
    @velocidade_atual = 0
    @marcha_atual = 1
  end

  def imprime_carro
    puts "\nNome: #{@nome} \nCor: #{@cor} \nVelocidade Maxima: #{@velocidade_máxima} \nQtd marcha: #{@qtd_marchas}"
    puts "Ligado: #{@ligado} \nVelocidade atual: #{@velocidade_atual} \nMarcha atual: #{@marcha_atual} \n"
  end

  def ligar
    if @ligado
      puts "\nINFO: O carro já está ligado."
    else
      self.ligado = true
      puts "\n=> Carro ligado"
    end
  end

  def desligar
    if @velocidade_atual > 0
      puts "\nERRO: O carro só pode ser desligado quando estiver parado."
    elsif !@ligado
      puts "\nINFO: O carro já está desligado."
    else 
      self.ligado = false
      puts "\n=> Carro desligado"
    end
  end

  def acelerar
    nova_velocidade = @velocidade_atual + ACELERACAO

    if nova_velocidade > @velocidade_máxima
      puts "\nERRO: velocidade máxima não pode ser excedida."
    else
      self.velocidade_atual = nova_velocidade

      trocar_marcha(true)
    puts "\n=> Carro acelerou. Velocidade atual: #{@velocidade_atual} | Marcha atual: #{@marcha_atual}"
    end
  end

  def frear
    if @velocidade_atual == 0
      return
    end

    nova_velocidade = @velocidade_atual - ACELERACAO
    if nova_velocidade < 0 
      nova_velocidade = 0
    end

    self.velocidade_atual = nova_velocidade

    trocar_marcha(false)
    puts "\n=> Carro freiou. Velocidade atual: #{@velocidade_atual} | Marcha atual: #{@marcha_atual}"
  end

  def trocar_marcha(somar)
    nova_marcha = @marcha_atual

    if @velocidade_atual % 20 == 0
      if somar 
        nova_marcha += 1
      else 
        nova_marcha -= 1
      end
    end

    if nova_marcha <= 0 
      nova_marcha = 1
    elsif nova_marcha > @qtd_marchas
      nova_marcha = @qtd_marchas
    end

    self.marcha_atual = nova_marcha
  end

end

# Instanciando...

c1 = Carro.new("sandero", "vermelho", 100, 5)

c1.desligar
c1.ligar
c1.imprime_carro


