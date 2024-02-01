#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/[tables]

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

# HSlice
doAssert sizeof(HSlice[int, string]) == 8 + 16
doAssert alignof(HSlice[int, string]) == 8

# openArray
doAssert sizeof(openArray[int]) == 16
doAssert alignof(openArray[int]) == 8

# array
doAssert sizeof(array[4, int]) == 4 * 8
doAssert alignof(array[4, int]) == 8

# tuple
doAssert sizeof(tuple[x: int, y: int, z: int]) == 3 * 8
doAssert alignof(tuple[x: int, y: int, z: int]) == 8

# string
doAssert sizeof(string) == 16
doAssert alignof(string) == 8

# seq
doAssert sizeof(seq[int]) == 16
doAssert alignof(seq[int]) == 8

# table
doAssert sizeof(Table[string, string]) == 24
doAssert alignof(Table[string, string]) == 8

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

type
  Account2 = object
    id: uint32
    balance: uint32
    name: string

doAssert sizeof(Account2) == 4 + 4 + 16
doAssert alignof(Account2) == 8

# object ref
type AccountRef = ref Account
doAssert sizeof(AccountRef) == 8
doAssert alignof(AccountRef) == 8

# object packed
type
  AccountPacked {.packed.} = object
    id: uint32
    name: string
    balance: uint32

doAssert sizeof(AccountPacked) == 4 + 16 + 4
doAssert alignof(AccountPacked) == 1
