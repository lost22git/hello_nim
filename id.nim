#[
///usr/bin/env nim r "$0" "$@" ; exit $?
]#

let `let` = "你好"
doAssert `let` == "你好"
