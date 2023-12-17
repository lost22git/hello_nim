import std/[strformat]
import std/[os]
import std/typedthreads
import std/[monotimes, times]

## 定义一个 Thread object 局部变量, 然后 add to seq 会报错
## 因为 Thread object 是一个`值类型`, 当定义一个 Thread object 局部变量时，会被分配在 stack，
## 然后 add to seq 时需要将 Thread object 复制到 heap, 但是 Thread object 不支持 copy
##
## 所以如果我们需要管理一组 Thread objects
## 我们需要通过 `newSeq[Thread[void]](len)` 预先将 Thread objects 分配到 heap
## 或者 `array[len, Thread[void]]` 预先将 Thread objects 分配 stack

var threads = newSeq[Thread[void]](10)
# var threads: array[10, Thread[void]]

let st = getMonoTime()

proc doSleep() =
  echo fmt"{getThreadId() = }"
  sleep 3000

for i in 0 ..< threads.high:
  createThread(threads[i], doSleep)

threads.joinThreads

let ed = getMonoTime()

echo fmt"elapsed: {(ed-st).inMilliseconds}ms"
