#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

#[ 

Table (HashMap)

refer: https://github.com/nim-lang/Nim/blob/devel/lib/pure/collections/hashcommon.nim

hash 冲突: open-address

容量扩张:
   when: len / cap > 2/3 (0.67)
   factor: 2

如果不指定 cap, 默认初始化 cap: 64
如果指定 cap n, 则 cap: nextPowerOfTwo(n * 3 div 2 + 4)

]#

## ------ 验证程序 -------------------------

import std/[tables]
import std/[typeinfo]
import std/[strformat]

proc getTableCap[K, V](t: var Table[K, V]): int =
  var a = t.toAny()
  result = a["data"].len()

proc getTableLen[K, V](t: Table[K, V]): int =
  t.len()

template printTableMeta(t) =
  echo "len: " & $(t.getTableLen()) & ", cap: " & $(t.getTableCap())

var t = initTable[string, int](1)
printTableMeta t
for i in 1..5:
  t[fmt"{i}"] = i
printTableMeta t
t["6"] = 6
printTableMeta t
for i in 7..11:
  t[fmt"{i}"] = i
printTableMeta t
t["12"] = 12
printTableMeta t
