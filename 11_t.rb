
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
    @paradas_viagem = 0 # paradas atendidas na viagem atual
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

  # só atende chamadas externas se não estiver em emergência nem manutenção pendente
  def pode_atender?
    !@emergencia && !@manutencao_pendente
  end

  # muda a direção e conta a viagem quando ela termina
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

  # sentido pode ser :subindo, :descendo ou :qualquer
  def tem_espera_em?(andar, sentido)
    return false if !pode_atender?

    @lista_espera[andar].each do |p|
      return true if sentido == :qualquer
      return true if sentido == :subindo && p.subindo?
      return true if sentido == :descendo && p.descendo?
    end
    return false
  end

  def proximas_paradas
    if @andar < MIN_ANDAR || @andar > MAX_ANDAR
      puts "(andar atual inválido)"
      return
    end

    if @emergencia
      puts(@andar > MIN_ANDAR ? "Andar 0 (térreo - emergência)" : "(nenhuma)")
      return
    end

    if @manutencao_pendente && qtd_pessoas == 0
      puts(@andar > MIN_ANDAR ? "Andar 0 (térreo - manutenção)" : "(nenhuma - aguardando manutenção)")
      return
    end

    incluido = Array.new(MAX_ANDAR + 1, false)
    primeira = []
    segunda = []

    if descendo?
      passo = -1
      limite = MIN_ANDAR
      inicio = MAX_ANDAR
      sentido = :descendo
    else
      passo = 1
      limite = MAX_ANDAR
      inicio = MIN_ANDAR
      sentido = :subindo
    end

    # 1) paradas na direção atual
    (@andar + passo).step(limite, passo) do |f|
      if tem_destino_em?(f) || tem_espera_em?(f, sentido)
        primeira << f
        incluido[f] = true
      end
    end

    # 2) paradas na volta (do extremo até o outro lado)
    limite.step(inicio, -passo) do |f|
      if !incluido[f] && f != @andar
        if tem_destino_em?(f) || tem_espera_em?(f, :qualquer)
          segunda << f
        end
      end
    end

    if primeira.size == 0
      puts "Direção atual (#{sentido}): (nenhuma)"
    else
      puts "Direção atual (#{sentido}): #{primeira.join(", ")}"
    end

    if segunda.size == 0
      puts "Na volta: (nenhuma)"
    else
      puts "Na volta: #{segunda.join(", ")}"
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
    puts "Capacidade restante: #{capacidade_restante} kg e #{MAX_PESSOA - qtd_pessoas} vaga(s)"
    
    puts "\nPassageiros e seus destinos: "
    passageiros_e_destinos

    puts "\nPessoas esperando: "
    pessoas_esperando

    puts "\nPróximas paradas previstas: "
    proximas_paradas

    puts "\nDistância total percorrida: #{@distancia_total}"
    puts "Distância percorrida desde a última manutenção: #{@distancia_manutencao}"
    puts "Qtd de viagens concluídas: #{@viagens}"
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
    elsif pessoa.peso > MAX_PESO
      puts "\n=> ERRO: #{pessoa.nome} pesa mais que o limite do elevador."
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

  # usado só para montar os casos de teste
  def definir_estado(andar, direcao, passageiros)
    @andar = andar
    @direcao = direcao
    @passageiros = passageiros
    @paradas_viagem = 0
  end

  # corrige o andar quando o elevador está em um andar inválido
  def corrigir_andar(novo_andar)
    if novo_andar < MIN_ANDAR || novo_andar > MAX_ANDAR
      puts "\n=> ERRO: andar inválido."
      return false
    end

    @andar = novo_andar
    puts "\n=> Andar corrigido para #{@andar}."
    return true
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


  ####################################

  def emergencia
    if @emergencia
      puts "\n=> INFO: a emergência já está ativa."
      return false
    end

    @emergencia = true
    puts "\n=> EMERGÊNCIA ATIVADA! Nenhum passageiro novo será aceito."

    if @andar < MIN_ANDAR
      puts "\n=> ERRO: elevador abaixo do térreo. Movimentação bloqueada até corrigir o andar."
      muda_direcao(:parado)
    elsif @andar == MIN_ANDAR
      chegar_emergencia
    else
      fechar_porta if @porta_aberta
      muda_direcao(:descendo)
    end

    return true
  end

  def liberar_emergencia
    if !@emergencia
      puts "\n=> ERRO: não existe emergência ativa."
      return false
    end

    if @andar < MIN_ANDAR
      puts "\n=> ERRO: corrija o andar do elevador antes de liberar a emergência."
      return false
    end

    @emergencia = false
    fechar_porta if @porta_aberta
    muda_direcao(:parado)
    puts "\n=> Emergência liberada. Chamadas pendentes voltam a ser atendidas."
    return true
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

    if @andar != MIN_ANDAR || qtd_pessoas > 0
      puts "\n=> ERRO: manutenção só pode ser feita no térreo e com o elevador vazio."
      return false
    end

    @distancia_manutencao = 0
    @manutencao_pendente = false
    puts "\n=> Manutenção realizada com sucesso."
    return true
  end

  def chegar_emergencia
    # chegou no térreo durante a emergência: todos saem e fica parado com a porta aberta
    muda_direcao(:parado)
    abrir_porta if !@porta_aberta
    desembarcar(true)
    puts "\n=> Emergência: elevador parado no térreo com a porta aberta."
  end

  ####################################


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

    # Movimenta elevador
    @distancia_total += 1
    @distancia_manutencao += 1

    puts "\n=> Elevador movido com sucesso. Andar atual é #{@andar}."

    if @distancia_manutencao >= LIMITE_MANUTENCAO && !@manutencao_pendente
      @manutencao_pendente = true
      puts "\n=> INFO: #{LIMITE_MANUTENCAO} andares percorridos. Manutenção pendente!"
    end

    return true
  end

  # retorna a quantidade de pessoas que saíram
  # todos = true: todos saem (usado na emergência, no térreo)
  def desembarcar(todos = false)
    ## tira de @passageiros quem tem destino == @andar
    removidos = []
    mantidos = []

    @passageiros.each do |p|
      if todos || p.destino == @andar
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
      puts "#{r.nome} (id #{r.id}) saiu no andar #{@andar}"
    end

    return removidos.size
  end

  def pode_entrar(pessoa)
    # verifica se pessoa pode entrar no elevador

    if qtd_pessoas >= MAX_PESSOA
      puts "INFO: Quantidade de passageiros não pode ser excedida. #{pessoa.id}-#{pessoa.nome} deve aguardar para embarcar."
      return false
    end

    if pessoa.peso > capacidade_restante
      puts "INFO: Peso não pode ser excedido. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    if @emergencia
      puts "INFO: Emergencia está ativa. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    if @manutencao_pendente
      puts "INFO: Manutenção está ativa. '#{pessoa.nome}' deve aguardar para embarcar."
      return false
    end

    return false if subindo? && !pessoa.subindo?
    return false if descendo? && pessoa.subindo?

    return true
  end

  # retorna a quantidade de pessoas que entraram
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
      puts "#{r.nome} (id #{r.id}) embarcou no andar #{@andar}"
    end

    return embarcados.size
  end

  def tem_pedido_acima?
    @passageiros.each do |p|
      return true if p.destino > @andar
    end

    if pode_atender?
      @lista_espera.each_with_index do |pessoas, andar|
        if pessoas.size > 0
          return true if andar > @andar
        end
      end
    end

    return false
  end

  def tem_pedido_abaixo?
    @passageiros.each do |p|
      return true if p.destino < @andar
    end

    if pode_atender?
      @lista_espera.each_with_index do |pessoas, andar|
        if pessoas.size > 0
          return true if andar < @andar
        end
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
    @passageiros.each do |p|
      return true if p.destino == @andar
    end

    # emergência ou manutenção: não para para buscar ninguém
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
    abrir_porta

    atendeu = false
    saiu = desembarcar
    if saiu > 0
      @paradas_viagem += 1
      atendeu = true
    end

    # inverte a direção (se precisar) antes de embarcar
    define_direcao

    entrou = embarcar
    if entrou > 0 && !atendeu
      @paradas_viagem += 1
    end

    define_direcao
    fechar_porta
  end

  def movimentar_emergencia
    if @andar < MIN_ANDAR
      puts "\n=> ERRO: elevador abaixo do térreo. Movimentação bloqueada até corrigir o andar."
      muda_direcao(:parado)
      return false
    end

    if @andar == MIN_ANDAR
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

  # retorna true se o elevador se moveu um andar
  def movimentar
    if @emergencia
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

    if !parado?
      if mover
        return true
      end
      muda_direcao(:parado) # não conseguiu mover: evita ficar preso
      return false
    end

    if @manutencao_pendente && @andar == MIN_ANDAR && qtd_pessoas == 0
      puts "\n=> INFO: elevador aguardando manutenção no térreo. Execute realizar_manutencao."
    end

    return false
  end

end

# Casos de teste

def nova_pessoa(id, nome, peso, origem = nil, destino = nil)
  pessoa = Pessoa.new(id, nome, peso)
  pessoa.origem = origem
  pessoa.destino = destino
  return pessoa
end

def caso_teste_1
  e = Elevador.new

  # 6 pessoas dentro, 430 kg: id, nome, peso, origem, destino
  dentro = []
  dentro << nova_pessoa(101, "P1", 70, 1, 8)
  dentro << nova_pessoa(102, "P2", 70, 1, 8)
  dentro << nova_pessoa(103, "P3", 70, 1, 12)
  dentro << nova_pessoa(104, "P4", 70, 1, 15)
  dentro << nova_pessoa(105, "P5", 75, 1, 15)
  dentro << nova_pessoa(106, "P6", 75, 1, 15)
  e.definir_estado(3, :subindo, dentro)

  e.chamar(nova_pessoa(107, "A90", 90), 5, 9)
  e.chamar(nova_pessoa(108, "B45", 45), 5, 10)
  e.chamar(nova_pessoa(109, "C70", 70), 5, 11)
  e.chamar(nova_pessoa(110, "D60", 60), 7, 2)
  e.chamar(nova_pessoa(111, "E60", 60), 10, 18)
  e.chamar(nova_pessoa(112, "F60", 60), 10, 18)

  return e
end

def caso_teste_2
  e = Elevador.new

  dentro = []
  dentro << nova_pessoa(201, "X1", 70, 10, 17)
  dentro << nova_pessoa(202, "X2", 70, 10, 20)
  e.definir_estado(14, :subindo, dentro)

  e.chamar(nova_pessoa(203, "Y1", 70), 16, 10)
  e.chamar(nova_pessoa(204, "Y2", 70), 18, 20)
  e.chamar(nova_pessoa(205, "Y3", 70), 9, 12)

  return e
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

  puts "\n1 - Criar pessoa"
  puts "2 - Fazer chamada"
  puts "3 - Ver estado do elevador"
  puts "4 - Movimentar elevador (um passo)"
  puts "5 - Movimentar elevador (até parar)"
  puts "6 - Emergência"
  puts "7 - Liberar emergência"
  puts "8 - Realizar manutenção"
  puts "9 - Carregar caso de teste 1"
  puts "10 - Carregar caso de teste 2"
  puts "11 - Sair"
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
    elevador.movimentar
    puts "\n=> Elevador no andar #{elevador.andar}, direção #{elevador.direcao}."

  elsif opcao == 5
    passos = 0
    elevador.movimentar
    while !elevador.parado? && passos < 500
      break if !elevador.movimentar
      passos += 1
    end

    puts "\n=> Elevador parado no andar #{elevador.andar}."

  elsif opcao == 6
    elevador.emergencia

  elsif opcao == 7
    elevador.liberar_emergencia

  elsif opcao == 8
    elevador.realizar_manutencao

  elsif opcao == 9
    elevador = caso_teste_1
    puts "\n=> Caso de teste 1 carregado (elevador no andar 3 subindo)."

  elsif opcao == 10
    elevador = caso_teste_2
    puts "\n=> Caso de teste 2 carregado (elevador no andar 14 subindo)."

  elsif opcao == 11
    puts "\nEncerrando..."
    break

  else
    puts "\n=> Opção inválida."
  end
end
