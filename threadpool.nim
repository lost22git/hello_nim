#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/[strformat]
import std/[os]
import std/[monotimes, times]

## NOTE：官方不推荐使用 std/threadpool
import std/[threadpool]

{.experimental: "parallel".}

proc doSleep(i: Natural) =
  echo fmt"[{i}] {getThreadId() = }"
  sleep 3000

let st = getMonoTime()

parallel:
  for i in 0 ..< 10:
    spawn doSleep(i)

let ed = getMonoTime()

echo fmt"elapsed: {(ed-st).inMilliseconds}ms"

## 推荐使用：
## [RFC: task-parallelism-api](https://github.com/nim-lang/RFCs/issues/347#task-parallelism-api)
## malebolgia
## weave
