
# Elevador

=begin 

Crie um sistema que simule um elevador inteligente de um prédio com 20 andares, sendo o térreo representado pelo número 0. 
O elevador deve iniciar no térreo, parado, com a porta fechada e sem passageiros. 
Cada pessoa deve possuir um id, nome, andar de origem, andar de destino e peso. 

O elevador suporta no máximo 8 pessoas e no máximo 600 kg ao mesmo tempo. 
Uma pessoa só pode entrar se houver espaço tanto na quantidade de pessoas quanto no peso máximo permitido. 
Caso não possa entrar, deve continuar esperando no andar.
Pessoas que estão esperando devem ser armazenadas pelo sistema até serem atendidas.

O elevador deve possuir chamadas externas e internas. 
Uma chamada externa acontece quando uma pessoa informa o andar onde está e para qual andar deseja ir.
O sistema deve descobrir automaticamente se essa pessoa deseja subir ou descer. 
Depois que a pessoa entrar no elevador, o destino dela passa a ser uma parada interna. 
Uma pessoa nunca pode escolher como destino o mesmo andar em que está, um andar menor que 0 ou maior que 20.

O elevador não pode simplesmente atender as chamadas na ordem em que elas foram realizadas.
Ele deve organizar as paradas de acordo com sua direção atual. 
Enquanto estiver subindo, deve priorizar os destinos internos acima do andar atual e as pessoas que estão acima do elevador e também desejam subir. 
Chamadas de pessoas que desejam descer devem permanecer esperando até que o elevador esteja descendo. 
Enquanto estiver descendo, deve fazer o comportamento contrário. 
O elevador só pode inverter a direção quando não existir mais nenhuma parada válida na direção atual.

O método de movimentação deve deslocar o elevador somente um andar por vez. 
Por exemplo, se o elevador estiver no andar 4 e precisar chegar ao andar 10, cada chamada do método mover deve alterar o andar para 5, depois 6, depois 7 e assim por diante. 
O elevador não pode se mover enquanto a porta estiver aberta. 
A porta só pode ser aberta quando o elevador estiver completamente parado. 
Ao chegar a um andar, o elevador deve primeiro verificar se existem passageiros dentro dele cujo destino seja aquele andar. 
Essas pessoas devem sair antes de qualquer outra pessoa entrar. 
Somente depois disso o elevador deve verificar quem está esperando naquele andar. 
Se existirem várias pessoas esperando na mesma direção, elas devem entrar na ordem em que fizeram a chamada, desde que ainda exista capacidade de pessoas e peso. 
Se a próxima pessoa da fila for pesada demais para entrar, ela não deve bloquear as demais pessoas: o elevador deve verificar se alguma das pessoas seguintes consegue entrar sem ultrapassar o limite. 
Quem não entrar permanece esperando.

O sistema deve impedir chamadas duplicadas feitas pela mesma pessoa. 
Uma pessoa não pode estar simultaneamente dentro do elevador e esperando em um andar. 
Uma pessoa que já chegou ao seu destino não pode continuar registrada como passageiro ou como chamada pendente.

O sistema também deve possuir um modo de emergência. 
Quando o método emergencia for chamado, o elevador deve cancelar temporariamente sua lógica normal, não deve aceitar novos passageiros e deve 
levar todas as pessoas que já estão dentro para o térreo. 
Durante a emergência, chamadas externas continuam registradas, porém não são atendidas. 
Quando todas as pessoas tiverem saído no térreo, o elevador deve permanecer parado, com a porta aberta e em estado de emergência. 
O método liberar_emergencia deve encerrar esse estado, fechar a porta e permitir que as chamadas pendentes voltem a ser atendidas.
Caso o elevador esteja acima do térreo no momento em que a emergência for ativada, ele deve descer. 
Porém, se houver passageiros dentro com destino em andares abaixo do andar atual, eles não devem sair nesses andares durante a emergência: todos devem ser levados obrigatoriamente ao térreo. 
Se o elevador estiver abaixo do térreo, situação que normalmente não deveria acontecer, o programa deve detectar o erro e impedir a movimentação até que o estado seja corrigido.

O elevador também deve controlar o número de viagens realizadas. 
Uma viagem é considerada concluída sempre que o elevador muda de direção ou fica sem nenhuma solicitação pendente depois de atender pelo menos uma parada. 
Também deve controlar a distância total percorrida em andares. 
Sair do andar 2 e chegar ao andar 7 representa 5 andares percorridos.

O sistema deve possuir manutenção automática. 
Após percorrer 100 andares desde a última manutenção, o elevador deve entrar no estado manutencao_pendente. 
Nesse estado ele pode terminar de levar os passageiros que já estão dentro até seus destinos, mas não pode aceitar novos passageiros. 
Quando ficar vazio, deve se dirigir ao térreo. 
Ao chegar ao térreo, deve ficar parado e não aceitar nenhuma movimentação até que o método realizar_manutencao seja executado. 
Esse método deve zerar apenas o contador de distância desde a última manutenção, mantendo o contador de distância total desde a criação do elevador.
Se uma emergência acontecer enquanto existe manutenção pendente, a emergência possui prioridade. 
Depois que a emergência for liberada, o elevador deve voltar ao estado de manutenção pendente e seguir para o térreo caso ainda não esteja nele.

O sistema deve possuir os métodos adicionar_pessoa, chamar, mover, abrir_porta, fechar_porta, emergencia, liberar_emergencia, realizar_manutencao e estado. 
Você pode criar outros métodos auxiliares se considerar necessário. 
Todas as regras devem ser implementadas utilizando somente recursos compatíveis com ruby 2.1.2, sem gems externas.
O método estado deve mostrar o andar atual, a direção atual, se a porta está aberta ou fechada, se existe emergência ativa, se existe manutenção 
  pendente, quantidade de pessoas dentro do elevador, peso atual, capacidade restante, passageiros dentro com seus respectivos destinos, pessoas 
  esperando em cada andar, próximas paradas previstas, distância total percorrida, distância percorrida desde a última manutenção e quantidade de viagens concluídas.

Considere o seguinte caso de teste: 
- o elevador está no andar 3 subindo com 6 pessoas e peso atual de 430 kg. 
- existem duas pessoas dentro querendo sair no andar 8, uma querendo sair no andar 12 e três querendo sair no andar 15. 
- no andar 5 existem três pessoas querendo subir, com pesos de 90 kg, 45 kg e 70 kg, nessa ordem. 
- no andar 7 existe uma pessoa querendo descer para o andar 2. 
- no andar 10 existem duas pessoas querendo subir para o andar 18. 
- quando o elevador chegar ao andar 5, ele possui espaço para apenas duas pessoas pela quantidade máxima, mas também deve respeitar o peso máximo. 
- se a primeira pessoa não puder entrar pelo peso, o sistema deve verificar as próximas. 
- a pessoa que deseja descer no andar 7 não deve entrar enquanto o elevador estiver subindo. 
- depois que os passageiros do andar 8 saírem, novas vagas são liberadas, mas o elevador não deve voltar imediatamente ao andar 5 se ainda existirem paradas válidas acima dele. 
- somente depois de terminar os atendimentos da direção atual ele poderá inverter a direção e voltar para atender quem ficou esperando.

Outro caso obrigatório: 
- o elevador está no andar 14 subindo e possui passageiros com destinos 17 e 20. 
- existem chamadas no andar 16 para descer, no andar 18 para subir e no andar 9 para subir. 
- ele deve atender o andar 18 durante a subida, passar pelo andar 16 sem buscar a pessoa que deseja descer, atender os destinos internos restantes e somente 
  depois inverter a direção para atender o andar 16. 
- a chamada do andar 9 deve continuar pendente até que faça sentido de acordo com a nova direção do elevador.
- o programa deve funcionar corretamente mesmo quando novas chamadas forem adicionadas enquanto o elevador já estiver em movimento. 
- se uma nova chamada surgir acima do elevador e for compatível com a direção atual, ela pode entrar na rota atual. 
- se surgir atrás do elevador ou em direção incompatível, deve aguardar uma próxima passagem.

Regras de desenvolvimento:
- não utilize sleep para controlar a lógica
- não considere que as chamadas serão previamente conhecidas
- não resolva o problema criando manualmente uma sequência fixa de andares. 
- o sistema deve tomar todas as decisões com base no estado atual do elevador, nos passageiros e nas chamadas que ainda estão pendentes.
- não usa sort nem sort_by.
- não usa min, max, min_by, max_by, find, detect, select, reject, include?, any?, all?, uniq, map, ou métodos semelhantes que 
  realizem buscas, filtros, ordenações ou verificações automaticamente.
=end

def executar_testes
  # Testes manuais para validar cenários

  def teste1
    puts "*************************** TESTE 1 ***************************"
    puts "TESTE: Impedir chamada para o andar errado"
    e = Elevador.new
    pessoa = Pessoa.new(1, "Leli", 60)
    e.chamar(pessoa, 0, 0)
    e.chamar(pessoa, 0, -1)
    e.chamar(pessoa, 0, 21)
    e.chamar(pessoa, -2, 10)
  end

  def teste2
    puts "*************************** TESTE 2 ***************************"
    puts "TESTE: Validar peso máximo"
    e = Elevador.new
    pessoa1 = Pessoa.new(2, "Leli", 50)
    pessoa2 = Pessoa.new(5, "Xena", 551)
    e.chamar(pessoa1, 0, 2)
    e.chamar(pessoa2, 0, 2)
    e.movimentar
  end

  def teste3
    puts "*************************** TESTE 3 ***************************"
    puts "TESTE: Validar quantidade máxima. Pessoa que não consegue entrar continua esperando"
    e = Elevador.new
    9.times do |i|
      pessoa = Pessoa.new(i+1, "p#{i+1}", 50)
      e.chamar(pessoa, 0, 1)
    end

    puts "\nPessoas esperando: "
    e.pessoas_esperando

    5.times { e.movimentar }

    puts "\nPessoas esperando: "
    e.pessoas_esperando
  end

  def teste4
    puts "*************************** TESTE 4 ***************************"
    puts "TESTE: desloca um andar por vez"
    e = Elevador.new
    pessoa = Pessoa.new(1, "Leli", 60)
    e.chamar(pessoa, 5, 10)
    3.times { e.movimentar }
    puts "\nAndar atual = #{e.andar}"
  end

  def teste5
    puts "*************************** TESTE 5 ***************************"
    puts "TESTE: Ativar e liberar emergencia"
    e = Elevador.new
    pessoa = Pessoa.new(1, "Lelinha", 60)
    pessoa2 = Pessoa.new(2, "Xeninha", 12)
    
    e.chamar(pessoa, 0, 5)
    e.chamar(pessoa2, 1, 5)

    3.times { e.movimentar }
    e.emergencia
    e.movimentar
    e.liberar_emergencia
    2.times { e.movimentar }
  end

  def teste6
    puts "*************************** TESTE 6 ***************************"
    puts "TESTE: Modo manutenção"
    e = Elevador.new
    e.distancia_manutencao = 100
    e.manutencao_pendente = true
    e.estado
  end

  def teste7
    puts "*************************** TESTE 7 ***************************"
    puts "TESTE: Caso obrigatório 1"
    puts "Elevador subindo no andar 3, com 6 passageiros e 430 kg."
    puts "No andar 5 aguardam pessoas de 90 kg, 45 kg e 70 kg."
    puts "No andar 7 há uma pessoa querendo descer."

    e = Elevador.new
    e.direcao = :subindo
    e.passageiros = [
      Pessoa.new(1, "p1", 72),
      Pessoa.new(2, "p2", 72),
      Pessoa.new(3, "p3", 72),
      Pessoa.new(4, "p4", 72),
      Pessoa.new(5, "p5", 72),
      Pessoa.new(6, "p6", 70)
    ]

    e.passageiros[0].destino = 8
    e.passageiros[1].destino = 8
    e.passageiros[2].destino = 12
    e.passageiros[3].destino = 15
    e.passageiros[4].destino = 15
    e.passageiros[5].destino = 15

    p1 = Pessoa.new(7, "Pessoa90", 90)
    p1.origem = 5
    p1.destino = 10

    p2 = Pessoa.new(8, "Pessoa50", 50)
    p2.origem = 5
    p2.destino = 10

    p3 = Pessoa.new(9, "Pessoa70", 70)
    p3.origem = 5
    p3.destino = 10

    p4 = Pessoa.new(10, "Descendo", 60)
    p4.origem = 7
    p4.destino = 2

    p5 = Pessoa.new(11, "Subindo1", 50)
    p4.origem

    e.lista_espera[5] << p1
    e.lista_espera[5] << p2
    e.lista_espera[5] << p3
    e.lista_espera[7] << p4

    e.estado
  end

  def teste8
    puts "*************************** TESTE 8 ***************************"
    puts "TESTE: Caso obrigatório 2"
    puts "Elevador no andar 14 subindo, destinos internos 17 e 20."
    puts "Andar 16: chamada para descer."
    puts "Andar 18: chamada para subir."
    puts "Andar 9: chamada para subir."

    e = Elevador.new
    e.andar = 14
    e.direcao = :subindo

    p1 = Pessoa.new(90, "destino 17", 70)
    p1.origem = 10
    p1.destino = 17

    p2 = Pessoa.new(91, "destino 20", 70)
    p2.origem = 11
    p2.destino = 20

    p3 = Pessoa.new(92, "descer 16", 60)
    p3.origem = 16
    p3.destino = 10

    p4 = Pessoa.new(93, "subir 18", 60)
    p4.origem = 18
    p4.destino = 20

    p5 = Pessoa.new(94, "subir 9", 60)
    p5.origem = 9
    p5.destino = 12

    e.passageiros << p1
    e.passageiros << p2
    e.passageiros << p3
    e.passageiros << p4
    e.passageiros << p5

    e.estado
  end

  while true
    puts "\n***************************************************************"
    puts "Qual teste executar? "
    puts "   0 - Voltar ao menu inicial"
    puts "   1 - Impedir chamada para o andar errado"
    puts "   2 - Validar peso máximo"
    puts "   3 - Validar quantidade máxima. Pessoa que não consegue entrar continua esperando"
    puts "   4 - Desloca um andar por vez"
    puts "   5 - Ativar e liberar emergencia"
    puts "   6 - Modo manutenção"
    puts "   7 - Caso obrigatório 1"
    puts "   8 - Caso obrigatório 2 \n"

    opcao = gets.chomp.to_i

    if opcao == 0
      break
    elsif opcao == 1
      teste1
    elsif opcao == 2
      teste2
    elsif opcao == 3
      teste3
    elsif opcao == 4
      teste4
    elsif opcao == 5
      teste5
    elsif opcao == 6
      teste6
    elsif opcao == 7
      teste7
    elsif opcao == 8
      teste8
    end
  end
end


MAX_PESO = 600
MAX_PESSOA = 8
MIN_ANDAR = 0
MAX_ANDAR = 20
LIMITE_MANUTENCAO = 100

class Pessoa
  attr_accessor :id, :nome, :peso, :origem, :destino

  def initialize(id, nome, peso)
    @id = id
    @nome = nome
    @peso = peso
  end

  def subindo?
    @origem < @destino
  end

  def descendo?
    @origem > @destino
  end

end

class Elevador 
  attr_accessor :andar, :porta_aberta, :passageiros, :direcao
  attr_accessor :manutencao_pendente
  attr_accessor :lista_espera
  attr_accessor :distancia_total, :distancia_manutencao, :viagens
  attr_accessor :paradas_viagem
  attr_accessor :parou_aqui

  def initialize
    @andar = 0
    @porta_aberta = false
    @passageiros = []
    @direcao = :parado
    @lista_espera = Array.new(21) { [] }
    @emergencia = false
    @manutencao_pendente = false
    @distancia_total = 0
    @distancia_manutencao = 0
    @viagens = 0
    @paradas_viagem = 0
    @parou_aqui = false
  end

  def qtd_pessoas
    @passageiros.size
  end

  def peso_atual
    total = 0
    @passageiros.each do |p|
      total += p.peso
    end
    return total
  end

  def capacidade_restante
    MAX_PESO - peso_atual
  end

  def parado?
    @direcao == :parado
  end

  def subindo?
    @direcao == :subindo
  end

  def descendo?
    @direcao == :descendo
  end

  def lista_espera_vazia?
    vazio = true

    @lista_espera.each do |a|
      if a.size > 0
        vazio = false
        break
      end
    end

      if @passageiros.size > 0
        vazio = false
      end

    return vazio
  end

  def pode_atender?
    !@emergencia && !@manutencao_pendente
  end

  def muda_direcao(nova)
    if nova != @direcao
      if @direcao != :parado && @paradas_viagem > 0
        @viagens += 1
        @paradas_viagem = 0
      end
      @direcao = nova
    end
  end

  def passageiros_e_destinos
    if @passageiros.size == 0
      puts "(nenhum)"
      return
    end

    @passageiros.each do |p|
      puts "#{p.nome} -> andar #{p.destino}"
    end
  end

  def pessoas_esperando
    achou = false

    @lista_espera.each_with_index do |pessoas, andar|
      pessoas.each do |p|
        puts "Andar #{andar}: #{p.nome} (está em #{p.origem} e quer ir para #{p.destino})"
        achou = true
      end
    end

    if !achou
      puts "(ninguém)"
    end
  end

  def tem_destino_em?(andar)
    @passageiros.each do |p|
      return true if p.destino == andar
    end
    return false
  end

  def tem_espera_em?(andar, sentido)
    return false if !pode_atender?

    @lista_espera[andar].each do |p|
      return true if sentido == :subindo && p.subindo?
      return true if sentido == :descendo && p.descendo?
    end

    return false
  end

  def proximas_paradas
    if @emergencia
      saida = @andar > MIN_ANDAR ? "Andar 0 (emergência)" : "(nenhuma)"
      puts saida
      return
    end

    if @manutencao_pendente && qtd_pessoas == 0
      saida = @andar > MIN_ANDAR ? "Andar 0 (manutenção)" : "(nenhuma - aguardando manutenção)"
      puts saida
      return
    end

    primeira = []
    segunda = []

    if descendo?
      passo = -1
      limite = MIN_ANDAR
      sentido = :descendo
    else
      passo = 1
      limite = MAX_ANDAR
      sentido = :subindo
    end

    # paradas na direçao atuall
    i = @andar + passo

    while i >= MIN_ANDAR && i <= MAX_ANDAR
      if tem_destino_em?(i) 
        primeira << i
      elsif tem_espera_em?(i, sentido)
        primeira << i
      end

      i += passo
    end

    # paradas na volta
    i = limite

    while i >= MIN_ANDAR && i <= MAX_ANDAR
      if i != @andar
        if tem_destino_em?(i)
          segunda << i
        elsif tem_espera_em?(i, :subindo) || tem_espera_em?(i, :descendo)
          segunda << i 
        end
      end

      i -= passo
    end

    # remove duplicados
    segunda = segunda - primeira

    if primeira.size == 0 && segunda.size == 0
      puts "(nenhuma)"
    else
      saida1 = primeira.join(", ")
      saida2 = segunda.join(", ")
      puts "#{saida1}, #{saida2}"
    end

  end

  def estado
    puts "\n----------- Estado atual: -----------"
    puts "Andar: #{@andar}"
    puts "Direção: #{@direcao}"
    puts "Porta: #{@porta_aberta ? "aberta" : "fechada"}"
    puts "Emergencia: #{@emergencia ? "sim" : "não"}"
    puts "Manutenção pendente: #{@manutencao_pendente ? "sim" : "não"}"
    puts "Pessoas: #{qtd_pessoas}"
    puts "Peso: #{peso_atual} kg"
    puts "Capacidade restante: #{capacidade_restante} kg e #{MAX_PESSOA-qtd_pessoas} vagas"
    
    puts "\nPassageiros:"
    passageiros_e_destinos
   
    puts "\nEsperando:"
    pessoas_esperando

    puts "\nPróximas paradas:"
    proximas_paradas

    puts "\nDistância total: #{@distancia_total}"
    puts "Distância desde a manutenção: #{@distancia_manutencao}"
    puts "Viagens concluídas: #{@viagens}"
  end

  def pessoa_registrada?(pessoa)
    # dentro do elevador?
    @passageiros.each do |p|
      return true if p.id == pessoa.id
    end

    # esperando em algum andar?
    @lista_espera.each do |pessoas|
      pessoas.each do |p|
        return true if p.id == pessoa.id
      end
    end

    return false
  end

  def chamar(pessoa, origem, destino)
    if origem == destino
      puts "\n=> ERRO: andares de origem e destino não podem ser iguais."
      return false
    elsif origem < MIN_ANDAR || origem > MAX_ANDAR
      puts "\n=> ERRO: andar de origem inválido."
      return false
    elsif destino < MIN_ANDAR || destino > MAX_ANDAR
      puts "\n=> ERRO: andar de destino inválido."
      return false
    elsif pessoa_registrada?(pessoa)
      puts "\n=> ERRO: #{pessoa.nome} já tem uma chamada ativa."
      return false
    elsif pessoa.peso > MAX_PESO
      puts "\n=> ERRO: #{pessoa.nome} pesa mais que o limite do elevador."
      return false
    end

    pessoa.origem = origem
    pessoa.destino = destino
    adicionar_pessoa(pessoa)
    return true
  end

  def adicionar_pessoa(pessoa)
    @lista_espera[pessoa.origem] << pessoa

    if pessoa.origem == @andar
      @parou_aqui = false
    end

    puts "\n=> Chamada de #{pessoa.nome} registrada."
  end

  def abrir_porta
    if @porta_aberta
      puts "\n=> ERRO: a porta já está aberta."
      return false
    end

    puts "\nPorta aberta."
    @porta_aberta = true
    return true
  end

  def fechar_porta
    if !@porta_aberta
      puts "\n=> ERRO: a porta já está fechada."
      return false
    end

    puts "\nPorta fechada."
    @porta_aberta = false
    return true
  end

  def mover
    # movimenta um andar acima ou abaixo, conforme direção atual

    if @porta_aberta
      puts "\n=> ERRO: não pode mover com a porta aberta."
      return false
    end

    if @andar < MIN_ANDAR || @andar > MAX_ANDAR
      puts "\n=> ERRO: andar atual inválido (#{@andar}). Corrija o andar antes de mover."
      return false
    end

    if @manutencao_pendente && @andar == MIN_ANDAR && qtd_pessoas == 0
      puts "\n=> INFO: elevador aguardando manutenção no térreo. Execute realizar_manutencao."
      return false
    end

    if parado?
      puts "\n=> Elevador parado, nada para mover."
      return false
    end

    if subindo?
      if @andar >= MAX_ANDAR
        puts "\n=> ERRO: nada para mover pois já está no último andar."
        return false
      end
    else 
      if @andar <= MIN_ANDAR
        puts "\n=> ERRO: nada para mover pois já está no térreo."
        return false
      end
    end

    if subindo?
      @andar += 1
    else
      @andar -= 1
    end

    @parou_aqui = false

    # Movimenta elevador
    @distancia_total += 1
    @distancia_manutencao += 1

    puts "\n=> Elevador movido. Andar atual é #{@andar}."

    if @distancia_manutencao >= LIMITE_MANUTENCAO && !@manutencao_pendente
      @manutencao_pendente = true
      puts "\n=> INFO: #{LIMITE_MANUTENCAO} andares percorridos. Manutenção pendente"
    end

    return true
  end

  def desembarcar(todos)
    if @emergencia
      todos = true

      @passageiros.each_with_index do |p, i|
        @passageiros[i].destino = MIN_ANDAR
      end
    end 

    ## tira de @passageiros quem tem destino == @andar
    removidos = []
    mantidos = []

    @passageiros.each do |p|
      if p.destino == @andar || todos
        removidos << p
      else 
        mantidos << p
      end
    end

    @passageiros = mantidos

    if removidos.size == 0
      puts "\nNenhum passageiro para desembarcar no andar #{@andar}."
      return 0
    end
    
    puts "\nDesembarque no andar #{@andar} ocorreu com sucesso! \nPassageiros que saíram: "
    removidos.each do |r|
      puts "#{r.nome} (id #{r.id}) saiu"
    end

    return removidos.size
  end

  def pode_entrar(pessoa)
    # verifica se pessoa pode entrar no elevador

    if qtd_pessoas >= MAX_PESSOA
      puts "INFO: Elevador cheio. #{pessoa.id}-#{pessoa.nome} deve aguardar para embarcar."
      return false
    end

    if pessoa.peso > capacidade_restante
      puts "INFO: Peso excedido. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    if @emergencia
      puts "INFO: Emergencia ativa. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    if @manutencao_pendente
      puts "INFO: Manutenção ativa. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    return false if subindo? && !pessoa.subindo?
    return false if descendo? && pessoa.subindo?

    return true
  end

  def embarcar
    ## tira da @lista_espera quem couber e coloca em @passageiros
    mantidos = []
    embarcados = []

    @lista_espera[@andar].each do |p|
      if pode_entrar(p)
        @passageiros << p
        embarcados << p
      else
        mantidos << p
      end
    end

    @lista_espera[@andar] = mantidos

    if embarcados.size == 0
      puts "\nNenhum passageiro para embarcar no andar #{@andar}."
      return 0
    end

    puts "\nEmbarque no andar #{@andar} ocorreu com sucesso! \nPassageiros que embarcaram: "
    embarcados.each do |r|
      puts "#{r.nome} (id #{r.id}) embarcou"
    end

    return embarcados.size
  end

  def tem_pedido_acima?
    @passageiros.each do |p|
      return true if p.destino > @andar
    end

    if !pode_atender?
      return false
    end

    @lista_espera.each_with_index do |pessoas, andar|
      if pessoas.size > 0
        return true if andar > @andar
      end
    end

    return false
  end

  def tem_pedido_abaixo?
    @passageiros.each do |p|
      return true if p.destino < @andar
    end

    if !pode_atender?
      return false
    end

    @lista_espera.each_with_index do |pessoas, andar|
      if pessoas.size > 0
        return true if andar < @andar
      end
    end

    return false
  end

  def espera_aqui?(subir)
    return false if !pode_atender?

    # se alguem nesse andar quer subir (true) ou descer (false)?
    @lista_espera[@andar].each do |p|
      return true if p.subindo? == subir
    end
    return false
  end

  def define_direcao
    # manutenção pendente e vazio: vai para o térreo e fica parado
    if @manutencao_pendente && qtd_pessoas == 0
      if @andar > MIN_ANDAR
        muda_direcao(:descendo)
      else
        muda_direcao(:parado)
      end
      return
    end

    if subindo?
      if tem_pedido_acima? || espera_aqui?(true)
        return
      end

      if tem_pedido_abaixo? || espera_aqui?(false)
        muda_direcao(:descendo)
      else
        muda_direcao(:parado)
      end

    elsif descendo?
      if tem_pedido_abaixo? || espera_aqui?(false)
        return
      end

      if tem_pedido_acima? || espera_aqui?(true)
        muda_direcao(:subindo)
      else
        muda_direcao(:parado)
      end

    else 
      # está parado e escolhe priorizando o andar atual
      if espera_aqui?(true)
        muda_direcao(:subindo)
      elsif espera_aqui?(false)
        muda_direcao(:descendo)
      elsif tem_pedido_acima?
        muda_direcao(:subindo)
      elsif tem_pedido_abaixo?
        muda_direcao(:descendo)
      end
    end
  end

  def deve_parar_aqui?
    return false if @parou_aqui

    @passageiros.each do |p|
      return true if p.destino == @andar
    end

    # se tiver em emergencia ou manutencao não deve parar
    return false if !pode_atender?

    @lista_espera[@andar].each do |p|
      return true if parado?
      return true if subindo? && p.subindo?
      return true if descendo? && p.descendo?
    end

    # mudar direcao se nada mais adiante e há passageiros
    if @lista_espera[@andar].size > 0
      return true if subindo? && !tem_pedido_acima?
      return true if descendo? && !tem_pedido_abaixo?
    end

    return false
  end

  def processar_parada
    @parou_aqui = true

    abrir_porta

    atendeu = false
    atd_saiu = desembarcar(false)

    if atd_saiu > 0 
      @paradas_viagem += 1
      atendeu = true
    end

    define_direcao

    qtd_entrou = embarcar

    if qtd_entrou > 0 && !atendeu
      @paradas_viagem += 1
    end

    define_direcao
    fechar_porta
  end

  def emergencia
    if @emergencia
      puts "\n=> INFO: a emergência já está ativa."
      return false
    end

    @emergencia = true
    puts "\n=> EMERGÊNCIA ATIVADA! Nenhum passageiro novo será aceito."

    if @andar == 0
      chegar_emergencia
    else
      if @porta_aberta
        fechar_porta
      end
      muda_direcao(:descendo)
    end

    return true
  end

  def liberar_emergencia
    if !@emergencia
      puts "\n=> ERRO: não existe emergência ativa."
      return false
    end

    @emergencia = false
    @parou_aqui = false
    
    if @porta_aberta
      fechar_porta
    end

    muda_direcao(:parado)
    
    puts "\n=> Emergência liberada. Chamadas pendentes voltam a ser atendidas."
    return true
  end

  def chegar_emergencia
    # chegou no térreo durante a emergência: todos saem e fica parado com a porta aberta
    muda_direcao(:parado)

    abrir_porta if !@porta_aberta

    desembarcar(true)

    puts "\n=> Emergência: elevador parado no térreo com a porta aberta."
  end

  def movimentar_emergencia
    if @andar < MIN_ANDAR
      puts "\n=> ERRO: elevador abaixo do térreo. Movimentação bloqueada até corrigir o andar."
      muda_direcao(:parado)
      return false
    end

    while @andar > 0
      @andar -= 1 
    end

    if @andar == 0
      if @porta_aberta && parado? && qtd_pessoas == 0
        puts "\n=> INFO: emergência ativa. Aguardando liberação."
      else
        chegar_emergencia
      end
      return false
    end

    muda_direcao(:descendo)
    return mover
  end

  def realizar_manutencao
    if !@manutencao_pendente
      puts "\n=> ERRO: não existe manutenção pendente."
      return false
    end

    if @emergencia
      puts "\n=> ERRO: libere a emergência antes da manutenção."
      return false
    end

    if @andar != 0 || qtd_pessoas > 0
      puts "\n=> ERRO: manutenção só pode ser feita no térreo e com o elevador vazio."
      return false
    end

    @distancia_manutencao = 0
    @manutencao_pendente = false
    @parou_aqui = false
    
    puts "\n=> Manutenção realizada com sucesso."
    return true
  end

  def movimentar
    if @emergencia
      puts "\nMovimentando emergencia..."
      return movimentar_emergencia
    end

    if @andar < MIN_ANDAR || @andar > MAX_ANDAR
      puts "\n=> ERRO: andar atual inválido (#{@andar}). Corrija o andar antes de mover."
      muda_direcao(:parado)
      return false
    end

    define_direcao

    if deve_parar_aqui?
      processar_parada
    end

    moveu = false

    if !parado?
      if !mover
        muda_direcao(:parado)
        return false
      end

      moveu = true

      # chegou no andar: já processa embarque/desembarque
      define_direcao

      if deve_parar_aqui?
        processar_parada
      end
    end

    if @manutencao_pendente && @andar == MIN_ANDAR && qtd_pessoas == 0
      puts "\n=> INFO: elevador aguardando manutenção no térreo. Execute realizar_manutencao."
    end

    return moveu
  end

end

## interação com usuário 
elevador = Elevador.new
pessoas = []
proximo_id = 1

while true
  puts "\n--------------------------------------------------------------"
  if pessoas.size > 0
    puts "\nPessoas:"
    pessoas.each do |p|
      puts "  id #{p.id}: #{p.nome} (#{p.peso} kg)"
    end
  end

  puts "\n0 - Sair"
  puts "1 - Criar pessoa"
  puts "2 - Fazer chamada"
  puts "3 - Ver estado do elevador"
  puts "4 - Movimentar elevador (um passo)"
  puts "5 - Movimentar elevador (até parar)"
  puts "6 - Emergência"
  puts "7 - Liberar emergência"
  puts "8 - Realizar manutenção"
  puts "9 - Executar testes"

  print "Ação: "
  opcao = gets.to_i

  if opcao == 1
    print "Nome: "
    nome = gets.to_s.strip

    print "Peso (kg): "
    peso = gets.to_f

    if nome == "" || peso <= 0 || peso > MAX_PESO
      puts "\n=> ERRO: nome vazio ou peso inválido (1 a #{MAX_PESO})."
    else
      pessoa = Pessoa.new(proximo_id, nome, peso)
      pessoas << pessoa
      proximo_id += 1
      puts "\n=> Pessoa criada: id #{pessoa.id}, #{pessoa.nome}, #{pessoa.peso} kg"
    end

  elsif opcao == 2

    if pessoas.size == 0
      puts "\n=> ERRO: crie uma pessoa antes de fazer uma chamada."
      next
    end

    pessoa = nil

    while true
      print "\nId da pessoa: "
      id = gets.to_i

      pessoas.each do |p|
        pessoa = p if p.id == id
      end

      if pessoa.nil?
        puts "\n=> ERRO: pessoa não encontrada. Tente novamente."
      else
        break
      end
    end

    print "Andar de origem: "
    origem = gets.to_i
    print "Andar de destino: "
    destino = gets.to_i

    elevador.chamar(pessoa, origem, destino)

  elsif opcao == 3
    elevador.estado

  elsif opcao == 4
    if elevador.lista_espera_vazia? && elevador.parado? && !elevador.manutencao_pendente
      puts "\n=> INFO: Nada para movimentar - sem pessoas para embarque ou desembarque."
      next
    end

    elevador.movimentar
    puts "\n=> Elevador no andar #{elevador.andar}, direção #{elevador.direcao}."

  elsif opcao == 5
    if elevador.lista_espera_vazia? && elevador.parado? && !elevador.manutencao_pendente
      puts "\n=> INFO: Nada para movimentar - sem pessoas para embarque ou desembarque."
      next
    end

    elevador.movimentar
    elevador.estado

    while !elevador.parado?
      elevador.movimentar
    end

    puts "\n=> Elevador parado no andar #{elevador.andar}."

  elsif opcao == 6
    elevador.emergencia

  elsif opcao == 7
    elevador.liberar_emergencia

  elsif opcao == 8
    elevador.realizar_manutencao

  elsif opcao == 0
    puts "\nEncerrando..."
    break

  elsif opcao == 9
    executar_testes

  else
    puts "\n=> Opção inválida."
  end
end
