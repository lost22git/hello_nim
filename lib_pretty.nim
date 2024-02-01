#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

import pretty

import std/[json, jsonutils, sequtils]

#[
  
  [pretty](https://github.com/treeform/pretty)

  `nimble install pretty`

]#

type
  Book = object
    name: string
    tags: seq[string]
    price: float

let
  books =
    @[
      Book(name: "Shi Ji", tags: @["History", "China"], price: 66'd),
      Book(
        name: "The Mathematical Principles of Natural Philosophy",
        tags: @["Math", "Physical"],
        price: 77'd,
      ),
      Book(
        name: "Compilers: Principles", tags: @["Computer", "Programming"], price: 88'd
      )
    ]

print toJson(books)

print books

printTable books

printBarChart books.mapIt((it.name, it.price))
