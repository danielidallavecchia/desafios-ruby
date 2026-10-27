# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#****************************************************
# Usuarios: 
Usuario.create([
  {
    # 1
    :nome => "Administrador Teste",
    :email => "admin@admin.com",
    :senha => "admin123",
    :data_nascimento => "2001-01-01"
  },
  {
    # 2
    :nome => "Ana Luisa de Souza",
    :email => "ana@admin.com",
    :senha => "admin123",
    :data_nascimento => "2012-07-15"
  },
  {
    # 3
    :nome => "Maria do Carmo",
    :email => "maria@admin.com",
    :senha => "admin123",
    :data_nascimento => "1985-11-30"
  },
  {
    # 4
    :nome => "Joana do Nascimento",
    :email => "joana@admin.com",
    :senha => "admin123",
    :data_nascimento => "2013-10-27"
  },
  {
    # 5
    :nome => "Beatriz Oliveira",
    :email => "beatriz@admin.com",
    :senha => "admin123",
    :data_nascimento => "2001-01-01"
  },
  {
    # 6
    :nome => "Marli Padilha",
    :email => "marli@admin.com",
    :senha => "admin123",
    :data_nascimento => "1976-01-31"
  },
  {
    # 7
    :nome => "Amanda Mello",
    :email => "amanda@admin.com",
    :senha => "admin123",
    :data_nascimento => "2002-09-21"
  },
  {
    # 8
    :nome => "Clarice de Paula Luz",
    :email => "clarice@admin.com",
    :senha => "admin123",
    :data_nascimento => "1990-10-29"
  },
  {
    # 9
    :nome => "Camila Miranda",
    :email => "camila@admin.com",
    :senha => "admin123",
    :data_nascimento => "2008-12-11"
  },
  {
    # 10
    :nome => "Elen Soares",
    :email => "elen@admin.com",
    :senha => "admin123",
    :data_nascimento => "2005-02-20"
  }
])

#****************************************************
# Contatos:

# contatos pra usuario 1 - ids: 1,2,3,4,5
Contato.create([
  {
  :nome => "Ana Julia",
  :sobrenome => "da Silva",
  :usuario_id => 1
  },
  {
  :nome => "Bela Antonia",
  :sobrenome => "Soares",
  :usuario_id => 1
  },
  {
  :nome => "Flora",
  :sobrenome => "Teixira Dias",
  :usuario_id => 1
  },
  {
  :nome => "Eduarda",
  :sobrenome => "Souza Souza",
  :usuario_id => 1
  },
  {
  :nome => "Alba",
  :sobrenome => "Teixeira de Matos",
  :usuario_id => 1
  }
])

# contatos pra usuario 2 - ids: 6,7,8
Contato.create([
  {
  :nome => "Alba",
  :sobrenome => "Cardoso Fernandes",
  :usuario_id => 2
  },
  {
  :nome => "Maria Helena",
  :sobrenome => "Dias da Luz",
  :usuario_id => 2
  },
  {
  :nome => "Coralina",
  :sobrenome => "Nunes",
  :usuario_id => 2
  }
])

# contatos pra usuario 3 - ids: 9,10,11
Contato.create([
  {
  :nome => "Alana",
  :sobrenome => "Antunes de Lima",
  :usuario_id => 3
  },
  {
  :nome => "Simone",
  :sobrenome => "Sabrina da Cruz",
  :usuario_id => 3
  },
  {
  :nome => "Tais",
  :sobrenome => "Melo Parizoto",
  :usuario_id => 3
  }
])

# contatos pra usuario 4 - ids: 12,13,14
Contato.create([
  {
  :nome => "Mel",
  :sobrenome => "Maia Moreira",
  :usuario_id => 4
  },
  {
  :nome => "Lara",
  :sobrenome => "Dias do Nascimento",
  :usuario_id => 4
  },
  {
  :nome => "Julia",
  :sobrenome => "Pereira Souza",
  :usuario_id => 4
  }
])

# contatos pra usuario 5 - ids: 15,16,17
Contato.create([
  {
  :nome => "Iara",
  :sobrenome => "Aparecida da Rocha",
  :usuario_id => 5
  },
  {
  :nome => "Maria Leticia",
  :sobrenome => "Ferraz",
  :usuario_id => 5
  },
  {
  :nome => "Pamela",
  :sobrenome => "Raimundi Matos",
  :usuario_id => 5
  }
])

# contatos pra usuario 6 - ids: 18,19,20
Contato.create([
  {
  :nome => "Jade",
  :sobrenome => "Soares Carvalho",
  :usuario_id => 6
  },
  {
  :nome => "Daiane",
  :sobrenome => "Gomes de Araujo",
  :usuario_id => 6
  },
  {
  :nome => "Andreia",
  :sobrenome => "Pereira dos Santos",
  :usuario_id => 6
  }
])

# contatos pra usuario 7 - ids: 21,22
Contato.create([
  {
  :nome => "Gabriela",
  :sobrenome => "Almeida da Costa",
  :usuario_id => 7
  },
  {
  :nome => "Raiane",
  :sobrenome => "Ferreira da Silva",
  :usuario_id => 7
  }
])

# contatos pra usuario 8 - ids: 23,24
Contato.create([
  {
  :nome => "Livia Maria",
  :sobrenome => "Ramos da Mota",
  :usuario_id => 8
  },
  {
  :nome => "Ivone",
  :sobrenome => "Rodrigues de Andrade",
  :usuario_id => 8
  }
])

# contatos pra usuario 9 - ids: 25,26
Contato.create([
  {
  :nome => "Mariana",
  :sobrenome => "Pires Paiva",
  :usuario_id => 9
  },
  {
  :nome => "Maria Gabriela",
  :sobrenome => "da Luz Piana",
  :usuario_id => 9
  }
])

# contatos pra usuario 10 - ids: 27,28
Contato.create([
  {
  :nome => "Flora",
  :sobrenome => "Neves de Brito",
  :usuario_id => 10
  },
  {
  :nome => "Luana",
  :sobrenome => "Lins",
  :usuario_id => 10
  }
])

#****************************************************
# Telefones: 

Telefone.create([
  {
    :ddd => "49",
    :numero => "998562358",
    :contato_id => 1
  },
  {
    :ddd => "11",
    :numero => "965223000",
    :contato_id => 1
  },
  {
    :ddd => "52",
    :numero => "974747474",
    :contato_id => 1
  },
  {
    :ddd => "48",
    :numero => "988563201",
    :contato_id => 1
  },
  {
    :ddd => "51",
    :numero => "932654512",
    :contato_id => 2
  },
  {
    :ddd => "53",
    :numero => "987454554",
    :contato_id => 2
  },
  {
    :ddd => "49",
    :numero => "923560021",
    :contato_id => 3
  },
  {
    :ddd => "71",
    :numero => "987458588",
    :contato_id => 3
  },
  {
    :ddd => "49",
    :numero => "996325478",
    :contato_id => 4
  },
  {
    :ddd => "48",
    :numero => "965451202",
    :contato_id => 4
  },
  {
    :ddd => "53",
    :numero => "963635241",
    :contato_id => 5
  },
  {
    :ddd => "11",
    :numero => "987878456",
    :contato_id => 5
  },
  {
    :ddd => "47",
    :numero => "963258745",
    :contato_id => 6
  },
  {
    :ddd => "82",
    :numero => "995623001",
    :contato_id => 6
  },
  {
    :ddd => "48",
    :numero => "999998520",
    :contato_id => 7
  },
  {
    :ddd => "19",
    :numero => "974582003",
    :contato_id => 8
  },
  {
    :ddd => "71",
    :numero => "963365528",
    :contato_id => 9
  },
  {
    :ddd => "49",
    :numero => "995874566",
    :contato_id => 10
  },
  {
    :ddd => "52",
    :numero => "963014785",
    :contato_id => 11
  },
  {
    :ddd => "11",
    :numero => "963258749",
    :contato_id => 12
  },
  {
    :ddd => "86",
    :numero => "965656598",
    :contato_id => 13
  },
  {
    :ddd => "63",
    :numero => "978452365",
    :contato_id => 14
  },
  {
    :ddd => "91",
    :numero => "956568740",
    :contato_id => 15
  },
  {
    :ddd => "11",
    :numero => "963021547",
    :contato_id => 16
  },
  {
    :ddd => "48",
    :numero => "998536598",
    :contato_id => 17
  },
  {
    :ddd => "52",
    :numero => "988523650",
    :contato_id => 18
  },
  {
    :ddd => "53",
    :numero => "987452004",
    :contato_id => 19
  },
  {
    :ddd => "68",
    :numero => "902136547",
    :contato_id => 20
  },
  {
    :ddd => "21",
    :numero => "950201203",
    :contato_id => 21
  },
  {
    :ddd => "38",
    :numero => "963025874",
    :contato_id => 22
  },
  {
    :ddd => "49",
    :numero => "945458778",
    :contato_id => 23
  },
  {
    :ddd => "53",
    :numero => "987200144",
    :contato_id => 24
  },
  {
    :ddd => "48",
    :numero => "978451203",
    :contato_id => 25
  },
  {
    :ddd => "33",
    :numero => "987959879",
    :contato_id => 26
  },
  {
    :ddd => "11",
    :numero => "999658990",
    :contato_id => 27
  },
  {
    :ddd => "49",
    :numero => "995236841",
    :contato_id => 28
  }
])

#****************************************************
# Usuários aleatórios sem vínculos

# 15.times do |i|
#   Usuario.create(
#     :nome => "Usuário ##{i} Teste",
#     :email => "usuario#{i}@admin.com",
#     :senha => "admin123",
#     :data_nascimento => "2001-01-01"
#   )
# end

#****************************************************
