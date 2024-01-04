import std/[strformat]

#[
参数传递类型：
* 值传递
* 引用传递
]#

proc `===`(title: string) =
  echo fmt"--{title:-<30}"

type Fighter = object
  name: string = "Ken"
  skill: seq[string]

proc testImmut(v: Fighter) =
  # v.skill.add "hadouken" # 不允许修改
  echo fmt"testImmut: {v.repr =}"

proc testMut(v: var Fighter) =
  v.skill.add "hadouken"
  echo fmt"testMut: {v.repr =}"

proc testCopy(v: sink Fighter) =
  v.skill.add "hadouken"
  echo fmt"testCopy: {v.repr =}"

proc testRef(v: ref Fighter) =
  v.skill.add "hadouken"
  echo fmt"testRef: {v.repr =}"

proc testPtr(v: ptr Fighter) =
  v[].skill.add "hadouken"
  echo fmt"testPtr: {v.repr =}"

==="testImmut"

let toImmut = Fighter()
echo fmt"{toImmut.repr =}"
toImmut.testImmut()
echo fmt"{toImmut.repr =}"

==="testMut"

var toMut = Fighter()
echo fmt"{toMut.repr =}"
toMut.testMut()
echo fmt"{toMut.repr =}"

==="testCopy"

let toCopy = Fighter()
echo fmt"{toCopy.repr =}"
toCopy.testCopy()
echo fmt"{toCopy.repr =}"

==="testRef"

let toRef = Fighter.new()
echo fmt"{toRef.repr =}"
toRef.testRef()
echo fmt"{toRef.repr =}"

==="testPtr"

let
  a = Fighter()
  toPtr = a.addr
echo fmt"{toPtr.repr =}"
toPtr.testPtr()
echo fmt"{toPtr.repr =}"
