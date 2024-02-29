#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import jsony
import std/[times]

#[

  [jsony](https://github.com/treeform/jsony)

  `nimble install jsony`

]#

proc dumpHook*(s: var string, v: DateTime) =
  s.add '"'
  s.add $v
  s.add '"'

proc parseHook*(s: string, i: var int, v: var DateTime) =
  var str: string
  parseHook(s, i, str)
  v = parse(str, "yyyy-MM-dd'T'HH:mm:sszzz", utc())

type Book = object
  name: string
  tags: seq[string]
  price: float
  publishTime: DateTime

let book = Book(
  name: "Compilers: Principles, Techniques, and Tools",
  tags: @["Programming", "Computer"],
  price: 27.22'd,
  publishTime: datetime(2007, mJul, 7, zone = utc()),
)

echo "json: ", book.toJson()

echo "book: ", book.toJson().fromJson(Book)
