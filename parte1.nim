# parte1.nim
import std/[locks, os]

type
  DadosCompartilhados = object
    lock: Lock
    contador: int

var dadosGlobais: DadosCompartilhados
initLock(dadosGlobais.lock)

proc incrementaContador() {.thread.} =
  withLock dadosGlobais.lock:
    inc(dadosGlobais.contador)
    echo "Contador bateu: ", dadosGlobais.contador
    sleep(100)

proc exemploThreadsBasico() =
  echo "\nIniciando a brincadeira com as threads..."
  
  var threads = allocCStringArray(["", "", "", "", ""])
  var threadsArray: array[5, Thread[void]]
  
  for i in 0..4:
    createThread(threadsArray[i], incrementaContador)
  
  for i in 0..4:
    joinThread(threadsArray[i])
  
  deallocCStringArray(threads)
  
  echo "E o contador fechou em: ", dadosGlobais.contador
  deinitLock(dadosGlobais.lock)

type
  FilaSegura = object
    lock: Lock
    dados: seq[int]
  
  ThreadArgs = object
    fila: ptr FilaSegura

var fila: FilaSegura
initLock(fila.lock)
fila.dados = @[]

proc produtor(args: ThreadArgs) {.thread.} =
  for i in 1..5:
    withLock args.fila[].lock:
      args.fila[].dados.add(i)
      echo "Produtor mandou: ", i
      sleep(200)

proc consumidor(args: ThreadArgs) {.thread.} =
  for i in 1..5:
    withLock args.fila[].lock:
      if args.fila[].dados.len > 0:
        let item = args.fila[].dados.pop()
        echo "Consumidor pegou: ", item
      sleep(150)

proc exemploProdutorConsumidor() =
  echo "\nVamo ver o produtor/consumidor fazendo a mágica..."
  
  var args = ThreadArgs(fila: addr fila)
  
  var 
    threadProdutor: Thread[ThreadArgs]
    threadConsumidor: Thread[ThreadArgs]
  
  createThread(threadProdutor, produtor, args)
  createThread(threadConsumidor, consumidor, args)
  
  joinThread(threadProdutor)
  joinThread(threadConsumidor)
  
  deinitLock(fila.lock)

when isMainModule:
  exemploThreadsBasico()
  exemploProdutorConsumidor()
  echo "\nFoi tudo! Deu bom!"