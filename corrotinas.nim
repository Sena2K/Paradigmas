import std/[coro, times]

proc Fibonacci(id: int, cochilo: float32) =
    var cochilin: float
    while true:
        echo id, " executando, 'dormindo' por ", cochilin
        suspend(cochilo)
        cochilin = (float(nanosecond(getTime())) - cochilin) / 1_000_000_000

when isMainModule:
    start(proc() = Fibonacci(1, 0.01))
    start(proc() = Fibonacci(2, 0.021))
    run()
