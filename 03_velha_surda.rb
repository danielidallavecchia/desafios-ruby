
# Tarefa: diálogo com a velha surda. 
# Se falar em letras minuscula, ela não ouve e responde: “QUE? FALA MAIS ALTO!”
# Se falar gritando (tudo em maiúsculas), ela responde: NAO, NAO DESDE {ano aleatorio entre 1930 e 1950}
# Se disser "tchau" (maiscula ou minuscula), ela responde "SIM SIM TCHAU SEJA LA QUEM FOR"
# Ficar em loop até dizer digitar tchau

# Métodos úteis: upcase, downcase, rand(0..n), count

def nao_tem_letras(texto)
  return texto.count("a-z") == 0 && texto.count("A-Z") == 0
end

puts "Fale com a velha surda..."

while true
  input = gets.chomp
  puts "\nVocê: #{input}"

  if (input.downcase == "tchau")
    puts "Velha: SIM SIM, TCHAU SEJA LA QUEM FOR"
    break
  end 

  if (input != input.upcase) || input == "" || nao_tem_letras(input)
    puts "Velha: QUE? FALA MAIS ALTO!"
  else
    ano = rand(1930..1950)
    puts "Velha: NAO, NAO DESDE #{ano}"
  end

  puts "\n"
end
