
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


MAX_PESO = 600
MAX_PESSOA = 8
MIN_ANDAR = 0
MAX_ANDAR = 20

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
  attr_accessor :emergencia, :manutencao_pendente
  attr_accessor :lista_espera
  attr_accessor :distancia_total, :distancia_manutencao, :viagens

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
  end

  def qtd_pessoas
    @passageiros.size
  end

  def peso_atual
    total = 0
    @passageiros.each do |p|
      total += p.peso
    end
    total
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

  def passageiros_e_destinos
    if @passageiros.empty?
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
        puts "Andar #{andar}: #{p.nome} (quer ir para #{p.destino})"
        achou = true
      end
    end

    if !achou
      puts "(ninguém)"
    end
  end

  def proximas_paradas
    @passageiros.each do |p|
      # todo puts 
    end
  end

  def estado
    puts "\n-------- Estado atual: --------"
    puts "Andar atual: #{@andar}"
    puts "Direção atual: #{@direcao}"
    puts "Porta: #{@porta_aberta ? "aberta" : "fechada"}"
    puts "Emergencia ativa: #{@emergencia ? "sim" : "não"}"
    puts "Manutenção pendente: #{@manutencao_pendente ? "sim" : "não"}"
    puts "Qtd de pessoas no elevador: #{qtd_pessoas}"
    puts "Peso atual: #{peso_atual} kg"
    puts "Capacidade restante: #{capacidade_restante} kg"
    
    puts "\nPassageiros e seus destinos: "
    passageiros_e_destinos

    puts "\nPessoas esperando: "
    pessoas_esperando

    puts "\nPróximas paradas previstas: "
    proximas_paradas

    puts "\nDistância total percorrida: #{@distancia_total}"
    puts "Distância percorrida desde a última manutenção: #{@distancia_manutencao}"
    puts "Qtd de viagens concluídas: #{@viagens}"
    puts "\n--------------------------------"
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
    end

    pessoa.origem = origem
    pessoa.destino = destino
    adicionar_pessoa(pessoa)
    return true
  end

  def adicionar_pessoa(pessoa)
    @lista_espera[pessoa.origem] << pessoa
    puts "\n=> Pessoa #{pessoa.nome} adicionada com sucesso."
  end

  def abrir_porta
    @porta_aberta = true
  end

  def fechar_porta
    @porta_aberta = false
  end
  
  def mover
    if @porta_aberta
      puts "\n=> ERRO: não pode mover com a porta aberta."
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
      @andar += 1
    else 
      if @andar <= MIN_ANDAR
        puts "\n=> ERRO: nada para mover pois já está no térreo."
        return false
      end
      @andar -= 1
    end

    @distancia_total += 1
    @distancia_manutencao += 1

    puts "\n=> Elevador movido com sucesso. Andar atual é #{@andar}"
    return true
  end

  def desembarcar
    ## tira de @passageiros quem tem destino == @andar
    removidos = []
    mantidos = []

    @passageiros.each do |p|
      if p.destino == @andar
        removidos << p
      else 
        mantidos << p
      end
    end

    @passageiros = mantidos

    if removidos.empty?
      puts "\nNenhum passageiro para desembarcar no andar #{@andar}."
      return
    end
    
    puts "\nDesembarque no andar #{@andar} ocorreu com sucesso! \nPassageiros que saíram: "
    removidos.each do |r|
      puts "#{r.nome} (id #{r.id}) saiu no andar #{@andar}"
    end

  end

  def pode_entrar(pessoa)
    # verifica se pessoa pode entrar no elevador
    return false if qtd_pessoas >= MAX_PESSOA
    return false if pessoa.peso > capacidade_restante
    return false if subindo? && !pessoa.subindo?
    return false if descendo? && pessoa.subindo?
    return false if @emergencia
    return false if @manutencao_pendente
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

    puts "\nEmbarque no andar #{@andar} ocorreu com sucesso! \nPassageiros que embarcaram: "
    embarcados.each do |r|
      puts "#{r.nome} (id #{r.id}) embarcou no andar #{@andar}"
    end
  end

end

# Testes
e = Elevador.new
e = Elevador.new
p1 = Pessoa.new(1, "leli", 50)

e.chamar(p1, 0, 1)   # ok
e.chamar(p1, 0, 3)   # deve dar erro de duplicidade
e.chamar(Pessoa.new(2, "xena", 80), 5, 5)  # erro: iguais
e.estado             # leli esperando no andar 0

e.direcao = :subindo
e.mover
e.mover
e.mover
e.estado

e.abrir_porta
e.mover
e.fechar_porta

e.direcao = :descendo
e.mover
e.mover
e.mover
e.mover

e.direcao = :subindo
e.mover
e.mover

p2 = Pessoa.new(2, "marli", 60)
p3 = Pessoa.new(3, "santo", 70)

p2.origem = 0
p2.destino = 3
p3.origem = 0
p3.destino = 5

e.passageiros << p2
e.passageiros << p3

e.estado 

e.andar = 3
e.desembarcar  
e.estado     

e1 = Elevador.new
e1.direcao = :subindo
e1.andar = 5
e1.estado 

x = Pessoa.new(1, "x", 90)
e1.chamar(x, 5, 10)
y = Pessoa.new(2, "y", 45)
e1.chamar(y, 5, 12)
z = Pessoa.new(3, "z", 70)
e1.chamar(z, 5, 2) 

e1.embarcar
e1.estado 

