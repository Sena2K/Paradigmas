import taskpools

proc processarDadosParalelos(dados: seq[int]): seq[int] =
  # Cria um novo pool de tarefas
  var tp = newTaskPool()
  defer: tp.shutdown()  # Garante que o pool será fechado ao final
  
  result = newSeq[int](dados.len)
  
  # Processa os dados em paralelo
  tp.parallelFor i in 0..<dados.len:
    result[i] = dados[i] * dados[i]

  tp.sync()  # Aguarda todas as tarefas terminarem

let dados = @[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
echo "Resultado: ", processarDadosParalelos(dados)