#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/[sugar]
import std/[strutils]

#[

nil

值可能为 nil 的类型：ref / ptr / proc

nil handling

1) Option
2) ?

]#

## ------ Option -----------------------

import std/[options]

doAssert some("foo").isSome

doAssert none(string).isNone

# get lent
doAssert some("foo").get() == "foo"

# get var 
var a = some("foo")
a.get().addr()[] = "bar"
doAssert a.get() == "bar"

# get or default
doAssert none(string).get("foo") == "foo"

# get raise
doAssertRaises(UnpackDefect):
  discard none(string).get()

doAssert some("foo").filter(v => v.startswith("o")) == none(string)

doAssert some("foo").map(v => v.len()) == some(3)

proc doFlatmap(v: string): Option[int] =
  some(v.len())

doAssert some("foo").flatMap(doFlatmap) == some(3)

doAssert some("foo").map(v => some(v.len())).flatten() == some(3)

## ------ ? ----------------------------
import std/[wrapnils]

type P = ref object
  name: ref string
  age: int

let p: P = nil
doAssert ?.p.name == nil
doAssert ?.p.name[].len() == 0
doAssert ??.p.name == none(ref string)
doAssert ?.p.age == 0
doAssert ??.p.age == none(int)
