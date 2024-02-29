#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

type User = object
  firstName: string
  lastName: string

type UserView = object
  firstName: string
  lastName: string

converter toUserView(user: User): UserView =
  result.firstName = user.firstName
  result.lastName = user.lastName

proc printView(userView: UserView) =
  echo userView.repr

let user = User(firstName: "foo", lastName: "bar")
printView user # auto convert `User` to `UserView`
