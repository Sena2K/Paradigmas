import asyncdispatch

proc waitForNextFrame(): Future[void] {.async.} =
    await sleepAsync(100)

proc test() {.async.} =
    for i in 0 ..< 10:
        echo i
        await waitForNextFrame()

when isMainModule:
    waitFor test()
