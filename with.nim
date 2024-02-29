#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import std/with
import std/times

type User = object
  name: string
  birthday: DateTime
  age: Natural

var u: User

proc calcAge(t: DateTime): int =
  let now = now().utc
  result = now.year - t.year
  let
    nowDayOfYear = (now - datetime(now.year, mJan, 1, zone = utc())).inDays
    tDayOfYear = (t - datetime(t.year, mJan, 1, zone = utc())).inDays
  if nowDayOfYear < tDayOfYear:
    result -= 1

with u:
  name = "wfoo"
  birthday = dateTime(1991, mApr, 1, zone = utc())
  age = calcAge(u.birthday)

echo u
