import threadpool
import locks
import os  

type
  MensagemTipo = enum
    mtTexto, mtNumero

  Mensagem = object
    case tipo: MensagemTipo
    of mtTexto:
      texto: string
    of mtNumero:
      numero: int

  Ator = object
    nome: string
    mensagens: seq[Mensagem]
    lock: Lock
    recebeuSair: bool

proc novoAtor(nome: string): Ator =
  result = Ator(
    nome: nome,
    mensagens: @[],
    recebeuSair: false
  )
  initLock(result.lock)

proc enviarMensagem(ator: var Ator, msg: Mensagem) =
  withLock ator.lock:
    ator.mensagens.add(msg)

proc processar(ator: ptr Ator) {.thread.} =
  while not ator[].recebeuSair:
    var msgParaProcessar: seq[Mensagem]
    
    withLock ator[].lock:
      msgParaProcessar = ator[].mensagens
      ator[].mensagens = @[]
    
    for msg in msgParaProcessar:
      case msg.tipo
      of mtTexto:
        echo ator[].nome, " recebeu texto: ", msg.texto
        if msg.texto == "sair":
          ator[].recebeuSair = true
      of mtNumero:
        echo ator[].nome, " recebeu número: ", msg.numero
    
    sleep(100)

var 
  ator1 = novoAtor("Ator1")
  ator2 = novoAtor("Ator2")

var 
  thread1: Thread[ptr Ator]
  thread2: Thread[ptr Ator]

createThread(thread1, processar, addr(ator1))
createThread(thread2, processar, addr(ator2))

ator1.enviarMensagem(Mensagem(tipo: mtTexto, texto: "Olá!"))
ator2.enviarMensagem(Mensagem(tipo: mtNumero, numero: 42))
ator1.enviarMensagem(Mensagem(tipo: mtNumero, numero: 100))
ator2.enviarMensagem(Mensagem(tipo: mtTexto, texto: "Como vai?"))

sleep(1000)

ator1.enviarMensagem(Mensagem(tipo: mtTexto, texto: "sair"))
ator2.enviarMensagem(Mensagem(tipo: mtTexto, texto: "sair"))

joinThread(thread1)
joinThread(thread2)

echo "Programa finalizado!"