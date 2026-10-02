
# Isso é um comentario de uma linha

=begin
Isso é um comentario de multiplas linhas 
=end

puts "Digite seu nome: " 
nome = gets.chomp # sempre retorna string

puts "oi #{nome}" # concatenar

puts "Idade: "
idade = gets.chomp

puts "Você tem #{idade} anos"

idade_int = idade.to_i # to_i faz parse pra inteiro

puts idade
puts idade_int

if idade_int > 18
    puts "maior de idade"
else
    puts "menor de idade"
end

data_hora = Time.now
puts "#{data_hora.day}/#{data_hora.month}/#{data_hora.year}"
puts "#{data_hora.hour}:#{data_hora.min}:#{data_hora.sec}"

potencia = 2 ** 3
puts potencia

divisao_int = 7 / 2
divisao_float = 7.0 / 2
puts "divisao_int = #{divisao_int} | divisao_float = #{divisao_float}"
