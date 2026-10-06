
## Prática: exercícios extras no Edabit

require 'pp'

#############################################################
# Exercício 1: Organize títulos e nomes de autores
# https://edabit.com/pt/challenge/5sy4uY4BbhKKFupWR

def tidy_books(arr)
  resposta = []

  for i in 0.. arr.size-1
    for j in 0..arr[i].size-1
      ## strip remove espaços no inicio e fim
      resposta << arr[i][j].strip.split(" - ") 
    end
  end

  return resposta
end

#############################################################
# Exercício 2: Soma dos números ausentes
# https://edabit.com/pt/challenge/bxRuZBwgqFQKoCxzp

def sum_missing_numbers(arr)
  arr = arr.sort
  soma = 0

  for i in 0...arr.size-1
    if (arr[i+1] - arr[i]) > 1
      # há intervalo entre valores, então percorre o intervalo somando
      for i in arr[i]+1...arr[i+1]
        soma += i
      end
    end
  end

  return soma
end

#############################################################
# Exercício 3: Obter o estudante com a melhor média nas provas
# https://edabit.com/pt/challenge/ALrBpait7dY5W49oJ

def get_best_student(students)
  # reduce = percorre uma coleção acumulando um único resultad
  # first = retorna o primeiro elemento de um array
  students.max_by { |_name, grades| grades.reduce(:+) }.first(1)
end

#############################################################
# Exercício 4: Parênteses corretos
# https://edabit.com/pt/challenge/33zJKRPbGW9CRoKWM

def brackets(exp)
  exp = exp.delete("^()") # remove tudo oq nao for parenteses
  pilha = []

  for i in 0..exp.size-1
    c = exp[i]

    if c == "("
      # abertura: empilha
      pilha.push(c)
    elsif c == ")"
      # fechamento: precisa existir uma abertura no topo
      return false if pilha.empty?
      # remove, pois deu match entre "(" e ")"
      pilha.pop
    end
  end

  return true if pilha.empty?
  return false
end

#############################################################
# Testes 

puts "\nEXERCICIO 1:"
r = tidy_books([
  ["  The Catcher in the Rye - J. D. Salinger  "],
  ["  Brave New World - Aldous Huxley  "],
  ["  Of Mice and Men - John Steinbeck  "]
])
pp r

puts "\nEXERCICIO 2:"
puts sum_missing_numbers([4, 3, 8, 1, 2])
puts sum_missing_numbers([17, 16, 15, 10, 11, 12])
puts sum_missing_numbers([1, 2, 3, 4, 5])

puts "\nEXERCICIO 3:"
puts get_best_student({
  "John" => [100, 90, 80],
  "Bob" => [100, 70, 80]
})
puts get_best_student({
  "Susan" => [67, 84, 75, 63],
  "Mike" => [87, 98, 64, 71],
  "Jim" => [90, 58, 73, 86]
})

puts "\nEXERCICIO 4:"
puts brackets("(a*(b-c)..... )")
puts brackets(")(a-b-45/7*(a-34))")
puts brackets("sin(90...)+.............cos1)")
