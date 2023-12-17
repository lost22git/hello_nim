import std/[strformat, strutils]

#[ 
object 类型：
* 值类型 object
* 引用类型 ref object
* 指针类型 ptr object
]#

# 值类型 final type (不可被继承)
type Name = object
  firstName: string
  lastName: string

# 值类型 可被继承
type Person = object of RootObj
  name: Name
  age: Natural

# distinct type
type UID {.borrow: `.`.} = distinct uint64

type LoginMethod = enum
  password
  pki

type User = object of Person
  id: UID
  case loginMethod: LoginMethod
  of password:
    password: string
  of pki:
    publicKey: string

# 引用类型 ref type (内存安全，gc)
type UserRef = ref User

# 指针类型 ptr type (内存不安全，无gc, 手动 dealloc)
type UserPtr = ptr User

# `is` `isnot` 测试是否为类实例
assert User() is User
assert User.default is User
assert User.new is UserRef
assert UserRef.new is UserRef
let user = User()
assert user.addr is UserPtr

# `of` 测试是否为子类实例
assert User() of Person
assert User.default of Person
assert User.new of Person
assert user.addr of Person

# get object type name

import std/[typetraits]

assert User().type is typeof(User())
assert User().type.name == "User"

# 遍历 object fields

var u = User()
for fname, fvalue in u.fieldPairs:
  when fname == "id":
    fvalue = UID(1)
assert u.id.int == 1

var uref = User.new
for fname, fvalue in uref[].fieldPairs:
  when fname == "id":
    fvalue = UID(1)
assert uref.id.int == 1

for fname, fvalue in User().fieldPairs:
  block:
    let
      n {.inject.} = fname
      v {.inject.} = fvalue
      t = fvalue.type.name
    echo fmt"{n}:{t} = {v.repr}"

# 反射 Any

import std/[typeinfo]

## get/set field value

var ur = User() # toAny 必须为 var
var uany = ur.toAny

var newId = UID(10) # toAny 必须为 var
uany["id"] = newId.toAny

assert uany["id"].getUInt64 == 10
assert ur.id.int == 10

## AnyKind

var uk = User()
var urk = User.new

assert uk.toAny.kind == akObject
assert urk.toAny.kind == akRef
