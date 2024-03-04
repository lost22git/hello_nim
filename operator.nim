#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

doAssert 3 / 2 == 1.5
# div truncate
doAssert 3 div 2 == 1
doAssert -3 div -2 == 1
doAssert -3 div 2 == -1
doAssert 3 div -2 == -1
doAssert 3 mod 2 == 1
doAssert -3 mod -2 == -1
doAssert -3 mod 2 == -1
doAssert 3 mod -2 == 1

# unsigned: circular by default
# signed: OverflowDefect by default, `+%`,`-%`,`*%`,`/%` to circular
doAssert 255'u8 + 1'u8 == 0
doAssert 127'i8 +% 1'i8 == -128
doAssertRaises(OverflowDefect):
  discard 127'i8 + 1'i8

doAssert 0'u8 - 1'u8 == 255
doAssert -128'i8 -% 1'i8 == 127
doAssertRaises(OverflowDefect):
  discard -128'i8 - 1'i8

# unsigned comparation
# 对操作数进行 unsigned 处理，然后进行比较
#
# | x `<%` y  | unsigned(x) < unsigned(y)  |
# | x `>%` y  | unsigned(x) > unsigned(y)  |
# | x `<=%` y | unsigned(x) <= unsigned(y) |
# | x `>=%` y | unsigned(x) >= unsigned(y) |

doAssert 1'i8 <% 2'i8
doAssert -2'i8 <% -1'i8
doAssert 127'i8 <% -128'i8 # 127'u8 < 128'u8
doAssert 128'i16 <% -128'i8 # 128'u16 < (uint16.high + 1 - 128)
