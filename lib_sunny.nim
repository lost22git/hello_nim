#[

  [sunny](https://github.com/guzba/sunny)

  `nimble install sunny`

]#

import sunny

import std/[times]

proc toJson*(v: DateTime, s: var string) =
  s.add '"'
  s.add $v
  s.add '"'

proc fromJson*(v: var DateTime, jv: JsonValue, s: string) =
  let timeStr = s[jv.start + 1 .. (jv.start + jv.len - 1 - 1)]
  v = parse(timeStr, "yyyy-MM-dd'T'HH:mm:sszzz", utc())

type Book = object
  name: string
  tags {.json: ",omitempty".}: seq[string]
  price {.json: ",omitempty".}: float
  publishTime {.json: "publish_time,omitempty".}: DateTime

let book = Book(
  name: "Compilers: Principles, Techniques, and Tools",
  tags: @["Programming", "Computer"],
  price: 0'd,
  publishTime: datetime(2007, mJul, 7, zone = utc()),
)

echo "json: ", book.toJson()

echo "book: ", Book.fromJson(book.toJson())
