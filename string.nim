import std/[unicode, strutils, strformat]

proc `===`(title: string) =
  echo fmt"--{title:-<30}"

==="字符串连接"

echo "你好" & "，" & "世界"

==="字符串格式化"

let str = "世界"

echo "你好，$1" % str

echo fmt"你好，{str}"

echo fmt("你好，<str>", '<', '>')

==="字符串表示"

let v = @["你好", "世界"]
echo $v
echo fmt"debug: {v = }"
echo fmt"repr: { v.repr }"

==="多行字符串"

echo """
你好
世界"""

==="raw 字符串"

echo r"D:\learning\nim"

==="动态字符串"

var sb: string = "你好"

sb.add "，"
sb.add "世界"

echo sb

==="字符串长度"

echo fmt"`{sb}` 字节长度: {sb.len}"

echo fmt"`{sb}` rune长度: {sb.runeLen}"

==="字符串 sub string"

var
  substrOrigin = "你好"
  substr = substrOrigin[0..^1] # 复制指定范围的字符到新字符串

echo fmt"{substrOrigin = }"
echo fmt"{substr = }"
assert substrOrigin == substr

substrOrigin[0..^1] = "世界" # 修改原来的字符串

echo fmt"{substrOrigin = }"
echo fmt"{substr = }"
assert substrOrigin != substr

==="字符串解析"

import std/[nre]

var
  csv =
    """
nim,gc,native code
rust,no gc,native code
java,gc,bytecode
"""

when not defined(windows):
  ==="正则表达式 pcre"
  let
    pattern = re"(.+),(.+),(.+)\r?\n"
    captureCount = pattern.captureCount

  for m in csv.findIter(pattern):
    echo "=".repeat 30
    let
      captures = m.captures
      captureBounds = m.captureBounds
    for i in 0..<captureCount:
      let
        cap = captures[i]
        capBound = captureBounds[i]
      echo fmt"[{i}]: {capBound} -> {cap}"
else:
  ==="strscans"
  import std/[strscans]
  var language, mm, compilationProduct: string
  for line in csv.splitLines:
    if line.scanf("$w,$w,$w", language, mm, compilationProduct):
      echo fmt"{language = }, {mm = }, {compilationProduct = }"
