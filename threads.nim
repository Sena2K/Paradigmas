import std/locks
import os

var sharedData: int
var L: Lock

initLock(L)

proc threadFunc() {.thread.} =
  for i in 1..5:
    acquire(L)
    sharedData += 1
    echo "Valor atual: ", sharedData
    sleep(100)
    release(L)

var threads: array[3, Thread[void]]

for i in 0..threads.high:
  createThread(threads[i], threadFunc)

joinThreads(threads)
deinitLock(L)
echo "Valor final: ", sharedData