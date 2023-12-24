import std/[strformat]
import std/[macros, genasts]

template `===`(title: static[string]) =
  block:
    let t {.inject.} = title
    echo fmt"--{t:-<30}"

## Ast

template expectKinds(range, i, body: untyped) =
  expectKind(range, nnkIdent)
  expectKind(i, nnkIdent)
  expectKind(body, nnkStmtList)

macro testGenAst(range, i, body: untyped): untyped =
  expectKinds(range, i, body)
  result =
    genAst(range, i, body):
      for i in range:
        body

macro testQuote(range, i, body: untyped): untyped =
  expectKinds(range, i, body)
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

var items = 5..8

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

==="宏与杂注"
import std/[times, monotimes, os, typedthreads]
proc logEnterProc(procName: string) {.inline.} =
  echo fmt"""{now().utc} ({getThreadId():<6}) | ENTER procName: "{procName}""""

proc logExitProc(procName: string; st: MonoTime; e: ref Exception) {.inline.} =
  if not isNil(e):
    echo fmt"""{now().utc} ({getThreadId():<6}) | EXIT procName: "{procName}", elap: "{(getMonoTime()-st).inMilliseconds}ms", error: "{e.msg}""""
  else:
    echo fmt"""{now().utc} ({getThreadId():<6}) | EXIT procName: "{procName}", elap: "{(getMonoTime()-st).inMilliseconds}ms""""

proc logExitProc[T](procName: string; st: MonoTime; r: T; e: ref Exception) {.inline.} =
  if not isNil(e):
    echo fmt"""{now().utc} ({getThreadId():<6}) | EXIT procName: "{procName}", elap: "{(getMonoTime()-st).inMilliseconds}ms", error: "{e.msg}""""
  else:
    echo fmt"""{now().utc} ({getThreadId():<6}) | EXIT procName: "{procName}", elap: "{(getMonoTime()-st).inMilliseconds}ms", result: "{r.repr}""""

dumpAstGen:
  proc test(): int =
    let st = getMonoTime()
    logEnterProc("test")
    try:
      result = 1
    finally:
      logExitProc[int]("test", st, result, getCurrentException())

macro tracing(p: untyped): untyped =
  expectKind(p, nnkProcDef)
  let
    procName = $(p.name) # proc name
    resultTypeNode = p.params[0]

  let
    newBody =
      nnkStmtList.newTree(
        nnkLetSection.newTree(
          nnkIdentDefs.newTree(
            newIdentNode("_st"),
            newEmptyNode(),
            nnkCall.newTree(newIdentNode("getMonoTime")),
          )
        ),
        nnkCall.newTree(newIdentNode("logEnterProc"), newLit(procName)),
        nnkTryStmt.newTree(
          p.body, # proc old body
          nnkFinally.newTree(
            nnkStmtList.newTree(
              if resultTypeNode.kind == nnkEmpty:
                # the result type of the proc is not exist
                # logExitProc(procName,st,error)
                nnkCall.newTree(
                  newIdentNode("logExitProc"),
                  newLit(procName),
                  newIdentNode("_st"),
                  nnkCall.newTree(newIdentNode("getCurrentException")),
                )
              else:
                # the result type of the proc is T
                # logExitProc[T](procName,st,result,error)
                nnkCall.newTree(
                  nnkBracketExpr.newTree(newIdentNode("logExitProc"), resultTypeNode),
                  newLit(procName),
                  newIdentNode("_st"),
                  newIdentNode("result"),
                  nnkCall.newTree(newIdentNode("getCurrentException")),
                )
            )
          ),
        ),
      )
  p.body = newBody
  result = p

proc testNoResultType(duration: Duration) {.tracing.} =
  sleep duration.inMilliseconds()

proc testResultType(x, y: int): int {.tracing.} =
  sleep 1000
  result = x + y

proc testRaiseError(x, y: int): int {.tracing.} =
  sleep 1000
  raise newException(ValueError, "some error raised")

testNoResultType initDuration(seconds = 1)

discard testResultType(44, 44)

try:
  discard testRaiseError(44, 44)
except:
  discard
