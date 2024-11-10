import asyncdispatch
import strformat
import os

# Simula uma tarefa assíncrona que demora um tempo para completar
proc demorarECompletarTarefa(id: int, tempoEspera: int): Future[string] {.async.} =
    echo fmt"Iniciando tarefa {id}..."
    await sleepAsync(tempoEspera)
    return fmt"Tarefa {id} completada após {tempoEspera}ms!"

# Executa múltiplas tarefas assíncronas
proc executarTarefas() {.async.} =
    echo "Iniciando execução de tarefas..."
    
    # Criar várias tarefas que serão executadas concorrentemente
    let tarefa1 = demorarECompletarTarefa(1, 2000)  # 2 segundos
    let tarefa2 = demorarECompletarTarefa(2, 1000)  # 1 segundo
    let tarefa3 = demorarECompletarTarefa(3, 3000)  # 3 segundos
    
    # Aguardar a conclusão das tarefas e obter resultados
    let resultado1 = await tarefa1
    let resultado2 = await tarefa2
    let resultado3 = await tarefa3
    
    # Mostrar resultados
    echo "\nResultados:"
    echo resultado1
    echo resultado2
    echo resultado3
    
    echo "\nTodas as tarefas foram concluídas!"

# Executar o programa
echo "Programa iniciado"
waitFor executarTarefas()
echo "Programa finalizado"