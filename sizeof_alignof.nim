#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/[tables]

#[
  - sizeof:  查看 type 在 stack 内存大小
  - alignof: 查看 type 在 stack 内存对齐
  - offsetof: 查看 field 在 type 中内存偏移量
]#

# primitive

doAssert sizeof(byte) == 1
doAssert alignof(byte) == 1

doAssert sizeof(char) == 1
doAssert alignof(char) == 1

doAssert sizeof(int) == 8
doAssert alignof(int) == 8

doAssert sizeof(Natural) == 8
doAssert alignof(Natural) == 8

doAssert sizeof(uint32) == 4
doAssert alignof(uint32) == 4

doAssert sizeof(float) == 8
doAssert alignof(float) == 8

# Slice
doAssert sizeof(Slice[int]) == 2 * 8
doAssert alignof(Slice[int]) == 8
doAssert offsetof(Slice[int], a) == 0
doAssert offsetof(Slice[int], b) == 8

# HSlice
doAssert sizeof(HSlice[int, string]) == 8 + 16
doAssert alignof(HSlice[int, string]) == 8
doAssert offsetof(HSlice[int, string], a) == 0
doAssert offsetof(HSlice[int, string], b) == 8

# openArray
doAssert sizeof(openArray[int]) == 16
doAssert alignof(openArray[int]) == 8
# doAssert offsetof(openArray[int], len) == 0
# doAssert offsetof(openArray[int], data) == 8

# array
doAssert sizeof(array[4, int]) == 4 * 8
doAssert alignof(array[4, int]) == 8

# tuple
doAssert sizeof(tuple[x: int, y: int, z: int]) == 3 * 8
doAssert alignof(tuple[x: int, y: int, z: int]) == 8
doAssert offsetof(tuple[x: int, y: int, z: int], x) == 0
doAssert offsetof(tuple[x: int, y: int, z: int], y) == 8
doAssert offsetof(tuple[x: int, y: int, z: int], z) == 16

# string
# https://github.com/nim-lang/Nim/blob/devel/lib/system/strs_v2.nim
doAssert sizeof(string) == 16
doAssert alignof(string) == 8
# doAssert offsetof(string, len) == 0
# doAssert offsetof(string, p) == 8

# seq
# https://github.com/nim-lang/Nim/blob/devel/lib/system/seqs_v2.nim
# https://github.com/nim-lang/Nim/blob/devel/lib/system/seqs_v2_reimpl.nim
doAssert sizeof(seq[int]) == 16
doAssert alignof(seq[int]) == 8
# doAssert offsetof(string, len) == 0
# doAssert offsetof(string, p) == 8

# table 
# https://github.com/nim-lang/Nim/blob/devel/lib/pure/collections/tables.nim#L209
doAssert sizeof(Table[string, string]) == 24
doAssert alignof(Table[string, string]) == 8
# doAssert offsetof(Table[string, string], data) == 0 # seq[KeyValuePair[A, B]]
# doAssert offsetof(Table[string, string], counter) == 16 # int

# TableRef
doAssert sizeof(TableRef[string, string]) == 8
doAssert alignof(TableRef[string, string]) == 8

# enum
type
  Lang = enum
    langNim
    langJava
    langRust

doAssert sizeof(Lang) == 1
doAssert alignof(Lang) == 1

# object
type
  Account = object
    id: uint32
    name: string
    balance: uint32

doAssert sizeof(Account) == (4 + 4) + 16 + (4 + 4)
doAssert alignof(Account) == 8
doAssert offsetof(Account, id) == 0
doAssert offsetof(Account, name) == 8
doAssert offsetof(Account, balance) == 24

type
  Account2 = object
    id: uint32
    balance: uint32
    name: string

doAssert sizeof(Account2) == 4 + 4 + 16
doAssert alignof(Account2) == 8
doAssert offsetof(Account2, id) == 0
doAssert offsetof(Account2, balance) == 4
doAssert offsetof(Account2, name) == 8

# object ref
type AccountRef = ref Account
doAssert sizeof(AccountRef) == 8
doAssert alignof(AccountRef) == 8
doAssert offsetof(AccountRef, id) == 0
doAssert offsetof(AccountRef, name) == 8
doAssert offsetof(AccountRef, balance) == 24

# object packed
type
  AccountPacked {.packed.} = object
    id: uint32
    name: string
    balance: uint32

doAssert sizeof(AccountPacked) == 4 + 16 + 4
doAssert alignof(AccountPacked) == 1
doAssert offsetof(AccountPacked, id) == 0
doAssert offsetof(AccountPacked, name) == 4
doAssert offsetof(AccountPacked, balance) == 20
