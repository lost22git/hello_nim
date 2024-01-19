# @[] 创建seq
doAssert @[1, 2, 3].len == 3
doAssert @[1, 2, 3].capacity == 3

# 分配指定长度的seq
doAssert newSeq[int](10).len == 10
doAssert newSeq[int](10).capacity == 10
for e in newSeq[int](10):
  doAssert e == default int

# 分配指定cap的seq
doAssert newSeqOfCap[int](10).capacity == 10
doAssert newSeqOfCap[int](10).len == 0

# 分配指定长度的seq, 并全部元素设置为指定的值
import std/[sequtils]
doAssert newSeqWith(10, 1).len == 10
doAssert newSeqWith(10, 1).capacity == 10
for e in newSeqWith(10, 1):
  doAssert e == 1

# resize
import std/strformat
var a: seq[int] = @[]
for i in 1..10:
  echo fmt"cap: {a.capacity}, len: {a.len}"
  a.add 1
