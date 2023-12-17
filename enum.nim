import std/[strformat, strutils]
import std/[enumutils]

## symbolRank symbolName ord $

template printEnumMembers(E: typedesc[enum]) =
  echo "=".repeat 40
  for i in E.items:
    block:
      let i {.inject.} = i
      echo fmt"{i.symbolRank}: {i.symbolName} -> ord: {i.ord}, $: {i}"

type FuturesExchange = enum
  SHFE = (10, "上海期货交易所")
  DCE = ("大连期货交易所")
  CFFEX = ("中金所")

type Color = enum
  red
  green
  blue

printEnumMembers FuturesExchange
printEnumMembers Color

## parse from string

assert parseEnum[FuturesExchange]("中金所") == CFFEX
assert parseEnum[FuturesExchange]("xxx", SHFE) == SHFE

## enum len

import std/[typetraits]
assert FuturesExchange.enumLen == 3
assert COlor.enumLen == 3

## Flags

type
  MyFlag* {.size: sizeof(int8).} = enum
    A
    B
    C
    D

  MyFlags = set[MyFlag]

proc toNum(f: MyFlags): int =
  cast[int8](f)

proc toFlags(v: int8): MyFlags =
  cast[MyFlags](v)

assert toNum({}) == 0
assert toNum({A}) == 1
assert toNum({D}) == 8
assert toNum({A, C}) == 5
assert toFlags(0) == {}
assert toFlags(7) == {A, B, C}
