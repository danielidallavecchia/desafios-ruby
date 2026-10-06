
## Sequencia Fibonacci: sucessão numérica infinita onde cada termo a partir do terceiro é a soma dos dois anteriores.
 
=begin
Faça um programa que peça ao usuário o número de linhas (termos) que deseja ver da sequencia de fibonacci.
O programa deve calcular e exibir cada termo da sequencia, um por linha, utilizando recursividade.

Exemplo:
Digite quantas linhas você deseja que a sequência possua: 
5
----------
Sequência:
0
1
1
2
3
=end

# $i = 0
# def imprimir(max, atual, proximo)
#   if $i >= max
#     return
#   end

#   puts atual
#   aux = atual + proximo

#   $i += 1
#   imprimir(max, proximo, aux)
# end

def fibonacci(n)
  if n <= 0
    return 0
  end

  if n == 1
    return 1
  end

  fibonacci(n - 1) + fibonacci(n - 2)
end

def imprime(max)
  i = 0
  while(i < max)
    puts fibonacci(i)
    i += 1
  end
end

puts "\nDigite quantas linhas você deseja que a sequência possua: "
max = gets.chomp.to_i

puts "\nSequência: "
imprime(max)
