
=begin
Tarefa: imprimir texto conforme música do elefante.

Exemplo:
1 elefante incomoda muita gente
2 elefantes incomodam muito mais
3 elefantes incomodam muita gente
4 elefantes incomodam incomodam muito mais
5 elefantes incomodam muita gente
6 elefantes incomodam incomodam incomodam muito mais
7 elefantes incomodam muita gente
8 elefantes incomodam incomodam incomodam incomodam muito mais
[...]
=end

# Métodos úteis: gets.chomp, to_i, if, while

texto = ""
i = 1

puts "Quantia de elefantes: "
num_elefante = gets.chomp.to_i

if num_elefante <= 0 
    puts "Número de elefantes deve ser maior que zero."
end

while i <= num_elefante
    if i == 1
        texto = "#{i} elefante incomoda muita gente"
    else 
        if i % 2 == 0 
            aux = "incomodam " * (i / 2)
            texto = "#{i} elefantes #{aux}muito mais"
        else
            texto = "#{i} elefantes incomodam muita gente"
        end
    end

    puts texto
    i += 1
end
