import std/[strformat]
import std/[macros, genasts]

template `===`(title: static[string]) =
  block:
    let t {.inject.} = title
    echo fmt"--{t:-<30}"

## Ast

macro testGenAst(range, i, body: untyped): untyped =
  result =
    genAst(range, i, body):
      for i in range:
        body

macro testQuote(range, i, body: untyped): untyped =
  result =
    quote:
      for `i` in `range`:
        `body`

template testTemplate(range, i, body: untyped) =
  for i in range:
    body

# dumpAstGen:
#   for i in range:
#     body
macro testAstConstruct(range, i, body: untyped): untyped =
  result = nnkStmtList.newTree(nnkForStmt.newTree(i, range, body))

var items = 5..10

==="test gen ast"
testGenAst items, item:
  echo fmt"{item = }"

==="test quote"
testQuote items, item:
  echo fmt"{item = }"

==="test template"
testTemplate items, item:
  echo fmt"{item = }"

==="test ast construct"
testAstConstruct items, item:
  echo fmt"{item = }"
