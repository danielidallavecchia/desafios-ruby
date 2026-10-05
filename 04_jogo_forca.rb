
# Jogo da forca:
# - indicar palavras aleatorias e a cada entrada escolher uma letra
# - exibir underlines e ir preenchendo as letras
# - se acertar a letra, substitui o(s) underline(s)
# - se errar, boneco ganha uma parte nova
# - se acertar toda a palavra, vence o jogo
# - se o boneco ficar completo, perde o jogo
# - se chutar a palavra completa: se acertar, preenche todas as letras e ganha a partida; se errar, perde o jogo

# Conceitos importantes: variável global com $, operador =~ pra regex
# Métodos úteis: upcase, downcase, rand, push, join, include, tr, unless

$palavras = [
  "tapete", 
  "espelho", 
  "oceano", 
  "tatuagem", 
  "travesseiro", 
  "mamute", 
  "sobrevivente", 
  "serelepe",
  "ventilador",
  "desobediente",
  "limonada",
  "umbigo",
  "chuveiro",
  "palavra",
  "helicóptero",
  "milionário",
  "crepúsculo",
  "manjericão",
  "xícara",
  "coração"
]

$boneco = [
  "\n  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========",
  "\n  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========",
  "\n  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========",
  "\n  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========",
  "\n  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========",
  "\n  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========",
  "\n  +---+\n  |   |\n  X   |\n /|\\  |\n / \\  |\n      |\n========="
]

def validar_letra(l)
  if l == "" || l.size != 1
    puts "ERRO: digite uma única letra. Tente novamente! \n"
    return false
  end
  
  if "0123456789".include?(l)
    puts "ERRO: números não são permitidos. Tente novamente! \n"
    return false
  end

  if $letras_tentadas.include?(l.upcase)
    puts "ERRO: letra já foi. Tente outra! \n"
    return false
  end

  tem_caracter = l =~ /[^a-zA-Z]/ # ^ nega
  if tem_caracter 
    puts "ERRO: informe apenas letras. Tente novamente! \n"
    return false
  end

  return true 
end

def validar_palavra(l)
  if "0123456789".include?(l)
    puts "\nERRO: números não são permitidos. Tente novamente! \n"
    return false
  end

  tem_caracter = l =~ /[^a-zA-Z]/ # ^ nega
  if tem_caracter 
    puts "\nERRO: informe apenas letras. Tente novamente! \n"
    return false
  end

  return true
end

def remover_acentos(l)
  com_acento = "áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ"
  sem_acento = "aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC"
  return l.tr(com_acento, sem_acento).downcase
end

def maiuscula(l)
  minusculas = "áàâãäéèêëíìîïóòôõöúùûüç"
  maiusculas = "ÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ"
  return l.upcase.tr(minusculas, maiusculas)
end

palavra = $palavras[rand($palavras.length)].downcase
palavra_sem_acentos = remover_acentos(palavra)

texto = "_ " * palavra_sem_acentos.length

indice_boneco = 0
tamanho_palavra = palavra.length
completou = false
$letras_tentadas = []

puts "\n=======================JOGO DA FORCA=======================\n"
puts "\nA palavra contém #{tamanho_palavra} letras!"

puts $boneco[indice_boneco]
puts texto
puts "\n"

while true
  if indice_boneco >= 6
    puts "\n=> Você perdeu :( \n\nA palavra era: #{maiuscula(palavra)} \n\n"
    break
  end

  puts "------------------------------------------"
  puts "\nDigite uma letra ou a palavra inteira: "
  letra = gets.chomp

  ## unless => executa codigo se condição é false
  letra = letra.encode("UTF-8") unless letra.encoding == Encoding::UTF_8 ## força encode pra utf8 se ainda não for

  letra = remover_acentos(letra)

  # Aceita a palavra inteira ou somente uma letra
  if letra.size > 1 ## Se for uma palavra inteira:
    if !validar_palavra(letra)
      next
    end

    texto = ""
    i = 0

    if palavra_sem_acentos != letra
      puts "\n=> Você errou a palavra! \n"
      puts "\nA palavra era: #{maiuscula(palavra)} \n\n"
      break
    end

    while i < palavra.length
      texto += maiuscula(palavra[i]) + " "
      i += 1
    end

    puts "\n=> Você acertou a palavra!"
    puts "\nPalavra: #{texto}"
    
    completou = true
    break

  else ## Se for somente uma letra:

    if !validar_letra(letra)
      next
    end

    if palavra_sem_acentos.include?(letra)
      ## a letra existe
      i = 0
      while i < palavra.length # troca os underline pelas letras certas
        if palavra_sem_acentos[i] == letra
          texto[i*2] = maiuscula(palavra[i])
        end
        i += 1
      end
      
      puts "\nA letra '#{letra.upcase}' existe na palavra!"
    else 
      ## a letra não existe
      indice_boneco += 1
      puts "\nA letra '#{letra.upcase}' não existe na palavra!"
    end

    $letras_tentadas << letra.upcase
    puts "\nLetras que já foram: #{$letras_tentadas.join(", ")}"  

    if !texto.include?("_")
      completou = true
    end
  end

  puts "indice_boneco= #{indice_boneco}"
  puts $boneco[indice_boneco]
  puts texto.upcase

  if completou
    break 
  end
end

if completou
  puts "\n=> Palavra completa :) \n\n"
end
