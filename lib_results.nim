import results
import std/strformat
import std/sugar

#[
  
  [nim-results](https://github.com/arnetheduck/nim-results)

  `nimble install results`

]#

func divide(a, b: int): Result[int, string] =
  if b == 0:
    # auto use result type
    err("divisor: b == 0")
  else:
    ok(a div b)

let r = divide(1, 0)
doAssert r.isErr()
doAssert not r.isOk()

# isOkOr (aka. unlessOk) / isErrOr (aka. unlessErr)
Result[int, void].err().isOkOr:
  echo "got a error"
Result[int, void].ok(1).isErrOr:
  echo "got a value"

# contains (aka. ifOK and value == ) / containsError (aka. ifErr and error == )
doAssert Result[int, void].ok(1).contains(1)
doAssert Result[int, string].err("a error").containsError("a error")

# convert to Opt
doAssert Result[int, void].err().optValue() == Opt.none(int)
doAssert Result[int, string].err("a error").optError() == Opt.some("a error")

# get or default value
doAssert Result[int, void].ok(1).get(-1) == 1
doAssert Result[int, void].err().get(-1) == -1

# expect get (aka. get or raise ResultDefect)
doAssert Result[int, void].ok(1).expect("can not get value") == 1
doAssertRaises(ResultDefect):
  discard Result[int, void].err().expect("can not get value")

# try get (aka. get or rasise ResultError)
doAssert Result[int, void].ok(1).tryGet() == 1
doAssertRaises(ResultError[void]):
  discard Result[int, void].err().tryGet()

# map/mapErr
doAssert Result[int, void].ok(1).map(v => v * 10).get() == 10
doAssert Result[int, void].ok(1).mapErr(() => "error").get() == 1
doAssert Result[int, void].err().mapErr(() => "error").error() == "error"

# and
doAssert Result[int, void].ok(1).and(Result[float, void].ok(1'd)).get() == 1'd
doAssert Result[int, void].ok(1).and(Result[float, void].err()).isErr()
doAssert Result[int, void].err().and(Result[float, void].ok(1'd)).isErr()
doAssert Result[int, void].err().and(Result[float, void].err()).isErr()

# or
doAssert Result[int, void].ok(1).or(Result[int, string].ok(2)).get() == 1
doAssert Result[int, void].ok(1).or(Result[int, string].err("error")).get() == 1
doAssert Result[int, void].err().or(Result[int, string].ok(2)).get() == 2
doAssert Result[int, void].err().or(Result[int, string].err("error")).isErr()
