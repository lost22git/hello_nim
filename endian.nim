#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

# import std/endians

proc intToBytes() =
  var a = 257'u32 # in general, store with littleEndian [1,1,0,0]
  var b: array[4, uint8] # but we use bigEndian [0,0,1,1]

  # bigEndian32(b.addr, a.addr) # can not work on js backend
  b = [(a shr 24).uint8, (a shr 16).uint8, (a shr 8).uint8, a.uint8]

  assert b == [uint8 0, 0, 1, 1]

proc bytesToInt() =
  var a: array[4, uint8] = [uint8 0, 0, 1, 1]
  var b: uint32

  # bigEndian32(b.addr, a.addr)

  # b = (a[0].uint32 shl 24) + (a[1].uint32 shl 16) + (a[2].uint32 shl 8) + (a[3].uint32)
  # or
  for i in a:
    b = (b shl 8) + i.uint32

  assert b == 257'u32

intToBytes()
bytesToInt()
